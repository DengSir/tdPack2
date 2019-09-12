-- Pack.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 3:14:49 AM

local select, ipairs = select, ipairs
local tinsert, tremove, wipe = table.insert, table.remove, wipe

local InCombatLockdown, UnitIsDead, GetCursorInfo = InCombatLockdown, UnitIsDead, GetCursorInfo

---@type ns
local ns = select(2, ...)
local ripairs = ns.ripairs
local L = ns.L

local Pack = ns.Addon:NewModule('Pack', 'AceEvent-3.0', 'AceTimer-3.0')
ns.Pack = Pack

local STATUS_FREE = 0
local STATUS_READY = 1
local STATUS_STACKING = 2
local STATUS_STACKED = 3
local STATUS_PACKING = 4
local STATUS_PACKED = 5
local STATUS_FINISH = 6
local STATUS_CANCEL = 7

function Pack:OnEnable()
    self.isBankOpened = false
    self.status = STATUS_FREE
    ---@type Slot[]
    self.slots = {}
    ---@type Bag[]
    self.bags = {}

    self:RegisterEvent('BANKFRAME_OPENED')
    self:RegisterEvent('BANKFRAME_CLOSED')
    self:RegisterEvent('PLAYER_REGEN_DISABLED')
end

function Pack:BANKFRAME_OPENED()
    self.isBankOpened = true
end

function Pack:BANKFRAME_CLOSED()
    if self.isBankOpened and self.status ~= STATUS_FREE then
        self:SetStatus(STATUS_CANCEL)
        self:ShowMessage(L['Leave bank, pack cancel.'], 1, 0, 0)
    end
    self.isBankOpened = nil
end

function Pack:PLAYER_REGEN_DISABLED()
    if self.status ~= STATUS_FREE then
        self:SetStatus(STATUS_CANCEL)
        self:ShowMessage(L['Player enter combat, pack cancel.'], 1, 0, 0)
    end
end

function Pack:IsLocked()
    for _, bag in ipairs(self.bags) do
        if bag:IsLocked() then
            return true
        end
    end
end

function Pack:FindSlot(item, tarSlot)
    for _, bag in ipairs(self.bags) do
        local slot = bag:FindSlot(item, tarSlot)
        if slot then
            return slot
        end
    end
end

function Pack:Start()
    if self.status ~= STATUS_FREE then
        self:ShowMessage(L['Packing now'], 1, 0, 0)
        return
    end

    if UnitIsDead('player') then
        self:ShowMessage(L['Player is dead'], 1, 0, 0)
        return
    end

    if InCombatLockdown() then
        self:ShowMessage(L['Player in combat'], 1, 0, 0)
        return
    end

    if GetCursorInfo() then
        self:ShowMessage(L['Please drop the item, money or skills.'], 1, 0, 0)
        return
    end

    self:SetStatus(STATUS_READY)
    self:ScheduleRepeatingTimer('OnIdle', 0.05)
end

function Pack:Stop()
    self:CancelAllTimers()

    wipe(self.bags)
    wipe(self.slots)
    self:SetStatus(STATUS_FREE)
end

function Pack:ShowMessage(text, r, g, b)
    ns.Addon:Printf(text)
end

function Pack:IterateBags()
    return coroutine.wrap(function()
        for _, bag in ipairs(ns.GetBags()) do
            coroutine.yield(bag)
        end

        if self.isBankOpened then
            for _, bag in ipairs(ns.GetBanks()) do
                coroutine.yield(bag)
            end
        end
    end)
end

function Pack:StackReady()
    for bag in self:IterateBags() do
        for slot = 1, ns.GetBagNumSlots(bag) do
            tinsert(self.slots, ns.Slot:New(nil, bag, slot))
        end
    end
end

function Pack:Stack()
    local stackingSlots = {}
    local complete = true

    local function isCanStack(slot)
        if slot:IsEmpty() then
            return false
        end
        if not slot:IsFull() then
            return true
        end

        if not self.isBankOpened then
            return false
        end

        local stacking = stackingSlots[slot:GetItemId()]
        if not stacking then
            return false
        end

        if stacking:IsBank() and slot:IsBag() then
            return true
        end

        return false
    end

    for i, slot in ripairs(self.slots) do
        if slot:IsLocked() then
            complete = false
        else
            if isCanStack(slot) then
                local itemId = slot:GetItemId()
                if stackingSlots[itemId] then
                    slot:MoveTo(stackingSlots[itemId])

                    stackingSlots[itemId] = nil
                    complete = false
                else
                    stackingSlots[itemId] = slot
                end
            else
                tremove(self.slots, i)
            end
        end
    end
    return complete
end

function Pack:StackFinish()
    wipe(self.slots)
end

function Pack:PackReady()
    wipe(self.bags)

    local bag, bank

    bag = ns.Bag:New('bag')
    tinsert(self.bags, bag)

    if self.isBankOpened then
        bank = ns.Bag:New('bank')
        tinsert(self.bags, bank)

        -- if tdPack:IsLoadToBag() and tdPack:IsSaveToBank() then
        --     local loadTo = bank:GetSwapItems()
        --     local saveTo = bag:GetSwapItems()

        --     bag:ChooseItems(loadTo)
        --     bank:ChooseItems(saveTo)

        --     bag:RestoreItems()
        --     bank:RestoreItems()
        -- elseif tdPack:IsLoadToBag() then
        --     local loadTo = bank:GetSwapItems()
        --     bag:ChooseItems(loadTo)
        --     bank:RestoreItems()
        -- elseif tdPack:IsSaveToBank() then
        --     local saveTo = bag:GetSwapItems()
        --     bank:ChooseItems(saveTo)
        --     bag:RestoreItems()
        -- end

        bank:Sort()
    end
    bag:Sort()
end

function Pack:Pack()
    local complete = true
    for _, bag in ipairs(self.bags) do
        if not bag:Pack() then
            complete = false
        end
    end
    return complete
end

function Pack:PackFinish()
    wipe(self.bags)
end

function Pack:SetStatus(status)
    self.status = status
end

function Pack:StatusReady()
    if self:IsLocked() then
        return
    end

    self:StackReady()
    self:SetStatus(STATUS_STACKING)
end

function Pack:StatusStacking()
    if not self:Stack() then
        return
    end

    self:SetStatus(STATUS_STACKED)
    self:StackFinish()
end

function Pack:StatusStacked()
    if self:IsLocked() then
        return
    end

    self:PackReady()
    self:SetStatus(STATUS_PACKING)
end

function Pack:StatusPacking()
    if not self:Pack() then
        return
    end

    self:SetStatus(STATUS_PACKED)
    self:PackFinish()
end

function Pack:StatusPacked()
    self:SetStatus(STATUS_FINISH)
end

function Pack:StatusFinish()
    self:Stop()
    self:ShowMessage(L['Pack finish.'], 0, 1, 0)
end

function Pack:StatusCancel()
    self:Stop()
end

Pack.statusProc = {
    [STATUS_READY] = Pack.StatusReady,
    [STATUS_STACKING] = Pack.StatusStacking,
    [STATUS_STACKED] = Pack.StatusStacked,
    [STATUS_PACKING] = Pack.StatusPacking,
    [STATUS_PACKED] = Pack.StatusPacked,
    [STATUS_FINISH] = Pack.StatusFinish,
    [STATUS_CANCEL] = Pack.StatusCancel,
}

function Pack:OnIdle()
    local proc = self.statusProc[self.status]
    if proc then
        proc(self)
    end
end
