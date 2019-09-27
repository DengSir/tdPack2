-- Addon.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:36:34 PM

local select, assert, unpack = select, assert, table.unpack or unpack
local CopyTable, tInvert = CopyTable, tInvert

---@type ns
local ADDON, ns = ...
local Addon = LibStub('AceAddon-3.0'):NewAddon(ADDON, 'LibClass-2.0', 'AceEvent-3.0', 'AceConsole-3.0')

ns.Addon = Addon
ns.L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
ns.ICON = [[Interface\AddOns\tdPack2\Resource\INV_Pet_Broom]]
ns.IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE

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

    self:LoadOptionFrame()
    self:InitCommands()
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

function Addon:IsConsoleEnabled()
    return self.profile.console
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
