-- RuleEditor.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/29/2019, 12:25:28 AM

local ns = select(2, ...)
local L = ns.L
local Search = ns.Search
local Addon = ns.Addon

local ICON_SIZE = 24

local RuleEditor = ns.UI:NewModule('RuleEditor')

local function GetText(editbox)
    local text = editbox:GetText():trim()
    return text ~= '' and text or nil
end

function RuleEditor:OnSetup()
    local Frame = ns.GUI:GetClass('BasicPanel'):New(UIParent)
    Frame:SetPoint('CENTER')
    Frame:SetSize(290, 300)

    local RuleInput = ns.GUI:GetClass('InputBox'):New(Frame)
    RuleInput:SetPoint('TOPLEFT', 20, -60)
    RuleInput:SetPoint('TOPRIGHT', -20, -60)
    RuleInput:SetHeight(22)
    RuleInput:HookScript('OnTextChanged', function()
        self:OnRuleChanged()
    end)
    self:CreateLabel(RuleInput, L['Rule'])

    local WhereDropDown = ns.GUI:GetClass('Dropdown'):New(Frame)
    WhereDropDown:SetPoint('TOPLEFT', RuleInput, 'BOTTOMLEFT', 0, -30)
    WhereDropDown:SetPoint('TOPRIGHT', RuleInput, 'BOTTOMRIGHT', 0, -30)
    WhereDropDown:SetHeight(22)
    WhereDropDown:SetMenuTable(function()
        return self:CreateWhereItemTable()
    end)
    self:CreateLabel(WhereDropDown, L['Where'])

    local CommentInput = ns.GUI:GetClass('InputBox'):New(Frame)
    CommentInput:SetPoint('TOPLEFT', WhereDropDown, 'BOTTOMLEFT', 0, -30)
    CommentInput:SetPoint('TOPRIGHT', WhereDropDown, 'BOTTOMRIGHT', 0, -30)
    CommentInput:SetHeight(22)
    self:CreateLabel(CommentInput, L['Comment (Optional)'])

    local IconsFrame = CreateFrame('Frame', nil, Frame)
    IconsFrame:SetPoint('TOPLEFT', CommentInput, 'BOTTOMLEFT', 0, -30)
    IconsFrame:SetPoint('TOPRIGHT', CommentInput, 'BOTTOMRIGHT', 0, -30)
    IconsFrame:SetHeight(ICON_SIZE)
    self:CreateLabel(IconsFrame, L['Icon (Optional)'])

    local ExecButton = CreateFrame('Button', nil, Frame, 'UIPanelButtonTemplate')
    ExecButton:SetSize(80, 22)
    ExecButton:SetPoint('BOTTOMRIGHT', Frame, 'BOTTOM', 0, 20)
    ExecButton:SetText(SAVE)
    ExecButton:SetScript('OnClick', function()
        self:OnSaveClick()
    end)

    local function OnClick(button)
        for _, v in pairs(self.iconButtons) do
            v:SetChecked(v == button)
        end
        self.selectedIcon = button.icon
    end

    self.iconButtons = setmetatable({}, {
        __index = function(t, i)
            local icon = CreateFrame('CheckButton', nil, IconsFrame)
            icon:SetSize(ICON_SIZE, ICON_SIZE)
            icon:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])
            icon:SetCheckedTexture([[Interface\Buttons\CheckButtonHilight]])
            icon:SetScript('OnClick', OnClick)
            if i == 1 then
                icon:SetPoint('LEFT', IconsFrame, 'LEFT', 0, 0)
            else
                icon:SetPoint('LEFT', self.iconButtons[i - 1], 'RIGHT', 0, 0)
            end
            t[i] = icon
            return icon
        end,
    })

    self.IconsFrame = IconsFrame
    self.RuleInput = RuleInput
    self.CommentInput = CommentInput
    self.WhereDropDown = WhereDropDown
    self.ExecButton = ExecButton
    self.Frame = Frame

    Frame:SetScript('OnShow', function()
        self:OnShow()
    end)

    self.profile = ns.Addon.profile.rules.sorting
end

function RuleEditor:OnShow()
    self.WhereDropDown:SetValue(self.profile)
end

function RuleEditor:CreateLabel(widget, text)
    local label = widget:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    label:SetPoint('BOTTOMLEFT', widget, 'TOPLEFT', 0, 5)
    label:SetText(text)
end

function RuleEditor:OnRuleChanged()
    self:UpdateValid()
    self:UpdateIcons()
end

function RuleEditor:OnSaveClick()
    local rule = self.RuleInput:GetText():trim()
    local comment = self.CommentInput:GetText():trim()
    local item = {
        rule = rule ~= '' and rule or nil,
        comment = comment ~= '' and comment or nil,
        icon = self.selectedIcon,
    }
    local where = self.WhereDropDown:GetValue()

    dump(where, item)

    Addon:AddRule(item, where)
end

function RuleEditor:CreateWhereItemTable(profile)
    local menuTable = {}

    if not profile then
        profile = ns.Addon.profile.rules.sorting

        tinsert(menuTable, {
            checkable = true,
            text = L['Root'],
            value = profile,
            checked = function(item, owner)
                return item.value == owner:GetValue()
            end,
        })
    end

    for i, v in ipairs(profile) do
        if type(v) == 'table' then
            local name, icon, rule = ns.GetRuleInfo(v)

            tinsert(menuTable, {
                checkable = true,
                -- text = format('|T%s:12|t %s', icon, name),
                text = name,
                value = v,
                checked = function(item, owner)
                    return item.value == owner:GetValue()
                end,
                hasArrow = v.children and #v.children > 0,
                menuTable = function()
                    return self:CreateWhereItemTable(v.children)
                end,
            })
        end
    end

    return menuTable
end

function RuleEditor:UpdateValid()
    local rule = GetText(self.RuleInput)
    self.ExecButton:SetEnabled(rule)
end

function RuleEditor:SetIconButton(index, icon)
    local button = self.iconButtons[index]
    button:SetNormalTexture(icon)
    button.icon = icon
    button:Show()
end

function RuleEditor:UpdateIcons()
    local rule = self.RuleInput:GetText():trim()

    local touched = {}
    local count = floor(self.IconsFrame:GetWidth() / ICON_SIZE)
    local index = 1

    if rule ~= '' then
        for _, bag in ipairs(ns.GetBags()) do
            for slot = 1, ns.GetBagNumSlots(bag) do
                if index > count then
                    break
                end

                local itemId = ns.GetBagSlotId(bag, slot)
                if itemId and not touched[itemId] then
                    touched[itemId] = true

                    local link = GetContainerItemLink(bag, slot)
                    if Search:Matches(link, rule) then
                        self:SetIconButton(index, GetItemIcon(link))
                        index = index + 1
                    end
                end
            end
        end
    end

    if index == 1 then
        self:SetIconButton(index, ns.UNKNOWN_ICON)
        index = index + 1
    end

    for i = index, #self.iconButtons do
        self.iconButtons[i]:Hide()
    end

    self.iconButtons[1]:Click()
end
