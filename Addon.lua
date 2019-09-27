-- Addon.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:36:34 PM

local select, unpack = select, table.unpack or unpack
local CopyTable = CopyTable

---@type ns
local ADDON, ns = ...
local Addon = LibStub('AceAddon-3.0'):NewAddon(ADDON, 'LibClass-2.0', 'AceConsole-3.0', 'AceEvent-3.0')

ns.Addon = Addon
ns.L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
ns.ICON = [[Interface\AddOns\tdPack2\Resource\INV_Pet_Broom]]
ns.IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE

local CMD_ALL = 'all'
local CMD_BAG = 'bag'
local CMD_BANK = 'bank'
local ORDER_ASC = 'asc'
local ORDER_DESC = 'desc'

local METHODS = tInvert{CMD_ALL, CMD_BAG, CMD_BANK}
local ORDERS = tInvert{ORDER_ASC, ORDER_DESC}

function Addon:OnInitialize(args)
    local defaults = {
        profile = {
            reverse = false,
            console = true,
            firstLoad = true,
            actions = {
                bag = {
                    [ns.CLICK_TOKENS.LEFT] = 'SORT', --
                    [ns.CLICK_TOKENS.RIGHT] = 'OPEN_OPTIONS', --
                    [ns.CLICK_TOKENS.CONTROL_LEFT] = 'SORT_BAG', --
                    [ns.CLICK_TOKENS.CONTROL_RIGHT] = 'OPEN_RULE_OPTIONS', --
                }, --
                bank = {
                    [ns.CLICK_TOKENS.LEFT] = 'SORT', --
                    [ns.CLICK_TOKENS.RIGHT] = 'OPEN_OPTIONS', --
                    [ns.CLICK_TOKENS.CONTROL_LEFT] = 'SORT_BANK', --
                }, --
            },
            rules = {},
        },
    }

    self.db = LibStub('AceDB-3.0'):New('TDDB_PACK2', defaults, true)
    self.profile = self.db.profile

    if self.profile.firstLoad then
        self.profile.rules.sorting = CopyTable(ns.DEFAULT_CUSTOM_ORDER)
        self.profile.firstLoad = false
    end

    self:RegisterChatCommand('tdp', 'OnSlash')

    if self.LoadOptionFrame then
        self:LoadOptionFrame()
    end
end

function Addon:OnModuleCreated(module)
    local name = module:GetName()
    assert(not ns[name])
    ns[name] = module
end

function Addon:OnClassCreated(class, name)
    assert(not ns[name])
    ns[name] = class
end

function Addon:OnSlash(text)
    local args = {}
    local cmd, offset
    local method, order
    repeat
        cmd, offset = self:GetArgs(text, nil, offset)
        if METHODS[cmd] then
            method = cmd
        end
        if ORDERS[cmd] then
            order = cmd
        end
    until not cmd

    self:Pack(self:ParseArgs(unpack(args)))
end

function Addon:ParseArgs(...)
    local method, order
    local opts = {}

    for i = 1, select('#', ...) do
        local cmd = select(i, ...)
        if METHODS[cmd] then
            method = cmd
        end
        if ORDERS[cmd] then
            order = cmd
        end
    end

    if not method or method == CMD_ALL then
        opts.bank = true
        opts.bag = true
    elseif method == CMD_BAG then
        opts.bag = true
    elseif method == CMD_BANK then
        opts.bank = true
    end

    if not order then
        opts.reverse = self.profile.reverse
    elseif order == ORDER_ASC then
        opts.reverse = false
    elseif order == ORDER_DESC then
        opts.reverse = true
    end

    return opts
end

function Addon:IsConsoleEnabled()
    return self.profile.console
end

function Addon:Pack(...)
    ns.Pack:Start(self:ParseArgs(...))
end

local ACTIONS = {
    SORT = function()
        Addon:Pack()
    end,
    SORT_BAG = function()
        Addon:Pack('bag')
    end,
    SORT_BAG_ASC = function()
        Addon:Pack('bag', 'asc')
    end,
    SORT_BAG_DESC = function()
        Addon:Pack('bag', 'desc')
    end,
    SORT_BANK = function()
        Addon:Pack('bank')
    end,
    SORT_BANK_ASC = function()
        Addon:Pack('bank', 'asc')
    end,
    SORT_BANK_DESC = function()
        Addon:Pack('bank', 'desc')
    end,
    OPEN_RULE_OPTIONS = function()
        Addon:OpenRuleOption()
    end,
    OPEN_OPTIONS = function()
        Addon:OpenOption()
    end,
}

function Addon:RunAction(bagType, token)
    local action = self:GetBagClickOption(bagType, token)
    if not action then
        return
    end
    local func = ACTIONS[action]
    if func then
        func()
    end
end

function Addon:GetBagClickOption(bagType, token)
    return self.profile.actions[bagType][token] or nil
end

function Addon:SetBagClickOption(bagType, token, action)
    self.profile.actions[bagType][token] = action
end

function Addon:ResetSortingRules()
    local profile = wipe(self.profile.rules.sorting)
    ns.CopyTo(ns.DEFAULT_CUSTOM_ORDER, profile)
    self:SendMessage('TDPACK_SORTING_RULES_UPDATE')
end
