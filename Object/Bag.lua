-- Bag.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/28/2019, 10:37:26 PM
--
---- LUA
local pairs, ipairs = pairs, ipairs
local tinsert = table.insert

---@type ns
local ns = select(2, ...)

---- NS
local Group = ns.Group

---@class Addon.Bag: Object
---@field private groups Addon.Group[]
local Bag = ns.Addon:NewClass('Bag')

function Bag:Constructor(bagType)
    self.bags = ns.GetBags(bagType)
    self:InitGroups()
end

function Bag:InitGroups()
    local groups = {}
    local initedFamilies = {}
    for _, bag in ipairs(self.bags) do
        local bagFamily = ns.GetBagFamily(bag)
        if not bagFamily then
            return
        end
        if bagFamily and not initedFamilies[bagFamily] then
            initedFamilies[bagFamily] = true

            local group = Group:New(self, bagFamily)
            if bagFamily == 0 then
                groups[0] = group
            else
                tinsert(groups, group)
            end
        end
    end
    self.groups = groups
end

function Bag:IsReady()
    return not not self.groups
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
        local success = group:Pack()
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

function Bag:Sort()
    for _, group in self:IterateGroups() do
        group:InitItems()
    end

    for _, group in self:IterateTradeGroups() do
        group:ChooseItems(self:GetNormalGroup():GetItems())
    end
    for _, group in self:IterateGroups() do
        group:SortItems()
        group:FilterSlots()
    end
end
