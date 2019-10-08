-- HelpFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/8/2019, 11:28:17 AM

local ns = select(2, ...)
local L = ns.L
local UI = ns.UI

local HelpFrame = UI:NewModule('HelpFrame')

function HelpFrame:OnInitialize()
    UI.RuleOption:AddTab(L['Help'], self)
end

function HelpFrame:OnSetup()
    local Frame = CreateFrame('Frame', nil, UI.RuleOption.Inset)
    Frame:SetAllPoints(true)
    Frame:Hide()

    local Scroll = CreateFrame('ScrollFrame', nil, Frame, 'tdPack2ScrollFrameTemplate')
    Scroll:SetPoint('TOPLEFT', 5, -4)
    Scroll:SetPoint('BOTTOMRIGHT', -20, 3)
    Scroll.scrollBar:SetScript('OnValueChanged', nil)

    local Html = CreateFrame('SimpleHTML', nil, Scroll)
    Html:SetFontObject('GameFontHighlightLeft')
    Html:SetFontObject('h1', 'GameFontNormalLeft')
    Html:SetFontObject('h2', 'GameFontNormalLargeLeft')
    Html:SetFontObject('h3', 'QuestFont_Super_Huge')
    Html:SetPoint('TOPLEFT')

    Scroll:SetScrollChild(Html)

    self.Frame = Frame
end
