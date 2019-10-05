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
    Frame:ShowPortrait()
    Frame:SetPortrait(ns.ICON)
    Frame:SetText('tdPack2')
    Frame:SetMovable(true)
    Frame:SetResizable(true)
    Frame:SetMinResize(337, 423)
    Frame:RegisterConfig(Addon.profile.ruleOptionWindow)
    Frame:RestoreSize()
    Frame:RestorePosition()

    local Inset = CreateFrame('Frame', nil, Frame, 'InsetFrameTemplate')
    Inset:SetPoint('TOPLEFT', 4, -60)
    Inset:SetPoint('BOTTOMRIGHT', -6, 26)

    local BlockDialog = ns.GUI:GetClass('BlockDialog'):New(Frame) do
        BlockDialog:SetPoint('TOPLEFT', 3, -22)
        BlockDialog:SetPoint('BOTTOMRIGHT', -3, 3)
        BlockDialog:SetFrameLevel(Frame:GetFrameLevel() + 100)
    end

    local name = 'tdPackRuleOption'
    _G[name] = Frame
    tinsert(UISpecialFrames, name)

    self.Inset = Inset
    self.Frame = Frame
    self.BlockDialog = BlockDialog

    ns.UI.BlockDialog = BlockDialog
    ns.UI.SortingFrame:Show()
end

function Addon:OpenRuleOption()
    RuleOption:Show()
end
