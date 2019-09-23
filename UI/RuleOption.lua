-- RuleOption.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/22/2019, 10:42:28 PM

local ns = select(2, ...)
local Addon = ns.Addon
local L = ns.L

local GameTooltip = GameTooltip

local RuleOption = Addon:NewModule('RuleOption', 'AceEvent-3.0')

function RuleOption:Setup()
    local Frame = CreateFrame('Frame', nil, UIParent, 'tdPack2RuleOptionFrameTemplate')
    Frame:RegisterForDrag('LeftButton')
    Frame.portrait:SetMask([[Textures\MinimapMask]])
    Frame.portrait:SetTexture(ns.ICON)

    Frame:SetAttribute('UIPanelLayout-enabled', true)
    Frame:SetAttribute('UIPanelLayout-defined', true)
    Frame:SetAttribute('UIPanelLayout-whileDead', true)
    Frame:SetAttribute('UIPanelLayout-area', 'left')
    Frame:SetAttribute('UIPanelLayout-pushable', 4)

    local Rule = ns.TreeView:Bind(Frame.Rule)
    Rule:SetItemTemplate('tdPack2RuleItemTemplate')
    Rule:SetItemTree(ns.DEFAULT_CUSTOM_ORDER)
    Rule:SetCallback('OnItemFormatting', function(_, ...)
        self:OnItemFormatting(...)
    end)
    Rule:SetCallback('OnInserterShown', function(_, inserter, target, isBefore)
        self:OnInserterShown(inserter, target, isBefore)
    end)
    Rule:SetCallback('OnItemEnter', function(_, button)
        self:ShowTooltip(button, button.item)
    end)
    Rule:SetCallback('OnItemLeave', GameTooltip_Hide)
    Rule:SetCallback('OnOrdered', function()
        self:SendMessage('TDPACK_RULE_ORDERED')
    end)

    self.Frame = Frame
    self.Rule = Frame.Rule
end

function RuleOption:OnItemFormatting(button, item, depth)
    if type(item) == 'number' then
        local name, _, _, _, _, quality = ns.GetItemInfo(item)
        local icon = GetItemIcon(item)
        local color = name and quality and select(4, GetItemQualityColor(quality)) or RED_FONT_COLOR:GenerateHexColor()

        button.Text:SetText(format('|T%s:16|t |c%s%s|r', icon, color, name or L['Loading item data...']))
    elseif type(item) == 'string' then
        button.Text:SetText(item)
    else
        local text = item.comment or item.rule
        if item.icon then
            text = format('|T%s:16|t %s', item.icon, text)
        end
        button.Text:SetText(text)
    end
    button.Text:SetPoint('LEFT', 5 + 20 * (depth - 1), 0)
end

function RuleOption:ShowTooltip(button, item)
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
        ShowUIPanel(self.Frame)
    end
    self:Open()
end

function Addon:OpenRuleOption()
    RuleOption:Open()
end
