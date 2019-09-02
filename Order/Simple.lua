-- Simple.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/1/2019, 1:48:19 AM

---@type ns
local ns = select(2, ...)

local SimpleOrder = ns.Addon:NewClass('SimpleOrder', ns.Order)
ns.SimpleOrder = SimpleOrder

function SimpleOrder:Constructor(func)
    self.func = func
end

function SimpleOrder:GetOrder(item)
    return self.func(item)
end
