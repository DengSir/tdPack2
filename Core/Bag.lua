-- Bag.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/28/2019, 10:37:26 PM

local select, pairs, ipairs = select, pairs, ipairs
local tinsert, tremove, wipe = table.insert, table.remove, wipe

---@type ns
local ns = select(2, ...)
local ripairs = ns.ripairs

---@class Bag
local Bag = ns.Addon:NewClass('Bag')

function Bag:Constructor(bagClass)
    self.bags = bagClass == 'bag' and ns.GetBags() or ns.GetBanks()
    self.groups = {}
    self.swapItems = {}
    self:InitGroups()
end

function Bag:InitGroups()
    local initedGroups = {}
    for _, bag in ipairs(self.bags) do
        local bagFamily = ns.GetBagFamily(bag)
        if bagFamily and not initedGroups[bagFamily] then
            initedGroups[bagFamily] = true

            local group = ns.Group:New(self, bagFamily)
            if bagFamily == 0 then
                self.groups[0] = group
            else
                tinsert(self.groups, group)
            end
        end
    end
end

function Bag:GetBags()
    return self.bags
end

function Bag:IterateGroups()
    return pairs(self.groups)
end

function Bag:IterateTradeGroups()
    return ipairs(self.groups)
end

function Bag:GetNormalGroup()
    return self.groups[0]
end

function Bag:IsLocked()
    for _, group in self:IterateGroups() do
        if group:IsLocked() then
            return true
        end
    end
end

function Bag:Pack()
    local complete = true
    for _, group in self:IterateGroups() do
        local success, result = group:Pack()
        if not success then
            complete = false
        end
    end
    return complete
end

function Bag:FindSlot(item, tarSlot)
    for _, group in self:IterateGroups() do
        local slot = group:FindSlot(item, tarSlot)
        if slot then
            return slot
        end
    end
end

function Bag:ChooseItems(items)
    for _, group in self:IterateTradeGroups() do
        group:ChooseItems(items)
    end
    self:GetNormalGroup():ChooseItems(items)
end

function Bag:RestoreItems()
    for _, item in ripairs(self.swapItems) do
        tinsert(item:GetParent():GetItems(), item)
    end
    wipe(self.swapItems)
end

function Bag:Sort()
    for _, group in self:IterateTradeGroups() do
        group:ChooseItems(self:GetNormalGroup():GetItems())
    end
    for _, group in self:IterateGroups() do
        group:SortItems()
        group:FilterSlots()
    end
end

function Bag:GetSwapItems()
    wipe(self.swapItems)

    local methodName = self.bagClass == 'bag' and 'NeedSaveToBank' or 'NeedLoadToBag'

    for _, group in self:IterateGroups() do
        local items = group:GetItems()
        for index, item in ripairs(items) do
            if item[methodName](item) then
                tremove(items, index)
                tinsert(self.swapItems, item)
            end
        end
    end
    ns.Rule:SortItems(self.swapItems)

    return self.swapItems
end
