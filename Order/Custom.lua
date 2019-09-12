-- Custom.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/1/2019, 12:50:23 AM

---@type ns
local ns = select(2, ...)

local LibSearch = LibStub('LibItemSearch-1.2', true)

local CustomOrder = ns.Addon:NewClass('CustomOrder', ns.Order)
ns.CustomOrder = CustomOrder

function CustomOrder:Constructor(profile)
    self.orders = {
        function(item)
            return self.simple[item:GetItemId()]
        end,
        function(item)
            if not LibSearch then
                return
            end

            for _, v in ipairs(self.advance) do
                if LibSearch:Matches(item:GetItemLink(), v) then
                    return self.simple[v]
                end
            end
        end,
        function(item)
            return self.simple['#' .. item:GetItemType() .. '##' .. item:GetItemSubType()]
        end,
        function(item)
            return self.simple['##' .. item:GetItemSubType()]
        end,
        function(item)
            return self.simple['#' .. item:GetItemType()]
        end,
    }
    self.advance = {}
    self:Build(profile)
end

function CustomOrder:Build(profile)
    self.simple, self.default = ns.ToOrderCache(profile)

    wipe(self.advance)

    for i, v in ipairs(profile) do
        if type(v) == 'string' and not v:find('^#') then
            tinsert(self.advance, v)
        end
    end
end

---@param item Item
function CustomOrder:GetOrder(item)
    for _, v in ipairs(self.orders) do
        local order = v(item)
        if order then
            return order
        end
    end
    return self.default
end
