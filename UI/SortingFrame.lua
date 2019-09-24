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

local SortingFrame = Addon:NewClass('SortingFrame', ns.Frame)
ns.SortingFrame = SortingFrame

function SortingFrame:Constructor()
    local List = ns.TreeView:Bind(self.List)

    local profile = Addon.profile.rules.sorting

    List:SetItemTemplate('tdPack2RuleItemTemplate')
    List:SetItemTree(profile)
    List:SetCallback('OnItemFormatting', function(_, ...)
        self:OnItemFormatting(...)
    end)
    List:SetCallback('OnInserterShown', function(_, inserter, target, isBefore)
        self:OnInserterShown(inserter, target, isBefore)
    end)
    List:SetCallback('OnCheckItemCanPutIn', function(_, from, to)
        if type(from) == 'table' then
            return type(to) == 'table'
        else
            return to == profile
        end
    end)
    List:SetCallback('OnItemEnter', function(_, button)
        self:ShowRuleTooltip(button, button.item)
    end)
    List:SetCallback('OnItemRightClick', function(_, button)
        self:ShowRuleMenu(button, button.item)
    end)
    List:SetCallback('OnItemLeave', GameTooltip_Hide)
    List:SetCallback('OnOrdered', function()
        self:SendMessage('TDPACK_RULE_ORDERED')
    end)

    local Menu = CreateFrame('Frame', 'tdPack2SortingListMenu', self, 'UIDropDownMenuTemplate')
    UIDropDownMenu_Initialize(Menu, EasyMenu_Initialize, 'MENU', nil, {})
    self.Menu = Menu
end

function SortingFrame:OnItemFormatting(button, item, depth)
    local name, icon, rule = self:GetRuleInfo(item)

    button.Text:SetPoint('LEFT', 5 + 20 * (depth - 1), 0)
    button.Text:SetText(format('|T%s:16|t %s', icon, name))
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
        end

        -- if item.children and #item.children > 0 then
        --     name = name .. format('|cff00ffff(%s)|r', #item.children)
        -- end

        return name, item.icon or DEFAULT_ICON, rule
    end
end

function SortingFrame:ShowRuleMenu(button, item)
    local name, icon, rule = self:GetRuleInfo(item)

    ToggleDropDownMenu(1, nil, self.Menu, 'cursor', 3, -3, {
        { --
            text = format('|T%s:14|t %s', icon, name),
            notCheckable = true,
            isTitle = true,
        }, { --
            text = ADD,
            notCheckable = true,
            hasArrow = true,
            menuList = {
                { --
                    text = L['Before this'],
                    notCheckable = true,
                    func = function()
                        self:ShowAddDialog(button, WHERE_BEFORE)
                        CloseDropDownMenus()
                    end,
                }, { --
                    text = L['After this'],
                    notCheckable = true,
                    func = function()
                        self:ShowAddDialog(button, WHERE_AFTER)
                        CloseDropDownMenus()
                    end,
                }, { --
                    text = L['In this'],
                    notCheckable = true,
                    disabled = not ns.IsAdvanceRule(button.item),
                    func = function()
                        self:ShowAddDialog(button, WHERE_IN)
                        CloseDropDownMenus()
                    end,
                },
            },
        }, {
            text = DELETE,
            notCheckable = true,
            func = function(...)
                tremove(button.parent, button.index)
                self:SendMessage('TDPACK_RULE_ORDERED')
                self.List:Refresh()
            end,
        }, {
            text = EDIT,
            notCheckable = true,
            disabled = not ns.IsAdvanceRule(button.item),
            func = function(...)

            end,
        }, { --
            text = CANCEL,
            notCheckable = true,
        }, --
    }, button)
end

function SortingFrame:ShowAddDialog(button, where)

end
