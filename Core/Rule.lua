-- Rule.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 12:00:28 AM

---@type ns
local ns = select(2, ...)

---- NS
local Addon = ns.Addon
local Item = ns.Item

---- LUA
local pairs, setmetatable = pairs, setmetatable
local format = string.format
local tconcat, sort = table.concat, table.sort or sort

---@class Rule
local Rule = Addon:NewModule('Rule', 'AceEvent-3.0')

function Rule:OnInitialize()
    local sortingProfile = Addon:GetSortingRules()

    self.nameOrder = Item.GetItemName
    self.typeOrder = Item.GetItemType
    self.subTypeOrder = Item.GetItemSubType
    self.customOrder = ns.CustomOrder:New(sortingProfile)
    self.levelQualityOrder = function(item)
        local level = 9999 - item:GetItemLevel()
        local quality = 99 - item:GetItemQuality()

        if item:IsEquippable() then
            return format('%04d,%02d', level, quality)
        else
            return format('%02d,%04d', quality, level)
        end
    end

    self.staticOrder = ns.CachableOrder:New({
        GetKey = function(item)
            return item:GetItemId()
        end,
        GetOrder = function(item)
            return tconcat({
                self.customOrder(item), --
                self.typeOrder(item), --
                self.subTypeOrder(item), --
                self.levelQualityOrder(item), --
                self.nameOrder(item), --
            }, ',')
        end,
    })

    self.junkOrder = ns.JunkOrder:New(sortingProfile)
    self.countOrder = function(item)
        if ns.Pack:IsOptionReverse() then
            return format('%04d', 9999 - item:GetItemCount())
        else
            return format('%04d', item:GetItemCount())
        end
    end

    self.itemOrder = ns.CachableOrder:New({
        cache = setmetatable({}, {__mode = 'k'}),
        GetKey = function(item)
            return item
        end,
        GetOrder = function(item)
            return tconcat({
                self.junkOrder(item), --
                self.staticOrder(item), --
                self.countOrder(item), --
            }, ',')
        end,
    })

    self:RegisterMessage('TDPACK_SORTING_RULES_UPDATE')
end

function Rule:TDPACK_SORTING_RULES_UPDATE()
    self.junkOrder:RequestRebuild()
    self.customOrder:RequestRebuild()
    self.staticOrder:RequestRebuild()
end

local function comp(lhs, rhs)
    return Rule:GetOrder(lhs) < Rule:GetOrder(rhs)
end

function Rule:SortItems(items)
    sort(items, comp)
end

function Rule:GetOrder(item)
    return self.itemOrder(item)
end
