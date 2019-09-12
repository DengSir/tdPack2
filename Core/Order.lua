-- Order.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 3:01:06 AM

---@type ns
local ns = select(2, ...)
local Addon = ns.Addon

---@class Order
local Order = Addon:NewClass('Order')
ns.Order = Order

function Order:GetOrder(item)
    error('Not implemented')
end

function Order._Meta:__call(item)
    return self:GetOrder(item)
end
