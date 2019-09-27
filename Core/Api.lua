-- Api.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:46:11 PM

local select, type, assert, ipairs = select, type, assert, ipairs
local tonumber, band = tonumber, bit.band
local tostring, format, strrep = tostring, string.format, string.rep

local GetItemFamily, GetItemInfoInstant = GetItemFamily, GetItemInfoInstant
local GetContainerNumSlots, GetContainerNumFreeSlots = GetContainerNumSlots, GetContainerNumFreeSlots
local GetContainerItemLink, GetContainerItemID = GetContainerItemLink, GetContainerItemID
local GetContainerItemInfo = GetContainerItemInfo
local GetCursorPosition = GetCursorPosition

local UIParent = UIParent

---@type ns
local ns = select(2, ...)
local L = ns.L

local function riter(t, i)
    i = i - 1
    if i > 0 then
        return i, t[i]
    end
end

function ns.ripairs(t)
    assert(type(t) == 'table')

    return riter, t, #t + 1
end

function ns.memorize(func, nilable)
    local cache = {}
    return function(arg1, ...)
        local value = cache[arg1]
        if value == nil then
            value = func(arg1, ...)
            cache[arg1] = value
        end
        return value
    end
end

function ns.memorizenilable(func)
    local cache = {}
    return function(arg1, ...)
        local value = cache[arg1]
        if value == nil then
            value = func(arg1, ...) or cache
            cache[arg1] = value
        end
        return value ~= cache and value or nil
    end
end

local BAGS = {BACKPACK_CONTAINER}
local BANKS = {BANK_CONTAINER}
do
    for i = 1, NUM_BAG_SLOTS do
        tinsert(BAGS, i)
    end

    for i = 1, NUM_BANKBAGSLOTS do
        tinsert(BANKS, i + NUM_BAG_SLOTS)
    end
end

local BAGS_SET = tInvert(BAGS)
local BANKS_SET = tInvert(BANKS)

function ns.IsBag(id)
    return BAGS_SET[id]
end

function ns.IsBank(id)
    return BANKS_SET[id]
end

function ns.GetBags()
    return BAGS
end

function ns.GetBanks()
    return BANKS
end

function ns.GetItemFamily(itemId)
    if not itemId then
        return 0
    end
    if type(itemId) == 'string' then
        return 0
    end
    if select(4, GetItemInfoInstant(itemId)) == 'INVTYPE_BAG' then
        return 0
    end
    return GetItemFamily(itemId)
end

function ns.GetBagFamily(bag)
    return select(2, GetContainerNumFreeSlots(bag))
end

function ns.GetBagNumSlots(bag)
    return GetContainerNumSlots(bag)
end

function ns.FindSlot(item, tarSlot)
    return ns.Pack:FindSlot(item, tarSlot)
end

function ns.GetItemId(itemLink)
    if not itemLink then
        return
    end

    if itemLink:find('battlepet') then
        local id, level, quality = itemLink:match('battlepet:(%d+):(%d+):(%d+)')

        return (('battlepet:%d:%d:%d'):format(id, level, quality))
    else
        return (tonumber(itemLink:match('item:(%d+)')))
    end
end

function ns.GetBagSlotId(bag, slot)
    local itemLink = GetContainerItemLink(bag, slot)
    if not itemLink then
        return
    end
    return ns.GetItemId(itemLink)
end

function ns.IsBagSlotEmpty(bag, slot)
    return not GetContainerItemID(bag, slot)
end

function ns.IsBagSlotFull(bag, slot)
    local itemId = GetContainerItemID(bag, slot)
    if not itemId then
        return false
    end

    local info = ns.ItemInfoCache:Get(itemId)
    local stackCount = info.itemStackCount or 1
    return stackCount == 1 or stackCount == ns.GetBagSlotCount(bag, slot)
end

function ns.GetBagSlotCount(bag, slot)
    return (select(2, GetContainerItemInfo(bag, slot)))
end

function ns.GetBagSlotFamily(bag, slot)
    return ns.GetItemFamily(ns.GetBagSlotId(bag, slot))
end

function ns.IsBagSlotLocked(bag, slot)
    return (select(3, GetContainerItemInfo(bag, slot)))
end

function ns.ToOrderCache(list)
    local len = #tostring(#list)
    local f = '%0' .. len .. 'd'
    local cache = {}
    for i, v in ipairs(list) do
        cache[v] = format(f, i)
    end
    return cache, strrep('9', len)
end

if ns.IsRetail then
    function ns.IsFamilyContains(bagFamily, itemFamily)
        return band(bagFamily, itemFamily) > 0
    end
else
    function ns.IsFamilyContains(bagFamily, itemFamily)
        return bagFamily == itemFamily
    end
end

function ns.GetClickToken(button, control, shift, alt)
    local key
    if button == 'LeftButton' then
        key = 1
    elseif button == 'RightButton' then
        key = 2
    end

    return key + (control and 0x10000 or 0) + (shift and 0x20000 or 0) + (alt and 0x40000 or 0)
end

function ns.IsAdvanceRule(item)
    return type(item) == 'table'
end

function ns.GetCursorPosition()
    local x, y = GetCursorPosition()
    local scale = UIParent:GetScale()
    return x / scale, y / scale
end

local function CopyTo(src, dest)
    dest = dest or {}
    for k, v in pairs(src) do
        if type(v) == 'table' then
            dest[k] = CopyTo(v, {})
        else
            dest[k] = v
        end
    end
    return dest
end

ns.CopyTo = CopyTo
