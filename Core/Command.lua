-- Command.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/27/2019, 10:59:50 PM

---- LUA
local unpack, select = unpack, select
local tInvert = tInvert

---@type ns
local ns = select(2, ...)

---- NS
local Addon = ns.Addon
local Pack = ns.Pack
local COMMAND = ns.COMMAND
local ORDER = ns.ORDER

---- LOCAL
local COMMANDS = tInvert{COMMAND.ALL, COMMAND.BAG, COMMAND.BANK}
local ORDERS = tInvert{ORDER.ASC, ORDER.DESC}

function Addon:InitCommands()
    self:RegisterChatCommand('tdp', 'OnChatSlash')
end

function Addon:OnChatSlash(text)
    local args = {}
    local cmd, offset
    local command, order
    repeat
        cmd, offset = self:GetArgs(text, nil, offset)
        if COMMANDS[cmd] then
            command = cmd
        end
        if ORDERS[cmd] then
            order = cmd
        end
    until not cmd

    self:Pack(self:ParseArgs(unpack(args)))
end

function Addon:ParseArgs(...)
    local command, order
    local opts = {}

    for i = 1, select('#', ...) do
        local cmd = select(i, ...)
        if COMMANDS[cmd] then
            command = cmd
        end
        if ORDERS[cmd] then
            order = cmd
        end
    end

    if not command or command == COMMAND.ALL then
        opts.bank = true
        opts.bag = true
    elseif command == COMMAND.BAG then
        opts.bag = true
    elseif command == COMMAND.BANK then
        opts.bank = true
    end

    if not order then
        opts.reverse = self.profile.reverse
    elseif order == ORDER.ASC then
        opts.reverse = false
    elseif order == ORDER.DESC then
        opts.reverse = true
    end

    return opts
end

function Addon:Pack(...)
    Pack:Start(self:ParseArgs(...))
end

local ACTIONS = {
    SORT = function()
        Addon:Pack()
    end,
    SORT_BAG = function()
        Addon:Pack(COMMAND.BAG)
    end,
    SORT_BAG_ASC = function()
        Addon:Pack(COMMAND.BAG, ORDER.ASC)
    end,
    SORT_BAG_DESC = function()
        Addon:Pack(COMMAND.BAG, ORDER.DESC)
    end,
    SORT_BANK = function()
        Addon:Pack(COMMAND.BANK)
    end,
    SORT_BANK_ASC = function()
        Addon:Pack(COMMAND.BANK, ORDER.ASC)
    end,
    SORT_BANK_DESC = function()
        Addon:Pack(COMMAND.BANK, ORDER.DESC)
    end,
    OPEN_RULE_OPTIONS = function()
        Addon:OpenRuleOption()
    end,
    OPEN_OPTIONS = function()
        Addon:OpenOption()
    end,
}

function Addon:RunCommand(bagType, token)
    local action = self:GetBagClickOption(bagType, token)
    if not action then
        return
    end
    local func = ACTIONS[action]
    if func then
        func()
    end
end
