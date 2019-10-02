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

---@type ns
local ns = select(2, ...)
local L = ns.L
local Addon = ns.Addon
local ItemInfoCache = ns.ItemInfoCache

local SortingFrame = ns.UI:NewModule('SortingFrame', 'AceEvent-3.0')

function SortingFrame:OnSetup()
    self.profile = Addon.profile.rules.sorting

    local Frame = CreateFrame('Frame', nil, ns.UI.RuleOption.Inset)
    Frame:SetAllPoints(true)

    local List = ns.RuleView:Bind(CreateFrame('ScrollFrame', nil, Frame, 'tdPack2RuleViewTemplate'))
    List:SetPoint('TOPLEFT', 5, -4)
    List:SetPoint('BOTTOMRIGHT', -20, 3)
    List:SetItemTree(self.profile)
    List:SetCallback('OnCheckItemCanPutIn', function(_, from, to)
        if type(from) == 'table' then
            return type(to) == 'table'
        else
            return to == self.profile
        end
    end)
    List:SetCallback('OnItemClick', function(_, button)
        tremove(button.parent, button.index)
        self.List:Refresh()
    end)
    List:SetCallback('OnItemRightClick', function(_, button)
        self:ShowRuleMenu(button, button.item)
    end)
    List:SetCallback('OnSorted', function()
        self:SendMessage('TDPACK_SORTING_RULES_UPDATE')
    end)

    -- self.Add:SetScript('OnClick', function()
    --     ns.UI.RuleEditor:Show()
    -- end)

    local AddButton = CreateFrame('Button', nil, Frame, 'UIPanelButtonTemplate')
    AddButton:SetPoint('BOTTOMLEFT', ns.UI.RuleOption.Frame, 'BOTTOMLEFT', 0, 0)
    AddButton:SetSize(80, 22)
    MagicButton_OnLoad(AddButton)
    AddButton:SetText(L['Add rule'])
    AddButton:SetScript('OnClick', function()
        ns.UI.RuleEditor:Show()
    end)

    self.List = List
    self.Frame = Frame
end

function SortingFrame:OnEnable()
    self:RegisterMessage('TDPACK_SORTING_RULES_UPDATE', 'Refresh')
    self:RegisterMessage('TDPACK_SORTING_RULES_RESET', 'Refresh')
end

function SortingFrame:Refresh()
    self.List:Refresh()
end

local SEPARATOR = {isSeparator = true}
local GUI = LibStub('tdGUI-1.0', 1)

function SortingFrame:ShowRuleMenu(button, item)
    local name, icon, rule = self.List:GetRuleInfo(item)

    GUI:ToggleMenu(button, {
        { --
            text = format('|T%s:14|t %s', icon, name),
            isTitle = true,
        }, SEPARATOR, {
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
