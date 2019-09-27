-- Item.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:54:09 PM

---@type ns
local ns = select(2, ...)
local ItemInfoCache = ns.ItemInfoCache

local IsEquippableItem = IsEquippableItem

---@class Item: Base
local Item = ns.Addon:NewClass('Item', ns.Base)

function Item:Constructor(parent, bag, slot)
    local itemId = ns.GetBagSlotId(bag, slot)
    self.itemCount = ns.GetBagSlotCount(bag, slot) or 1
    self.info = ns.ItemInfoCache:Get(itemId)
end

function Item:GetItemCount()
    return self.itemCount
end

function Item:IsReady()
    return self.info:IsReady()
end

function Item:GetFamily()
    return self.info.itemFamily
end

function Item:GetItemId()
    return self.info.itemId
end

function Item:GetItemName()
    return self.info.itemName
end

function Item:GetItemLink()
    return self.info.itemLink
end

function Item:GetItemType()
    return self.info.itemType
end

function Item:GetItemSubType()
    return self.info.itemSubType
end

function Item:GetItemLevel()
    return self.info.itemLevel
end

function Item:GetItemQuality()
    return self.info.itemQuality
end

function Item:GetItemTexture()
    return self.info.itemTexture
end

function Item:GetItemEquipLoc()
    return self.info.itemEquipLoc
end

function Item:IsEquippable()
    return self.info.itemEquippable
end

function Item:HasSpell()
    return not not self.info.itemSpellName
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
