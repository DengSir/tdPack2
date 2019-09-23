-- Custom.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/1/2019, 12:50:23 AM

local ipairs, type = ipairs, type
local tinsert, wipe = table.insert, table.wipe
local format = string.format

---@type ns
local ns = select(2, ...)

local LibSearch = LibStub('LibItemSearch-1.2')

---@class CustomOrder: Order
local CustomOrder = ns.Addon:NewClass('CustomOrder', ns.Order)
ns.CustomOrder = CustomOrder

function CustomOrder:Constructor(profile)
    self.methods = {
        function(item)
            return self.simpleOrders[item:GetItemId()]
        end, function(item)
            return self:GetAdvanceOrder(item:GetItemLink())
        end, function(item)
            return self.simpleOrders['#' .. item:GetItemType() .. '##' .. item:GetItemSubType()]
        end, function(item)
            return self.simpleOrders['##' .. item:GetItemSubType()]
        end, function(item)
            return self.simpleOrders['#' .. item:GetItemType()]
        end,
    }

    self.simpleOrders = {}
    self.advanceRules = {}
end

function CustomOrder:GetAdvanceOrder(link, rules)
    for _, v in ipairs(rules or self.advanceRules) do
        if LibSearch:Matches(link, v.rule) then
            if v.children then
                local order = self:GetAdvanceOrder(link, v.children)
                if order then
                    return order
                end
            end
            return v.order
        end
    end
end

function CustomOrder:BuildInternal(profile, rules, last)
    for _, v in ipairs(profile) do
        local t = type(v)
        if t == 'number' or t == 'string' then
            self.simpleOrders[v] = last
        elseif t == 'table' then
            local item = {}

            if v.children then
                item.children = {}
                last = self:BuildInternal(v.children, item.children, last)
            end

            item.rule = v.rule
            item.order = last
            tinsert(rules, item)
        end
        last = last + 1
    end
    return last
end

function CustomOrder:Build()
    wipe(self.advanceRules)
    wipe(self.simpleOrders)
    self.default = self:BuildInternal(self.profile, self.advanceRules, 0)
end

---@param item Item
function CustomOrder:GetOrderInternal(item)
    for _, v in ipairs(self.methods) do
        local order = v(item)
        if order then
            return order
        end
    end
    return self.default
end

function CustomOrder:GetOrder(item)
    return format('%08d', self:GetOrderInternal(item))
end
