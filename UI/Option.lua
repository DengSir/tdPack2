-- Option.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 12:35:41 PM
---@type ns
local ADDON, ns = ...
local Addon = ns.Addon
local L = ns.L

local AceConfigRegistry = LibStub('AceConfigRegistry-3.0')
local AceConfigDialog = LibStub('AceConfigDialog-3.0')

local AceGUI = LibStub('AceGUI-3.0')

local Type = ADDON .. 'RuleView'

local methods = {
    OnAcquire = function(self)
        print('OnAcquire', self)
        self:SetHeight(295)
    end,

    OnRelease = function(self)
        print('OnRelease', self)
        self.frame:UnregisterAllMessages()
    end,

    OnWidthSet = function(self, width)
        self.frame:SetWidth(width - 18)
        self.frame.scrollChild:SetWidth(width - 18)
    end,

    OnHeightSet = function(self, height)
        self.frame:SetHeight(height)
        self.frame.scrollChild:SetHeight(height)
    end,

    SetText = function(self, type)
        assert(ns.SORT_TYPE[type])
        local frame = self.frame
        print(self)

        self.listType = type
        self.event = format('TDPACK_%s_RULES_UPDATE', type)
        self:Refresh()

        self.frame:SetCallback('OnListChanged', function()
            Addon:SendMessage(self.event)
        end)
        self.frame:RegisterMessage(self.event, function()
            self:Refresh()
        end)
        self.frame:RegisterMessage('TDPACK_PROFILE_CHANGED', function()
            self:Refresh()
        end)
    end,

    Refresh = function(self)
        self.frame:SetItemTree(Addon:GetRules(ns.SORT_TYPE[self.listType]))
        self.frame:Refresh()
    end,
}

local function Constructor()
    local frame = ns.UI.RuleView:Bind(CreateFrame('ScrollFrame', 'tdPackPackFrame', UIParent,
                                                  'tdPack2ScrollFrameTemplate'))
    frame:Hide()

    local widget = {frame = frame, type = Type}
    for method, func in pairs(methods) do
        widget[method] = func
    end

    return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, 1)

