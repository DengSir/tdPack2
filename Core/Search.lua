-- Search.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/26/2019, 2:09:42 AM

local Search = LibStub('CustomSearch-1.0')
local Lib = LibStub('LibItemSearch-1.2')

Lib.Filters.spell = {
    tags = {'p', 'spell'},

    canSearch = function(self, operator, search)
        return not operator and search
    end,

    match = function(self, item, _, search)
        local spellName, spellId = GetItemSpell(item)
        return Search:Find(search, spellName or '')
    end,
}

Lib.Filters.equippable = {
    keyword1 = 'equip',
    keyword2 = EQUIPSET_EQUIP:lower(),

    canSearch = function(self, operator, search)
        return not operator and (self.keyword1 == search or self.keyword2 == search)
    end,

    match = function(self, link)
        return IsEquippableItem(link)
    end,
}
