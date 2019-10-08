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
        opts.reverse = function()
            return self.profile.reverse
        end
    elseif order == ORDER.ASC then
        opts.reverse = function()
            return false
        end
    elseif order == ORDER.DESC then
        opts.reverse = function()
            return true
        end
    end
    return opts
end

function Addon:Pack(...)
    Pack:Start(self:ParseArgs(...))
end

function Addon:Generate(...)
    local opts = Addon:ParseArgs(...)
    return function()
        Pack:Start(opts)
    end
end

local COMMANDS = {
    SORT = Addon:Generate(),
    SORT_BAG = Addon:Generate(COMMAND.BAG),
    SORT_BAG_ASC = Addon:Generate(COMMAND.BAG, ORDER.ASC),
    SORT_BAG_DESC = Addon:Generate(COMMAND.BAG, ORDER.DESC),
    SORT_BANK = Addon:Generate(COMMAND.BANK),
    SORT_BANK_ASC = Addon:Generate(COMMAND.BANK, ORDER.ASC),
    SORT_BANK_DESC = Addon:Generate(COMMAND.BANK, ORDER.DESC),
    SORT_ASC = Addon:Generate(ORDER.ASC),
    SORT_DESC = Addon:Generate(ORDER.DESC),

    OPEN_RULE_OPTIONS = function()
        ns.UI.RuleOption:Show()
    end,
    OPEN_OPTIONS = function()
        Addon:OpenOption()
    end,
}

function Addon:RunCommand(bagType, token)
    local command = self:GetBagClickOption(bagType, token)
    if not command then
        return
    end
    local func = COMMANDS[command]
    if func then
        func()
    end
end
