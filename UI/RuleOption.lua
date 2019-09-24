-- RuleOption.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/22/2019, 10:42:28 PM

local ns = select(2, ...)
local Addon = ns.Addon
local L = ns.L

local type, select = type, select
local format = string.format

local GetItemQualityColor, GetItemIcon = GetItemQualityColor, GetItemIcon
local CreateFrame, ShowUIPanel = CreateFrame, ShowUIPanel

local UIParent, GameTooltip = UIParent, GameTooltip

local RED_FONT_COLOR_HEX = RED_FONT_COLOR:GenerateHexColor()

local RuleOption = Addon:NewModule('RuleOption', 'AceEvent-3.0')

function RuleOption:Setup()
    self:InitRootFrame()
    self:InitRuleFrame()
end

function RuleOption:InitRootFrame()
    local RootFrame = CreateFrame('Frame', nil, UIParent, 'tdPack2RuleOptionFrameTemplate')
    RootFrame:RegisterForDrag('LeftButton')
    RootFrame.portrait:SetMask([[Textures\MinimapMask]])
    RootFrame.portrait:SetTexture(ns.ICON)
    RootFrame.TitleText:SetText('tdPack2')

    RootFrame:SetAttribute('UIPanelLayout-enabled', true)
    RootFrame:SetAttribute('UIPanelLayout-defined', true)
    RootFrame:SetAttribute('UIPanelLayout-whileDead', true)
    RootFrame:SetAttribute('UIPanelLayout-area', 'left')
    RootFrame:SetAttribute('UIPanelLayout-pushable', 4)

    self.RootFrame = RootFrame
end

function RuleOption:InitRuleFrame()
    local sorting = Addon.profile.rules.sorting

    local RuleFrame = ns.TreeView:Bind(self.RootFrame.RuleFrame)
    RuleFrame:SetItemTemplate('tdPack2RuleItemTemplate')
    RuleFrame:SetItemTree(Addon.profile.rules.sorting)
    RuleFrame:SetCallback('OnItemFormatting', function(_, ...)
        self:OnItemFormatting(...)
    end)
    RuleFrame:SetCallback('OnInserterShown', function(_, inserter, target, isBefore)
        self:OnInserterShown(inserter, target, isBefore)
    end)
    RuleFrame:SetCallback('OnCheckItemCanPutIn', function(_, from, to)
        if type(from) == 'table' then
            return type(to) == 'table'
        else
            return to == sorting
        end
    end)
    RuleFrame:SetCallback('OnItemEnter', function(_, button)
        self:ShowRuleTooltip(button, button.item)
    end)
    RuleFrame:SetCallback('OnItemLeave', GameTooltip_Hide)
    RuleFrame:SetCallback('OnOrdered', function()
        self:SendMessage('TDPACK_RULE_ORDERED')
    end)

    self.RuleFrame = RuleFrame
end

function RuleOption:OnItemFormatting(button, item, depth)
    local name, icon, rule
    if type(item) == 'number' then
        local quality, color
        name, _, _, _, _, quality = ns.GetItemInfo(item)
        color = name and quality and select(4, GetItemQualityColor(quality)) or RED_FONT_COLOR_HEX

        name = format('|c%s%s|r', color, name or L['Loading item data...'])
        icon = GetItemIcon(item)
    elseif type(item) == 'string' then
        name = item
    else
        if item.comment then
            name = item.comment
            rule = item.rule
        else
            name = item.rule
            rule = ''
        end

        if item.children and #item.children > 0 then
            name = name .. format('|cff00ffff(%s)|r', #item.children)
        end

        icon = item.icon
    end

    button.Text:SetPoint('LEFT', 5 + 20 * (depth - 1), 0)
    button.Text:SetText(format('|T%s:16|t %s', icon or [[Interface\Icons\INV_MISC_QUESTIONMARK]], name))
    button.Rule:SetText(rule or '')
end

function RuleOption:ShowRuleTooltip(button, item)
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

function RuleOption:Open()
    self:Setup()
    self.Open = function()
        ShowUIPanel(self.RootFrame)
    end
    self:Open()
end

function Addon:OpenRuleOption()
    RuleOption:Open()
end
