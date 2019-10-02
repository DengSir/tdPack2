-- RuleOption.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/22/2019, 10:42:28 PM

local CreateFrame, ShowUIPanel = CreateFrame, ShowUIPanel

local ns = select(2, ...)
local L = ns.L
local Addon = ns.Addon

local RuleOption = ns.UI:NewModule('RuleOption')

function RuleOption:OnSetup()
    local Frame = ns.GUI:GetClass('BasicPanel'):New(UIParent)
    Frame:SetSize(337, 423)
    Frame:ShowPortrait()
    Frame:SetPortrait(ns.ICON)
    Frame:SetText('tdPack2')

    Frame:SetAttribute('UIPanelLayout-enabled', true)
    Frame:SetAttribute('UIPanelLayout-defined', true)
    Frame:SetAttribute('UIPanelLayout-whileDead', true)
    Frame:SetAttribute('UIPanelLayout-area', 'left')
    Frame:SetAttribute('UIPanelLayout-pushable', 4)

    local Inset = CreateFrame('Frame', nil, Frame, 'InsetFrameTemplate')
    Inset:SetPoint('TOPLEFT', 4, -60)
    Inset:SetPoint('BOTTOMRIGHT', -6, 26)

    self.Inset = Inset
    self.Frame = Frame

    ns.UI.SortingFrame:Show()
end

function Addon:OpenRuleOption()
    RuleOption:Show()
end
