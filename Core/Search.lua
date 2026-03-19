-- Search.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/26/2019, 2:09:42 AM
--
-- luacheck: ignore 212/search 212/operator
--
---- LUA
local _G = _G
local select, pairs, ipairs = select, pairs, ipairs
local tonumber = tonumber

---@type ns
local ns = select(2, ...)

local L = ns.L
local C = ns.C

---- LIBS
local Parser = LibStub('CustomSearch-1.0')
local ItemSearch = LibStub('ItemSearch-1.3')
local Filters = {}

---@class Addon.Search
local Search = {}
ns.Search = Search

function Search:Matches(link, search)
    if not self.filters or not self.rawFilters or self.rawFilters ~= ItemSearch.Filters then
        self.rawFilters = ItemSearch.Filters
        self.filters = {}

        for k, v in pairs(self.rawFilters) do
            self.filters[k] = v
        end

        for k, v in pairs(Filters) do
            self.filters[k] = v
        end
    end
    return Parser:Matches({link = link}, search, self.filters)
end

Filters._spellKeyword = {
    keyword = 'spell',

    canSearch = function(self, operator, search)
        return search:lower() == self.keyword
    end,

    match = function(self, item, _, search)
        return not not C.Item.GetItemSpell(item.link)
    end,
}

Filters._spell = {
    tags = {'spell'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return not operator and search
    end,

    match = function(self, item, _, search)
        local spellName, spellId = C.Item.GetItemSpell(item.link)
        local searchId = tonumber(search)
        if searchId then
            return searchId == spellId
        else
            return Parser:Find(search, spellName or '')
        end
    end,
}

Filters._equippable = {
    keyword1 = 'equip',
    keyword2 = EQUIPSET_EQUIP:lower(),

    exclude = tInvert {'INVTYPE_BAG', 'INVTYPE_AMMO'},

    canSearch = function(self, operator, search)
        return not operator and (self.keyword1 == search or self.keyword2 == search:lower())
    end,

    match = function(self, item)
        if not C.Item.IsEquippableItem(item.link) then
            return false
        end
        return not self.exclude[select(9, C.Item.GetItemInfo(item.link))]
    end,
}

Filters._blizzarSetKeyword = {
    keyword1 = 'bset',

    canSearch = function(self, operator, search)
        return not operator and self.keyword1 == search:lower()
    end,

    match = function(self, item, _, search)
        local setId = select(16, C.Item.GetItemInfo(item.link))
        return setId
    end,
}

Filters._blizzardSet = {
    tags = {'bset'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return not operator and search
    end,

    match = function(self, item, _, search)
        local setId = select(16, C.Item.GetItemInfo(item.link))
        if setId and setId ~= 0 then
            local setName = C.Item.GetItemSetInfo(setId)
            return Parser:Find(search, setName)
        end
    end,
}

Filters._invtype = {
    tags = {'inv'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return not operator and search
    end,

    match = function(self, item, _, search)
        local equipLoc = select(9, C.Item.GetItemInfo(item.link))
        if not equipLoc then
            return
        end
        local text = Parser:Clean(search)
        if text == equipLoc:lower() then
            return true
        end

        local localeLoc = _G[equipLoc]
        return localeLoc and text == localeLoc:lower()
    end,
}

Filters._tags = {
    tags = {'tag'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        if operator then
            return
        end
        if not ns.ITEM_TAG_KEYS[search:lower()] then
            return
        end
        return search
    end,

    match = function(self, item, _, search)
        local id = tonumber(item.link:match('item:(%d+)'))
        if not id then
            return
        end

        local key = ns.ITEM_TAG_KEYS[search:lower()]
        local tag = ns.ITEM_TAG_SETS[id]
        if not tag then
            return
        end
        return tag == key
    end,
}
