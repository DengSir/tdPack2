-- Pack.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 3:14:49 AM
--
---- LUA
local pairs = pairs
local wipe = table.wipe

---- WOW
local GetCursorInfo = GetCursorInfo
local InCombatLockdown = InCombatLockdown
local UnitIsDead = UnitIsDead

---@type ns
local ns = select(2, ...)

---- NS
local L = ns.L
local Bag = ns.Bag
local Addon = ns.Addon
local BAG_TYPE = ns.BAG_TYPE

---@alias STATUS number
local STATUS = {
    FREE = 0, --
    PREPARE = 1,
    READY = 2, --
    STACKING = 3, --
    SAVING = 4, --
    SORTING = 5, --
    FINISH = 6, --
    CANCEL = 7, --
}

---@class Addon.Pack: AceModule, AceEvent-3.0, AceTimer-3.0
---@field private Stacking Addon.Stacking
---@field private Saving Addon.Saving
---@field private Sorting Addon.Sorting
---@field private tasks table<STATUS, Addon.Task|function>
local Pack = Addon:NewModule('Pack', 'AceEvent-3.0', 'AceTimer-3.0')
Pack:SetDefaultModuleState(false)

function Pack:OnInitialize()
    self.isBankOpened = false
    self.status = STATUS.FREE
    ---@type table<number, Addon.Bag>
    self.bags = {}
    self.tasks = { --
        [STATUS.STACKING] = ns.Stacking:New(),
        [STATUS.SAVING] = ns.Saving:New(),
        [STATUS.SORTING] = ns.Sorting:New(),
        [STATUS.PREPARE] = self.Prepare,
        [STATUS.READY] = self.NextStep,
        [STATUS.FINISH] = self.Finish,
        [STATUS.CANCEL] = self.Cancel,
    }

    self:RegisterEvent('BANKFRAME_OPENED')
    self:RegisterEvent('BANKFRAME_CLOSED')
    self:RegisterEvent('PLAYER_REGEN_DISABLED')
end

function Pack:BANKFRAME_OPENED()
    self.isBankOpened = true
end

function Pack:BANKFRAME_CLOSED()
    if self.isBankOpened and self.status ~= STATUS.FREE then
        self:SetStatus(STATUS.CANCEL)
        self:Warning(L['Leave bank, pack cancel.'])
    end
    self.isBankOpened = nil
end

function Pack:PLAYER_REGEN_DISABLED()
    if self.status ~= STATUS.FREE then
        self:SetStatus(STATUS.CANCEL)
        self:Warning(L['Player enter combat, pack cancel.'])
    end
end

function Pack:GetBag(bagType)
    return self.bags[bagType]
end

function Pack:IsLocked()
    for _, bag in pairs(self.bags) do
        if bag:IsLocked() then
            return true
        end
    end
end

function Pack:Start(opts)
    if self.status ~= STATUS.FREE then
        self:SetStatus(STATUS.CANCEL)
        self:Warning(L['Pack canceled.'])
        return
    end

    local save = opts.save()
    if (opts.bank or save) and not opts.bag and not self.isBankOpened then
        return
    end

    if UnitIsDead('player') then
        self:Warning(L['Player is dead'])
        return
    end

    if InCombatLockdown() then
        self:Warning(L['Player in combat'])
        return
    end

    if GetCursorInfo() then
        self:Warning(L['Please drop the item, money or skills.'])
        return
    end

    self.save = save
    self.reverse = opts.reverse()
    self.opts = opts

    self.bags[BAG_TYPE.BAG] = Bag:New(BAG_TYPE.BAG)

    if self.isBankOpened then
        self.bags[BAG_TYPE.BANK] = Bag:New(BAG_TYPE.BANK)
    end

    self:SetStatus(STATUS.PREPARE)
    self:ScheduleRepeatingTimer('OnIdle', 0.03)
end

function Pack:Stop()
    self:CancelAllTimers()
    self:SetStatus(STATUS.FREE)
    wipe(self.bags)
end

function Pack:Finish()
    self:Stop()
    self:Message(L['Pack finish.'])
end

function Pack:Cancel()
    self:Stop()

    for _, task in pairs(self.tasks) do
        if ns.Task:IsInstance(task) then
            task:Finish()
            task.running = nil
        end
    end
end

function Pack:Message(text)
    if not Addon:GetOption('console') then
        return
    end
    Addon:Print(text)
end

function Pack:Warning(text)
    return self:Message(format('|cffff0000%s|r', text))
end

function Pack:SetStatus(status)
    self.status = status
end

function Pack:NextStep()
    self.status = self.status + 1
end

function Pack:OnIdle()
    local task = self.tasks[self.status]
    if task then
        if task(self) then
            self:NextStep()
        end
    end
end

function Pack:IsOptionBag(bagType)
    if bagType == BAG_TYPE.BANK and not self.isBankOpened then
        return false
    end
    return self.opts[bagType]
end

function Pack:IsOptionReverse()
    return self.reverse
end

function Pack:IsOptionSaving()
    return self.save and self.isBankOpened
end

function Pack:Prepare()
    for _, bag in pairs(self.bags) do
        if not bag:IsReady() then
            bag:InitGroups()
            return
        end
    end
    if self:IsLocked() then
        self:Stop()
        self:Warning(L['Some slot is locked'])
        return
    end
    self:NextStep()
end
