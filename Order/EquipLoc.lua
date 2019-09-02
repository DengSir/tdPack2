-- EquipLoc.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/1/2019, 1:41:40 AM

---@type ns
local ns = select(2, ...)

local EquipLocOrder = ns.Addon:NewClass('EquipLocOrder', ns.Order)
ns.EquipLocOrder = EquipLocOrder

function EquipLocOrder:Constructor(profile)
    self:Build(profile)
end

function EquipLocOrder:Build(profile)
    self.cache, self.default = ns.ToOrderCache(profile)
end

---@param item Item
function EquipLocOrder:GetOrder(item)
    return self.cache[item:GetItemEquipLoc()] or self.default
end
