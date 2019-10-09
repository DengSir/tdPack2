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

----@class Pack
local Pack = ns.Addon:NewModule('Pack', 'AceEvent-3.0', 'AceTimer-3.0')

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

function Pack:Start(opts)
    if (opts.bank or opts.save) and not opts.bag and not self.isBankOpened then
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

    self.reverse = opts.reverse()
    self.opts = opts
    self:SetStatus(STATUS.READY)
    self:ScheduleRepeatingTimer('OnIdle', 0.03)
end

function Pack:Stop()
    self:CancelAllTimers()

    wipe(self.bags)
    wipe(self.slots)
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

function Pack:IterateBags()
    return coroutine.wrap(function()
        if self:IsOptionBag() then
            for _, bag in ipairs(ns.GetBags()) do
                coroutine.yield(bag)
            end
        end

        if self:IsOptionBank() then
            if self.isBankOpened then
                for _, bag in ipairs(ns.GetBanks()) do
                    coroutine.yield(bag)
                end
            end
        end
    end)
end

function Pack:StackReady()
    for bag in self:IterateBags() do
        for slot = 1, ns.GetBagNumSlots(bag) do
            tinsert(self.slots, Slot:New(nil, bag, slot))
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

        if not self:IsOptionBank() or not self:IsOptionBag() then
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

    if self:IsOptionBag() then
        bag = Bag:New(BAG_TYPE.BAG)
        tinsert(self.bags, bag)
    end

    if self:IsOptionBank() then
        bank = Bag:New(BAG_TYPE.BANK)
        tinsert(self.bags, bank)

        -- if self:IsOptionSaving() then
        --     local saveTo = bag:GetSwapItems()
        --     bank:ChooseItems(saveTo)
        --     bag:RestoreItems()
        -- end

        bank:Sort()
    end

    if bag then
        bag:Sort()
    end
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

function Pack:SaveReady()
    local items = {}
    local itemSlots = {}
    local movedSlots = {}

    for _, bag in ipairs(ns.GetBanks()) do
        for slot = 1, ns.GetBagNumSlots(bag) do
            if ns.IsBagSlotEmpty(bag, slot) then
                tinsert(self.slots, Slot:New(nil, bag, slot))
            end
        end
    end

    for _, bag in ipairs(ns.GetBags()) do
        for slot = 1, ns.GetBagNumSlots(bag) do
            if not ns.IsBagSlotEmpty(bag, slot) then
                local item = Item:New(nil, bag, slot)
                if ns.Rule:IsItemNeedJump(item) then
                    tinsert(items, item)
                    itemSlots[item] = Slot:New(nil, bag, slot)
                end
            end
        end
    end

    ns.Rule:SortItems(items, ns.SORT_TYPE.SAVING)

    for i, item in ipairs(items) do
        local tarSlot = self.slots[i]
        if not tarSlot then
            break
        end

        local slot = itemSlots[item]
        slot:MoveTo(tarSlot)

        movedSlots[slot] = true
    end

    for slot in pairs(movedSlots) do
        tinsert(self.slots, slot)
    end
end

function Pack:Save()
    for _, slot in ipairs(self.slots) do
        if slot:IsLocked() then
            return false
        end
    end
    return true
end

function Pack:SaveFinish()
    wipe(self.slots)
end

function Pack:SetStatus(status)
    self.status = status
end

function Pack:StatusReady()
    if self:IsLocked() then
        return
    end

    self:StackReady()
    self:SetStatus(STATUS.STACKING)
end

function Pack:StatusStacking()
    if not self:Stack() then
        return
    end

    self:SetStatus(STATUS.STACKED)
    self:StackFinish()
end

function Pack:StatusStacked()
    if self:IsLocked() then
        return
    end

    if self:IsOptionSaving() then
        self:SaveReady()
        self:SetStatus(STATUS.SAVING)
    else
        self:StatusSaved()
    end
end

function Pack:StatusSaving()
    if not self:Save() then
        print('save not finish')
        return
    end

    print('saved')

    self:SetStatus(STATUS.SAVED)
    self:SaveFinish()
end

function Pack:StatusSaved()
    self:PackReady()
    self:SetStatus(STATUS.PACKING)
end

function Pack:StatusPacking()
    if not self:Pack() then
        return
    end

    self:SetStatus(STATUS.PACKED)
    self:PackFinish()
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
    local proc = self.statusProc[self.status]
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
    return self.opts.save and self.isBankOpened
end
