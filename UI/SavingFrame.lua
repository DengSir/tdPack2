-- SavingFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/9/2019, 2:07:17 PM

---@type ns
local ns = select(2, ...)

local L = ns.L
local UI = ns.UI
local Addon = ns.Addon

local SavingFrame = UI:NewModule('SavingFrame', 'AceEvent-3.0')

function SavingFrame:OnInitialize()
    UI.RuleOption:AddTab(L['Saving rules'], self)
end

function SavingFrame:OnSetup()
    local Frame = CreateFrame('Frame', nil, UI.RuleOption.Inset)
    Frame:SetAllPoints(true)
    Frame:Hide()

    local List = UI.RuleView:Bind(CreateFrame('ScrollFrame', nil, Frame, 'tdPack2ScrollFrameTemplate'))
    List:SetPoint('TOPLEFT', 5, -4)
    List:SetPoint('BOTTOMRIGHT', -20, 3)
    List:SetCallback('OnCheckItemCanPutIn', function(_, from, to)
        return ns.IsAdvanceRule(to)
    end)
    List:SetCallback('OnItemClick', function(List, button)
        List:ToggleItem(button.item)
    end)
    List:SetCallback('OnItemRightClick', function(_, button)
        self:ShowRuleMenu(button, button.item)
    end)
    List:SetCallback('OnSorted', function()
        self:SendMessage('TDPACK_SAVING_RULES_UPDATE')
    end)

    self.List = List
    self.Frame = Frame
end

function SavingFrame:OnEnable()
    self:RegisterMessage('TDPACK_SAVING_RULES_UPDATE', 'Refresh')
    self:RegisterMessage('TDPACK_PROFILE_CHANGED', 'Refresh')
    self:Refresh()
end

function SavingFrame:Refresh()
    self.List:SetItemTree(Addon:GetRules(ns.SORT_TYPE.SAVING))
    self.List:Refresh()
end

function SavingFrame:ShowRuleMenu(button, item)
    local name, icon, rule, hasChild = ns.GetRuleInfo(item)

    ns.GUI:ToggleMenu(button, {
        { --
            text = format('|T%s:14|t %s', icon, name),
            isTitle = true,
        }, {
            text = DELETE,
            func = function(...)
                UI.BlockDialog:Open({
                    text = hasChild and L['Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?'] or
                        L['Are you sure |cffff191919DELETE|r rule?'],
                    OnAccept = function()
                        tremove(button.parent, button.index)
                        self:SendMessage('TDPACK_SAVING_RULES_UPDATE')
                    end,
                })
            end,
        }, {
            text = EDIT,
            disabled = not ns.IsAdvanceRule(button.item),
            func = function(...)
                UI.RuleEditor:Open(item)
            end,
        }, {text = CANCEL},
    })
end
