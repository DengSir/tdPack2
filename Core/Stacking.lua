-- Stacking.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/10/2019, 10:38:31 AM

---- LUA
local tinsert, tremove, wipe = table.insert, table.remove, table.wipe or wipe

---@type ns
local ns = select(2, ...)
local ripairs = ns.ripairs

---@type Pack
local Pack = ns.Pack

---@class Stacking
---@field private slots Slot[]
---@field private stackingSlots table<number, Slot>
local Stacking = ns.Pack:NewModule('Stacking')

function Stacking:OnInitialize()
    self.slots = {}
    self.stackingSlots = {}
end

function Stacking:OnEnable()
    if Pack:IsOptionBag() then
        self:InitBag(Pack:GetBag())
    end
    if Pack:IsOptionBank() then
        self:InitBag(Pack:GetBank())
    end
end

function Stacking:InitBag(bag)
    for _, group in bag:IterateGroups() do
        for i = 1, group:GetSlotCount() do
            tinsert(self.slots, group:GetSlot(i))
        end
    end
end

function Stacking:OnDisable()
    wipe(self.slots)
    wipe(self.stackingSlots)
end

function Stacking:Process()
    wipe(self.stackingSlots)

    local complete = true

    for i, slot in ripairs(self.slots) do
        if slot:IsLocked() then
            complete = false
        else
            if self:IsCanStack(slot) then
                local itemId = slot:GetItemId()
                local stackingSlot = self.stackingSlots[itemId]
                if stackingSlot then
                    slot:MoveTo(stackingSlot)

                    self.stackingSlots[itemId] = nil
                    complete = false
                else
                    self.stackingSlots[itemId] = slot
                end
            else
                tremove(self.slots, i)
            end
        end
    end
    return complete
end

---@param slot Slot
function Stacking:IsCanStack(slot)
    if slot:IsEmpty() then
        return false
    end

    if not slot:IsFull() then
        return true
    end

    if not Pack:IsOptionBag() or not Pack:IsOptionBank() then
        return false
    end

    local stackingSlot = self.stackingSlots[slot:GetItemId()]
    if not stackingSlot then
        return false
    end

    if stackingSlot:IsBank() and slot:IsBag() then
        return true
    end
    return false
end
