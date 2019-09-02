-- Rule.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 12:00:28 AM

---@type ns
local ns = select(2, ...)

local Rule = ns.Addon:NewModule('Rule')
ns.Rule = Rule

function Rule:OnInitialize()
    self.orderCache = {}

    self.junkOrder = ns.JunkOrder:New(ns.DEFAULT_CUSTOM_ORDER)
    self.customOrder = ns.CustomOrder:New(ns.DEFAULT_CUSTOM_ORDER)
    self.equipLocOrder = ns.EquipLocOrder:New(ns.DEFAULT_EQUIP_LOC_ORDER)
    self.levelOrder = ns.SimpleOrder:New(function(item)
        return format('%04d', 9999 - item:GetItemLevel())
    end)
    self.qualityOrder = ns.SimpleOrder:New(function(item)
        return format('%02d', 99 - item:GetItemQuality())
    end)
end

local function comp(lhs, rhs)
    return Rule:GetOrder(lhs) < Rule:GetOrder(rhs)
end

function Rule:SortItems(items)
    sort(items, comp)
end

---@param item Item
function Rule:GetOrder(item)
    local itemId = item:GetItemId()
    local order = self.orderCache[itemId]
    if order then
        return order
    end

    order = self:BuildOrder(item)
    self.orderCache[itemId] = order
    return order
end

---@param item Item
function Rule:BuildOrder(item)
    local level = self.levelOrder:GetOrder(item)
    local quality = self.qualityOrder:GetOrder(item)
    local levelQuality
    if item:IsEquippable() then
        levelQuality = level .. quality
    else
        levelQuality = quality .. level
    end

    return table.concat({
        self.junkOrder:GetOrder(item), --
        self.customOrder:GetOrder(item), --
        self.equipLocOrder:GetOrder(item), --
        item:GetItemType(), --
        item:GetItemSubType(), --
        levelQuality, --
        item:GetItemName(), --
    }, ',')
end

