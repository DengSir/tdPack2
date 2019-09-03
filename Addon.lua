-- Addon.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:36:34 PM

---@type ns
local ADDON, ns = ...
local Addon = LibStub('AceAddon-3.0'):NewAddon(ADDON, 'LibClass-2.0', 'AceConsole-3.0')

ns.Addon = Addon
ns.L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
ns.ICON = [[Interface\AddOns\tdPack2\Resource\INV_Pet_Broom]]
ns.IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE

function Addon:OnInitialize(args)
    local defaults = {profile = {reverse = false}}

    self.db = LibStub('AceDB-3.0'):New('TDDB_PACK2', defaults, true)

    if self.LoadOptionFrame then
        self:LoadOptionFrame()
    end
end

function Addon:IsReversePack()
    return self.db.profile.reverse
end

function Addon:Pack()
    ns.Pack:Start()
end
