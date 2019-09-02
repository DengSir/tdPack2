-- Custom.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/1/2019, 12:50:23 AM

---@type ns
local ns = select(2, ...)

local CustomOrder = ns.Addon:NewClass('CustomOrder', ns.Order)
ns.CustomOrder = CustomOrder

function CustomOrder:Constructor(profile)
    self:Build(profile)
end

function CustomOrder:Build(profile)
    self.cache, self.default = ns.ToOrderCache(profile)
end

---@param item Item
function CustomOrder:GetOrder(item)
    local itemType = '#' .. item:GetItemType()
    local itemSubType = '##' .. item:GetItemSubType()
    local itemFullType = itemType .. itemSubType

    return
        self.cache[item:GetItemId()] or self.cache[itemFullType] or self.cache[itemSubType] or self.cache[itemType] or
            self.cache[item:GetItemName()] or self.default
end
