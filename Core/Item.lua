-- Item.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:54:09 PM

---@type ns
local ns = select(2, ...)

---@class Item: Base
local Item = ns.Addon:NewClass('Item', ns.Base)
ns.Item = Item

function Item:Constructor(parent, bag, slot)
    local itemId = ns.GetBagSlotID(bag, slot)
    local itemName, itemType, itemSubType, itemEquipLoc, itemQuality, itemLevel, itemTexture = ns.GetItemInfo(itemId)

    self.itemId = itemId
    self.itemName = itemName
    self.itemType = itemType
    self.itemSubType = itemSubType
    self.itemEquipLoc = itemEquipLoc
    self.itemQuality = itemQuality
    self.itemLevel = itemLevel
    self.itemTexture = itemTexture
end

function Item:GetFamily()
    return ns.GetItemFamily(self.itemId)
end

function Item:NeedSaveToBank()
    if tdPack:IsLoadToBag() then
        return ns.Rule:NeedSaveToBank(self) and not ns.Rule:NeedLoadToBag(self)
    else
        return ns.Rule:NeedSaveToBank(self)
    end
end

function Item:NeedLoadToBag()
    if tdPack:IsSaveToBank() then
        return ns.Rule:NeedLoadToBag(self) and not ns.Rule:NeedSaveToBank(self)
    else
        return ns.Rule:NeedLoadToBag(self)
    end
end

function Item:GetItemId()
    return self.itemId or 0
end

function Item:GetItemName()
    return self.itemName or ''
end

function Item:GetItemType()
    return self.itemType or ''
end

function Item:GetItemSubType()
    return self.itemSubType or ''
end

function Item:GetItemLevel()
    return self.itemLevel or 0
end

function Item:GetItemQuality()
    return self.itemQuality or 1
end

function Item:GetItemTexture()
    return self.itemTexture or ''
end

function Item:GetItemEquipLoc()
    return self.itemEquipLoc or ''
end

function Item:IsEquippable()
    return IsEquippableItem(self.itemId)
end
