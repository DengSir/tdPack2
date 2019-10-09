-- Option.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 12:35:41 PM

---@type ns
local ADDON, ns = ...
local Addon = ns.Addon
local L = ns.L

function Addon:InitOptionFrame()
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
                    {name = L.SORT_ASC, value = 'SORT_ASC'}, --
                    {name = L.SORT_DESC, value = 'SORT_DESC'}, --
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

    local charProfileKey = format('%s - %s', UnitName('player'), GetRealmName())

    local options = {
        type = 'group',
        name = ADDON,

        get = function(item)
            return self:GetOption(item[#item])
        end,
        set = function(item, value)
            self:SetOption(item[#item], value)
        end,

        args = {
            profile = {
                type = 'toggle',
                name = L['Character Specific Settings'],
                width = 'double',
                order = orderGen(),
                set = function(_, checked)
                    self.db:SetProfile(checked and charProfileKey or 'Default')
                end,
                get = function()
                    return self.db:GetCurrentProfile() == charProfileKey
                end,
            },
            general = {
                type = 'group',
                name = GENERAL,
                order = orderGen(),
                args = {
                    reverse = {type = 'toggle', name = L['Reverse pack'], width = 'full', order = orderGen()},
                    console = {type = 'toggle', name = L['Enable chat message'], width = 'full', order = orderGen()},
                    resetSorting = {
                        type = 'execute',
                        name = L['Reset sorting rules'],
                        width = 'full',
                        order = orderGen(),
                        confirm = true,
                        confirmText = L['Are you sure to |cffff1919RESET|r sorting rules?'],
                        func = function()
                            Addon:ResetSortingRules()
                        end,
                    },
                },
            },
            [ns.BAG_TYPE.BAG] = generateButton(ns.BAG_TYPE.BAG, L['Bag button features']),
            [ns.BAG_TYPE.BANK] = generateButton(ns.BAG_TYPE.BANK, L['Bank button features']),
            help = {
                type = 'group',
                name = L['Help'],
                order = orderGen(),
                args = {
                    applyLibItemSearch = {
                        type = 'toggle',
                        name = L['Apply to LibItemSearch'],
                        width = 'full',
                        order = orderGen(),
                    },
                },
            },
        },
    }

    local registry = LibStub('AceConfigRegistry-3.0')
    registry:RegisterOptionsTable(ADDON, options)

    local dialog = LibStub('AceConfigDialog-3.0')
    self.options = dialog:AddToBlizOptions(ADDON, ADDON)
end

local function OpenToCategory(options)
    InterfaceOptionsFrame_OpenToCategory(options)
    InterfaceOptionsFrame_OpenToCategory(options)
    OpenToCategory = InterfaceOptionsFrame_OpenToCategory
end

function Addon:OpenOption()
    OpenToCategory(self.options)
end
