-- Rule.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 12:00:28 AM

---@type ns
local ns = select(2, ...)
local Addon = ns.Addon

local Rule = ns.Addon:NewModule('Rule')
ns.Rule = Rule

function Rule:OnInitialize()
    self.orderCache = setmetatable({}, {__mode = 'v'})

    self.junkOrder = ns.JunkOrder:New(ns.DEFAULT_CUSTOM_ORDER)
    self.customOrder = ns.CustomOrder:New(ns.DEFAULT_CUSTOM_ORDER)
    self.equipLocOrder = ns.EquipLocOrder:New(ns.DEFAULT_EQUIP_LOC_ORDER)
    self.levelOrder = function(item)
        return format('%04d', 9999 - item:GetItemLevel())
    end
    self.qualityOrder = function(item)
        return format('%02d', 99 - item:GetItemQuality())
    end
    self.countOrder = function(item)
        if ns.Pack:IsOptionReverse() then
            return format('%04d', 9999 - item:GetItemCount())
        else
            return format('%04d', item:GetItemCount())
        end
    end
end

local function comp(lhs, rhs)
    return Rule:GetOrder(lhs) < Rule:GetOrder(rhs)
end

function Rule:SortItems(items)
    sort(items, comp)
end

---@param item Item
function Rule:GetOrder(item)
    local order = self.orderCache[item]
    if not order then
        order = self:BuildOrder(item)
        self.orderCache[item] = order
    end
    return order
end

---@param item Item
function Rule:BuildOrder(item)
    local level = self.levelOrder(item)
    local quality = self.qualityOrder(item)
    local levelQuality
    if item:IsEquippable() then
        levelQuality = level .. quality
    else
        levelQuality = quality .. level
    end

    return table.concat({
        self.junkOrder(item), --
        self.customOrder(item), --
        self.equipLocOrder(item), --
        item:GetItemType(), --
        item:GetItemSubType(), --
        levelQuality, --
        item:GetItemName(), --
        self.countOrder(item), --
    }, ',')
end
