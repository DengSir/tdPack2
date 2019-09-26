-- ItemInfo.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/27/2019, 12:15:26 AM

---@type ns
local ns = select(2, ...)

local IsEquippableItem = IsEquippableItem

local ItemInfo = ns.Addon:NewClass('ItemInfo')
ns.ItemInfo = ItemInfo

ItemInfo.cache = {}

function ItemInfo:Constructor(itemId)
    local itemName, itemLink, itemType, itemSubType, itemEquipLoc, itemQuality, itemLevel, itemTexture =
        ns.GetItemInfo(itemId)

    assert(itemName)

    self.itemId = itemId
    self.itemName = itemName or ''
    self.itemLink = itemLink or ''
    self.itemType = itemType or ''
    self.itemSubType = itemSubType or ''
    self.itemEquipLoc = itemEquipLoc or ''
    self.itemQuality = itemQuality or 1
    self.itemLevel = itemLevel or 0
    self.itemTexture = itemTexture or 0
    self.itemFamily = ns.GetItemFamily(itemId) or 0
    self.itemEquippable = IsEquippableItem(itemId) or false

    self.cache[itemId] = self
end

function ItemInfo:Get(itemId)
    return ItemInfo.cache[itemId] or ItemInfo:New(itemId)
end
