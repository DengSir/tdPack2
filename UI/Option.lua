-- Option.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 12:35:41 PM

---@type ns
local ADDON, ns = ...
local Addon = ns.Addon
local L = ns.L

function Addon:LoadOptionFrame()
    local index = 0
    local function orderGen()
        index = index + 1
        return index
    end

    local function drop(opts)
        local old = {}
        local new = {}

        local get, set = opts.get, opts.set
        if opts.values and set then
            opts.set = function(item, value)
                return set(item, old[value])
            end
        end
        if opts.values and get then
            opts.get = function(item)
                return new[get(item)]
            end
        end

        if opts.values then
            local values = {}
            local len = #opts.values
            local F = format('%%%dd\001%%s', len)

            for i, v in ipairs(opts.values) do
                local f = format(F, i, tostring(v.value))
                values[f] = v.name
                old[f] = v.value
                new[v.value] = f
            end

            opts.values = values
        end

        opts.type = 'select'
        opts.order = opts.order or orderGen()

        return opts
    end

    local function generateButton(bagType, name)
        local g = {type = 'group', name = name, args = {}, order = orderGen()}

        for _, v in ipairs(ns.CLICK_LIST) do
            g.args[v.name] = drop{
                name = v.name,
                order = orderGen(),
                values = {
                    {name = L['None'], value = false}, --
                    {name = L.SORT, value = 'SORT'}, --
                    {name = L.SORT_BAG, value = 'SORT_BAG'}, --
                    {name = L.SORT_BAG_ASC, value = 'SORT_BAG_ASC'}, --
                    {name = L.SORT_BAG_DESC, value = 'SORT_BAG_DESC'}, --
                    {name = L.SORT_BANK, value = 'SORT_BANK'}, --
                    {name = L.SORT_BANK_ASC, value = 'SORT_BANK_ASC'}, --
                    {name = L.SORT_BANK_DESC, value = 'SORT_BANK_DESC'}, --
                    {name = L.OPEN_RULE_OPTIONS, value = 'OPEN_RULE_OPTIONS'}, --
                    {name = L.OPEN_OPTIONS, value = 'OPEN_OPTIONS'}, --
                },
                get = function()
                    return Addon:GetBagClickOption(bagType, v.token)
                end,
                set = function(_, value)
                    Addon:SetBagClickOption(bagType, v.token, value)
                end,
            }
        end

        return g
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

        args = {
            general = {
                type = 'group',
                name = GENERAL,
                order = orderGen(),
                args = {
                    reverse = {type = 'toggle', name = L['Reverse pack'], width = 'full', order = orderGen()},
                    console = {type = 'toggle', name = L['Enable chat message'], width = 'full', order = orderGen()},
                },
            },
            bag = generateButton('bag', L['Bag button features']),
            bank = generateButton('bank', L['Bank button features']),
        },
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
