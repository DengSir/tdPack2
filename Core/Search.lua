-- Search.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/26/2019, 2:09:42 AM

local select = select
local GetItemInfo, GetItemSpell, IsEquippableItem = GetItemInfo, GetItemSpell, IsEquippableItem

local ns = select(2, ...)

local CustomSearch = LibStub('CustomSearch-1.0')
local ItemSearch = LibStub('LibItemSearch-1.2')

local Search = {}
ns.Search = Search

Search.Filters = {}
do
    for k, v in pairs(ItemSearch.Filters) do
        Search.Filters[k] = v
    end
end

function Search:Matches(link, search)
    return CustomSearch:Matches(link, search, self.Filters)
end

local Filters = Search.Filters

Filters.spell = {
    keyword = 'spell',

    canSearch = function(self, operator, search)
        return search:lower() == self.keyword
    end,

    match = function(self, item, _, search)
        return not not GetItemSpell(item)
    end,
}

Filters.spellName = {
    tags = {'p', 'spell'},
    onlyTags = true,

    canSearch = function(self, operator, search)
        return not operator and search
    end,

    match = function(self, item, _, search)
        local spellName, spellId = GetItemSpell(item)
        return CustomSearch:Find(search, spellName or '')
    end,
}

Filters.equippable = {
    keyword1 = 'equip',
    keyword2 = EQUIPSET_EQUIP:lower(),

    canSearch = function(self, operator, search)
        return not operator and (self.keyword1 == search or self.keyword2 == search:lower())
    end,

    match = function(self, link, ...)
        return IsEquippableItem(link) and select(9, GetItemInfo(link)) ~= 'INVTYPE_BAG'
    end,
}

for k, v in pairs(Filters) do
    ItemSearch.Filters[k] = v
end
