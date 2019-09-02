-- Option.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 12:35:41 PM

local ADDON, ns = ...
local Addon = ns.Addon
local L = ns.L

function Addon:LoadOptionFrame()
    local index = 0
    local function orderGen()
        index = index + 1
        return index
    end

    local options = {
        type = 'group',
        name = ADDON,

        get = function(item)
            return self.db.profile[item[#item]]
        end,
        set = function(item, value)
            self.db.profile[item[#item]] = value
        end,

        args = {reverse = {type = 'toggle', name = L['Reverse Pack'], width = 'full', order = orderGen()}},
    }

    local registry = LibStub('AceConfigRegistry-3.0')
    registry:RegisterOptionsTable(ADDON, options)

    local dialog = LibStub('AceConfigDialog-3.0')
    self.options = dialog:AddToBlizOptions(ADDON, ADDON)
end

local OpenToCategory = function(options)
    InterfaceOptionsFrame_OpenToCategory(options)
    InterfaceOptionsFrame_OpenToCategory(options)
    OpenToCategory = InterfaceOptionsFrame_OpenToCategory
end

function Addon:OpenOption()
    OpenToCategory(self.options)
end
