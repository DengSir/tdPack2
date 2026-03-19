-- EquipSet.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 3/10/2026, 7:54:03 PM
--
---@type ns
local ns = select(2, ...)

local tinsert = table.insert
local tconcat = table.concat
local wipe = table.wipe or wipe

---@class Addon.EquipSetOrder : Addon.Order
local EquipSetOrder = ns.Addon:NewClass('EquipSetOrder', ns.Order)

function EquipSetOrder:Constructor()
    self.items = {}
end

function EquipSetOrder:Build()
    wipe(self.items)

    for _, setId in pairs(C_EquipmentSet.GetEquipmentSetIDs()) do
        local name = C_EquipmentSet.GetEquipmentSetInfo(setId)
        local itemIds = C_EquipmentSet.GetItemIDs(setId)

        for _, itemId in pairs(itemIds) do
            if itemId > 0 then
                self.items[itemId] = self.items[itemId] or {}
                tinsert(self.items[itemId], name)
            end
        end
    end

    for itemId, v in pairs(self.items) do
        self.items[itemId] = tconcat(v, ',')
    end
end

function EquipSetOrder:GetOrder(item)
    local itemId = item:GetItemId()
    return self.items[itemId] or '\255\255\255\255'
end
