-- Slot.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 3:29:19 AM

local InCombatLockdown, PickupContainerItem = InCombatLockdown, PickupContainerItem

---@type ns
local ns = select(2, ...)

---@class Slot: Base
local Slot = ns.Addon:NewClass('Slot', ns.Base)

function Slot:Constructor(parent, bag, slot)
    self.bag = bag
    self.slot = slot
end

---@return number
function Slot:GetBag()
    return self.bag
end

---@return number
function Slot:GetSlot()
    return self.slot
end

---@return number|string
function Slot:GetItemId()
    return ns.GetBagSlotId(self.bag, self.slot)
end

---@return number
function Slot:GetFamily()
    return ns.GetBagSlotFamily(self.bag, self.slot)
end

---@return boolean
function Slot:IsEmpty()
    return ns.IsBagSlotEmpty(self.bag, self.slot)
end

---@return boolean
function Slot:IsFull()
    return ns.IsBagSlotFull(self.bag, self.slot)
end

---@return boolean
function Slot:IsLocked()
    return ns.IsBagSlotLocked(self.bag, self.slot)
end

function Slot:IsBank()
    return ns.IsBank(self.bag)
end

function Slot:IsBag()
    return ns.IsBag(self.bag)
end

---@param slot Slot
---@return boolean
function Slot:MoveTo(slot)
    if self:IsEmpty() then
        if slot:IsEmpty() then
            return true
        else
            return slot:MoveTo(self)
        end
    end

    if InCombatLockdown() then
        return false, 'player in combat'
    end

    if self:IsLocked() or slot:IsLocked() then
        return false, 'some slot is locked'
    end

    PickupContainerItem(self.bag, self.slot)
    PickupContainerItem(slot.bag, slot.slot)

    return true
end

---@param item Item
---@return boolean
function Slot:IsItemIn(item)
    return self:GetItemId() == item:GetItemId() and ns.GetBagSlotCount(self.bag, self.slot) == item:GetItemCount()
end
