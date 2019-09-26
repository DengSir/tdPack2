-- SortingFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/24/2019, 6:20:07 PM

local type, select = type, select
local format = string.format
local tremove = table.remove

local CreateFrame, ToggleDropDownMenu, CloseDropDownMenus = CreateFrame, ToggleDropDownMenu, CloseDropDownMenus
local GetItemQualityColor, GetItemIcon = GetItemQualityColor, GetItemIcon

local UIParent, GameTooltip = UIParent, GameTooltip
local RED_FONT_COLOR_HEX = RED_FONT_COLOR:GenerateHexColor()
local DEFAULT_ICON = [[Interface\Icons\INV_MISC_QUESTIONMARK]]

local WHERE_AFTER = 1
local WHERE_BEFORE = 2
local WHERE_IN = 3

local ns = select(2, ...)
local Addon = ns.Addon
local L = ns.L

---@class SortingFrame: Frame
---@field private List TreeView
local SortingFrame = Addon:NewClass('SortingFrame', ns.Frame)
ns.SortingFrame = SortingFrame

function SortingFrame:Constructor()
    self.profile = Addon.profile.rules.sorting

    local List = ns.TreeView:Bind(self.List)

    List:SetItemTemplate('tdPack2RuleItemTemplate')
    List:SetItemTree(self.profile)
    List:SetCallback('OnItemFormatting', function(_, ...)
        self:OnItemFormatting(...)
    end)
    List:SetCallback('OnCheckItemCanPutIn', function(_, from, to)
        if type(from) == 'table' then
            return type(to) == 'table'
        else
            return to == self.profile
        end
    end)
    List:SetCallback('OnItemEnter', function(_, button)
        self:ShowRuleTooltip(button, button.item)
    end)
    List:SetCallback('OnItemClick', function(_, button)
        tremove(button.parent, button.index)
        self.List:Refresh()
    end)
    List:SetCallback('OnItemRightClick', function(_, button)
        self:ShowRuleMenu(button, button.item)
    end)
    List:SetCallback('OnItemLeave', GameTooltip_Hide)
    List:SetCallback('OnSorted', function()
        self:SendMessage('TDPACK_SORTING_RULES_UPDATE')
    end)

    self.Reset:SetScript('OnClick', function()
        Addon:ResetSortingRules()
    end)

    local Menu = CreateFrame('Frame', 'tdPack2SortingListMenu', self, 'UIDropDownMenuTemplate')
    UIDropDownMenu_Initialize(Menu, function(frame, level, menuList)
        for i, v in ipairs(menuList) do
            if v.text then
                v.index = i
                UIDropDownMenu_AddButton(v, level)
            else
                UIDropDownMenu_AddSeparator(level)
            end
        end
    end, 'MENU', nil, {})

    self.Menu = Menu
end

function SortingFrame:SetupEvents()
    self:RegisterMessage('TDPACK_SORTING_RULES_UPDATE', 'Refresh')
    self:RegisterMessage('TDPACK_SORTING_RULES_RESET', 'Refresh')
    self:RegisterEvent('GET_ITEM_INFO_RECEIVED', 'Refresh')
    self:RegisterEvent('CURSOR_UPDATE')
    self:CURSOR_UPDATE()
end

function SortingFrame:Refresh()
    self.List:Refresh()
end

function SortingFrame:CURSOR_UPDATE()
    local cursorType, itemId, itemLink = GetCursorInfo()
    if cursorType == 'item' then
        self:StartCursorCatching(itemId)
    else
        self:StopCursorCatching()
    end
end

function SortingFrame:StartCursorCatching(item)
    local catcher = self.cursorCatcher or self:CreateCursorCatcher()
    local exists = tContains(self.profile, item)
    catcher.item = item
    catcher.exists = exists
    catcher.bg:SetShown(exists)
    catcher:SetText(exists and L['Already exists'] or '')
    catcher:Show()
end

function SortingFrame:StopCursorCatching()
    if self.cursorCatcher then
        self.cursorCatcher:Hide()
        self.List:StopSorting()
    end
end

