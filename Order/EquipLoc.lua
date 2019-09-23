-- EquipLoc.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/1/2019, 1:41:40 AM

---@type ns
local ns = select(2, ...)

local EquipLocOrder = ns.Addon:NewClass('EquipLocOrder', ns.Order)
ns.EquipLocOrder = EquipLocOrder

function EquipLocOrder:Build()
    self.orders, self.default = ns.ToOrderCache(self.profile)
end

---@param item Item
function EquipLocOrder:GetOrder(item)
    return self.orders[item:GetItemEquipLoc()] or self.default
end