function Addon:InitOptionFrame()
    local index = 0
    local function orderGen()
        index = index + 1
        return index
    end

    local function toggle(text, disabled)
        return {type = 'toggle', name = text, width = 'full', order = orderGen(), disabled = disabled}
    end

    local function execute(text, ...)
        local confirm, func
        local t = type(...)
        if t == 'function' then
            func = ...
        else
            confirm, func = ...
        end

        return {
            type = 'execute',
            name = text,
            width = 'full',
            order = orderGen(),
            confirm = not not confirm,
            confirmText = confirm,
            func = func,
        }
    end

    local function desc(name)
        return {
            type = 'description',
            order = orderGen(),
            name = name,
            fontSize = 'medium',
            image = [[Interface\Common\help-i]],
            imageWidth = 32,
            imageHeight = 32,
            imageCoords = {.2, .8, .2, .8},
            desc = name,
        }
    end

    local function drop(opts)
        local values = opts.values

        opts.values = {}
        opts.sorting = {}

        for i, v in ipairs(values) do
            opts.values[v.value] = v.name
            opts.sorting[i] = v.value
        end

        opts.type = 'select'
        opts.order = orderGen()

        return opts
    end

    local function generateButton(bagType, name)
        local g = {
            type = 'group',
            name = name,
            args = {},
            order = orderGen(),
            get = function(item)
                return Addon:GetBagClickOption(bagType, tonumber(item[#item]))
            end,
            set = function(item, value)
                Addon:SetBagClickOption(bagType, tonumber(item[#item]), value)
            end,
        }

        for _, v in ipairs(ns.CLICK_LIST) do
            g.args[tostring(v.token)] = drop {
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
                    {name = L.SAVE, value = 'SAVE'}, --
                    {name = L.OPEN_RULE_OPTIONS, value = 'OPEN_RULE_OPTIONS'}, --
                    {name = L.OPEN_OPTIONS, value = 'OPEN_OPTIONS'}, --
                },
            }
        end

        return g
    end

    local charProfileKey = format('%s - %s', UnitName('player'), GetRealmName())

    local options = {
        type = 'group',
        name = format('%s - |cff00ff00%s|r', ADDON, GetAddOnMetadata(ADDON, 'Version')),

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
            reset = {
                type = 'execute',
                name = L['Restore default Settings'],
                order = orderGen(),
                confirm = true,
                confirmText = L['Are you sure you want to restore the current Settings?'],
                func = function()
                    self.db:ResetProfile()
                end,
            },
            line = {type = 'header', name = ''},
            general = {
                type = 'group',
                name = GENERAL,
                order = orderGen(),
                args = {
                    default = {
                        type = 'group',
                        name = L.SORT,
                        order = orderGen(),
                        inline = true,
                        args = { --
                            reverse = toggle(L['Reverse pack']),
                            saving = toggle(L['Save to bank when default packing']),
                            stackTogether = toggle(L['Bank and bag stacking together']),
                            stackBankFull = toggle(L['Keep bank items stack full'], function()
                                return not self:GetOption('stackTogether')
                            end),
                        },
                    },
                    global = {
                        type = 'group',
                        name = L['Global'],
                        order = orderGen(),
                        inline = true,
                        args = {
                            console = toggle(L['Enable chat message']),
                            resetSorting = execute(L['Reset sorting rules'],
                                                   L['Are you sure to |cffff1919RESET|r sorting rules?'], function()
                                Addon:ResetRules(ns.SORT_TYPE.SORTING)
                            end),
                            resetSaving = execute(L['Reset saving rules'],
                                                  L['Are you sure to |cffff1919RESET|r saving rules?'], function()
                                Addon:ResetRules(ns.SORT_TYPE.SAVING)
                            end),
                        },
                    },
                    help = {
                        type = 'group',
                        name = L['Help'],
                        order = orderGen(),
                        inline = true,
                        args = { --
                            applyLibItemSearch = toggle(L['Add extension filter to ItemSearch-1.3']),
                        },
                    },
                },
            },
            [ns.BAG_TYPE.BAG] = generateButton(ns.BAG_TYPE.BAG, L['Bag button features']),
            [ns.BAG_TYPE.BANK] = generateButton(ns.BAG_TYPE.BANK, L['Bank button features']),
            pack = {
                type = 'group',
                name = 'hello',
                args = {
                    title = desc(L['Sorting rule settings']),
                    add = {
                        type = 'execute',
                        name = L['Add advance rule'],
                        order = orderGen(),
                        desc = 'helloworld',
                        func = function()

                        end,
                    },
                    reset = {
                        type = 'execute',
                        name = L['Reset rule'],
                        order = orderGen(),
                        func = function()

                        end,
                    },
                    help = {
                        type = 'execute',
                        name = L['Help'],
                        width = 'half',
                        order = orderGen(),
                        image = [[Interface\HelpFrame\HelpIcon-KnowledgeBase]],
                        imageCoords = {0.2, 0.8, 0.2, 0.8},
                        imageWidth = 24,
                        imageHeight = 24,
                        desc = table.concat({
                            L['Drag to modify the sorting order'], L['Put in an item to add simple rule'],
                            L['Advancee rules use ItemSearch-1.3'], L['Enjoy!'],
                        }, '\n'),
                    },
                    view = {
                        type = 'group',
                        name = 'Rules',
                        inline = true,
                        order = orderGen(),
                        args = {
                            view = {
                                type = 'header',
                                name = 'SORTING',
                                order = orderGen(),
                                width = 'full',
                                dialogControl = ADDON .. 'RuleView',
                                arg = {'pack'},
                            },
                        },
                    },
                    -- help = {
                    --     type = 'description',
                    --     name = table.concat({
                    --         L['Drag to modify the sorting order'], L['Put in an item to add simple rule'],
                    --         L['Advancee rules use ItemSearch-1.3'], L['Enjoy!'],
                    --     }, '\n'),
                    -- },
                },

            },
        },
    }

    AceConfigRegistry:RegisterOptionsTable(ADDON, options)
    AceConfigDialog:AddToBlizOptions(ADDON, ADDON)
    AceConfigDialog:SetDefaultSize(ADDON, 700, 570)
end

function Addon:OpenOption()
    AceConfigDialog:Open(ADDON)
    pcall(function()
        AceConfigDialog.OpenFrames[ADDON]:EnableResize(false)
        AceConfigDialog.OpenFrames[ADDON].frame:SetFrameStrata('DIALOG')
    end)
end
