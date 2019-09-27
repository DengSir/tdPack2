-- Order.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 3:01:06 AM

---@type ns
local ns = select(2, ...)
local Addon = ns.Addon

---@class Order
local Order = Addon:NewClass('Order')

function Order:Constructor(profile)
    self.profile = profile
    self:RequestRebuild()
end

function Order:GetOrder(item)
    error('Not implemented')
end

function Order._Meta:__call(item)
    return self:GetOrder(item)
end

function Order:RequestRebuild()
    if not self.isDirty then
        self.isDirty = true

        local getOrder = self.GetOrder
        self.GetOrder = function(self, ...)
            self:Build()
            self.isDirty = nil
            self.GetOrder = getOrder
            return self:GetOrder(...)
        end
    end
end

function Order:Build()
    error('Not implemented')
end