function SortingFrame:CreateCursorCatcher()
    local catcher = CreateFrame('Button', nil, self.List)
    catcher:RegisterForClicks('LeftButtonUp')
    catcher:SetAllPoints(self.List.mouseHolder or self.List)
    catcher:SetFrameLevel(self:GetFrameLevel() + 100)
    catcher:SetNormalFontObject('GameFontHighlightHuge')
    catcher.bg = catcher:CreateTexture(nil, 'BACKGROUND')
    catcher.bg:SetAllPoints(self.List)
    catcher.bg:SetColorTexture(0.3, 0, 0, 0.9)

    local function OnClick(catcher)
        if catcher.exists then
            return
        end
        self.List:CommitSorting()
        ClearCursor()
    end

    local function OnEnter(catcher)
        if not catcher.item or catcher.exists then
            return
        end
        local x, y = ns.GetCursorPosition()
        local button = self.List:AllocButton()

        button.index = nil
        button.parent = nil
        button.item = catcher.item
        button:SetWidth(self.List:GetWidth(), self.List.itemHeight)
        button:SetParent(UIParent)
        button:ClearAllPoints()
        button:SetPoint('BOTTOMLEFT', x - button:GetWidth() / 2, y - button:GetHeight() / 2)

        self:OnItemFormatting(button, button.item, 1)
        self.List:StartSorting(button)
    end

    local function OnLeave()
        if catcher:IsShown() then
            self.List:StopSorting()
        end
    end

    catcher:SetScript('OnClick', OnClick)
    catcher:SetScript('OnReceiveDrag', OnClick)
    catcher:SetScript('OnEnter', OnEnter)
    catcher:SetScript('OnLeave', OnLeave)
    self.List:SetCallback('OnSortingOut', OnLeave)

    self.cursorCatcher = catcher
    return catcher
end

function SortingFrame:OnItemFormatting(button, item, depth)
    local name, icon, rule = self:GetRuleInfo(item)

    button.Text:SetPoint('LEFT', 5 + 20 * (depth - 1), 0)
    button.Text:SetText(format('|T%s:14|t %s', icon, name))
    button.Rule:SetText(rule or '')
end

function SortingFrame:ShowRuleTooltip(button, item)
    GameTooltip:SetOwner(button, 'ANCHOR_RIGHT')
    if type(item) == 'number' then
        GameTooltip:SetHyperlink('item:' .. item)
    elseif type(button.item) == 'table' then
        if item.comment then
            GameTooltip:AddLine(item.comment)
        end
        if item.rule then
            GameTooltip:AddLine(item.rule, 1, 1, 1)
        end
    end
    GameTooltip:Show()
end

function SortingFrame:GetRuleInfo(item)
    local t = type(item)
    if t == 'number' then
        local quality, color
        local name, _, _, _, _, quality = ns.GetItemInfo(item)
        color = name and quality and select(4, GetItemQualityColor(quality)) or RED_FONT_COLOR_HEX

        name = format('|c%s%s|r', color, name or L['Loading item data...'])
        local icon = GetItemIcon(item)
        return name, icon or DEFAULT_ICON
    elseif t == 'string' then
        return item, DEFAULT_ICON
    elseif t == 'table' then
        local name, rule
        if item.comment then
            name = item.comment
            rule = item.rule
        else
            name = item.rule
            rule = item.rule
        end
        return name, item.icon or DEFAULT_ICON, rule
    end
end

local SEPARATOR = {isSeparator = true}
local GUI = LibStub('tdGUI-1.0', 1)

function SortingFrame:ShowRuleMenu(button, item)
    local name, icon, rule = self:GetRuleInfo(item)

    GUI:ToggleMenu(button, {
        { --
            text = format('|T%s:14|t %s', icon, name),
            isTitle = true,
        }, SEPARATOR, {
            text = ADD,
            hasArrow = true,
            menuTable = {
                {
                    text = L['Before this'],
                    func = function()
                        GUI:CloseMenu()
                        self:ShowAddDialog(button, WHERE_BEFORE)
                    end,
                }, {
                    text = L['After this'],
                    func = function()
                        GUI:CloseMenu()
                        self:ShowAddDialog(button, WHERE_AFTER)
                    end,
                }, {
                    text = L['In this'],
                    disabled = not ns.IsAdvanceRule(button.item),
                    func = function()
                        GUI:CloseMenu()
                        self:ShowAddDialog(button, WHERE_IN)
                    end,
                },
            },
        }, {
            text = DELETE,
            func = function(...)
                tremove(button.parent, button.index)
                self:SendMessage('TDPACK_SORTING_RULES_UPDATE')
            end,
        }, {
            text = EDIT,
            disabled = not ns.IsAdvanceRule(button.item),
            func = function(...)

            end,
        }, SEPARATOR, {text = CANCEL},
    })
end

function SortingFrame:ShowAddDialog(button, where)

end
