-- RuleOption.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/22/2019, 10:42:28 PM

local CreateFrame, ShowUIPanel = CreateFrame, ShowUIPanel

local ns = select(2, ...)
local Addon = ns.Addon
local L = ns.L

local RuleOption = Addon:NewClass('RuleOption', ns.Frame)

function RuleOption:Constructor()
    self.portrait:SetMask([[Textures\MinimapMask]])
    self.portrait:SetTexture(ns.ICON)
    self.TitleText:SetText('tdPack2')

    self:SetAttribute('UIPanelLayout-enabled', true)
    self:SetAttribute('UIPanelLayout-defined', true)
    self:SetAttribute('UIPanelLayout-whileDead', true)
    self:SetAttribute('UIPanelLayout-area', 'left')
    self:SetAttribute('UIPanelLayout-pushable', 4)

    self.self = self
    ns.SortingFrame:Bind(self.SortingFrame)
end

function Addon:OpenRuleOption()
    if not self.RuleOption then
        self.RuleOption = RuleOption:Bind(CreateFrame('Frame', nil, UIParent, 'tdPack2RuleOptionFrameTemplate'))
    end

    self.OpenRuleOption = function(self)
        ShowUIPanel(self.RuleOption)
    end
    self:OpenRuleOption()
end
