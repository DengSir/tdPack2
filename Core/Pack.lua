-- Pack.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 3:14:49 AM

---@type ns
local ns = select(2, ...)

---- NS
local L = ns.L
local Bag = ns.Bag
local Slot = ns.Slot
local Item = ns.Item
local Addon = ns.Addon
local BAG_TYPE = ns.BAG_TYPE

---- LUA
local ripairs = ns.ripairs
local select, ipairs, pairs = select, ipairs, pairs
local tinsert, tremove, wipe = table.insert, table.remove, wipe
local format = string.format
local coroutine = coroutine

---- WOW
local GetCursorInfo = GetCursorInfo
local InCombatLockdown = InCombatLockdown
local UnitIsDead = UnitIsDead

---@class Pack
---@field private bag Bag
---@field private bank Bank
---@field private Stacking Stacking
---@field private Saving Saving
---@field private Sorting Sorting
local Pack = Addon:NewModule('Pack', 'AceEvent-3.0', 'AceTimer-3.0')
Pack:SetDefaultModuleState(false)

local STATUS = {
    FREE = 0, --
    READY = 1, --
    STACKING = 2, --
    STACKED = 3, --
    SAVING = 4, --
    SAVED = 5, --
    PACKING = 6, --
    PACKED = 7, --
    FINISH = 8, --
    CANCEL = 9, --
}

function Pack:OnInitialize()
    self.isBankOpened = false
    self.status = STATUS.FREE

    self:RegisterEvent('BANKFRAME_OPENED')
    self:RegisterEvent('BANKFRAME_CLOSED')
    self:RegisterEvent('PLAYER_REGEN_DISABLED')
end

function Pack:OnModuleCreated(module)
    self[module:GetName()] = module
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

function Pack:GetBag()
    return self.bag
end

function Pack:GetBank()
    return self.bank
end

function Pack:IsLocked()
    return (self.bag and self.bag:IsLocked()) or (self.bank and self.bank:IsLocked())
end

function Pack:Start(opts)
    local save = opts.save()
    if (opts.bank or save) and not opts.bag and not self.isBankOpened then
        return
    end

    if self.status ~= STATUS.FREE then
        self:Warning(L['Packing now'])
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
    self:SetStatus(STATUS.READY)
    self:ScheduleRepeatingTimer('OnIdle', 0.03)
end

function Pack:Stop()
    self:CancelAllTimers()
    self.Stacking:Disable()
    self.Saving:Disable()
    self.Sorting:Disable()
    self:SetStatus(STATUS.FREE)
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

function Pack:StatusReady()
    if self:IsLocked() then
        return
    end

    self.bag = Bag:New(BAG_TYPE.BAG)
    self.bank = Bag:New(BAG_TYPE.BANK)

    self.Stacking:Enable()
    self:SetStatus(STATUS.STACKING)
end

function Pack:StatusStacking()
    if not self.Stacking:Process() then
        return
    end

    self.Stacking:Disable()
    self:SetStatus(STATUS.STACKED)
end

function Pack:StatusStacked()
    if self:IsLocked() then
        return
    end

    if self:IsOptionSaving() then
        self.Saving:Enable()
        self:SetStatus(STATUS.SAVING)
    else
        self:StatusSaved()
    end
end

function Pack:StatusSaving()
    if not self.Saving:Process() then
        return
    end

    self.Saving:Disable()
    self:SetStatus(STATUS.SAVED)
end

function Pack:StatusSaved()
    if self:IsLocked() then
        return
    end

    self.Sorting:Enable()
    self:SetStatus(STATUS.PACKING)
end

function Pack:StatusPacking()
    if not self.Sorting:Process() then
        return
    end

    self.Sorting:Disable()
    self:SetStatus(STATUS.PACKED)
end

function Pack:StatusPacked()
    self:SetStatus(STATUS.FINISH)
end

function Pack:StatusFinish()
    self:Stop()
    self:Message(L['Pack finish.'])
end

function Pack:StatusCancel()
    self:Stop()
end

Pack.statusProc = {
    [STATUS.READY] = Pack.StatusReady,
    [STATUS.STACKING] = Pack.StatusStacking,
    [STATUS.STACKED] = Pack.StatusStacked,
    [STATUS.PACKING] = Pack.StatusPacking,
    [STATUS.PACKED] = Pack.StatusPacked,
    [STATUS.SAVING] = Pack.StatusSaving,
    [STATUS.SAVED] = Pack.StatusSaved,
    [STATUS.FINISH] = Pack.StatusFinish,
    [STATUS.CANCEL] = Pack.StatusCancel,
}

function Pack:OnIdle()
    local proc = assert(self.statusProc[self.status])
    if proc then
        proc(self)
    end
end

function Pack:IsOptionBag()
    return self.opts.bag
end

function Pack:IsOptionBank()
    return self.opts.bank and self.isBankOpened
end

function Pack:IsOptionReverse()
    return self.reverse
end

function Pack:IsOptionSaving()
    return self.save and self.isBankOpened
end
