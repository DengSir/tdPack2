-- Addon.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:36:34 PM

local select, assert, unpack, wipe = select, assert, table.unpack or unpack, table.wipe or wipe
local CopyTable, tInvert = CopyTable, tInvert

---@type ns
local ADDON, ns = ...
local Addon = LibStub('AceAddon-3.0'):NewAddon(ADDON, 'LibClass-2.0', 'AceEvent-3.0', 'AceConsole-3.0')

ns.Addon = Addon
ns.L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
ns.ICON = [[Interface\AddOns\tdPack2\Resource\INV_Pet_Broom]]
ns.IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
ns.UNKNOWN_ICON = 134400
ns.GUI = LibStub('tdGUI-1.0')

function Addon:OnInitialize(args)
    local defaults = {
        profile = {
            reverse = false,
            console = true,
            firstLoad = true,
            applyLibItemSearch = false,
            ruleOptionWindow = {point = 'CENTER', width = 637, height = 637},
            actions = {
                [ns.COMMAND.BAG] = {
                    [ns.CLICK_TOKENS.LEFT] = 'SORT',
                    [ns.CLICK_TOKENS.RIGHT] = 'OPEN_RULE_OPTIONS',
                    [ns.CLICK_TOKENS.CONTROL_LEFT] = 'SORT_BAG',
                    [ns.CLICK_TOKENS.CONTROL_RIGHT] = 'OPEN_OPTIONS',
                },
                [ns.COMMAND.BANK] = {
                    [ns.CLICK_TOKENS.LEFT] = 'SORT',
                    [ns.CLICK_TOKENS.RIGHT] = 'OPEN_RULE_OPTIONS',
                    [ns.CLICK_TOKENS.CONTROL_LEFT] = 'SORT_BANK',
                    [ns.CLICK_TOKENS.CONTROL_RIGHT] = 'OPEN_OPTIONS',
                },
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
    local sorting = wipe(self.profile.rules.sorting)
    ns.CopyFrom(sorting, ns.DEFAULT_CUSTOM_ORDER)
    self:SendMessage('TDPACK_SORTING_RULES_UPDATE')
end

function Addon:GetSortingRules()
    return self.profile.rules.sorting
end

function Addon:GetOption(key)
    return self.profile[key]
end

function Addon:SetOption(key, value)
    self.profile[key] = value
    self:SendMessage('TDPACK_OPTION_CHANGED_' .. key, key, value)
end

function Addon:AddRule(item, where)
    where.children = where.children or {}
    tinsert(where.children, item)
    self:SendMessage('TDPACK_SORTING_RULES_UPDATE')
end

function Addon:EditRule(item, where)
    where.rule = item.rule
    where.comment = item.comment
    where.icon = item.icon
    self:SendMessage('TDPACK_SORTING_RULES_UPDATE')
end
