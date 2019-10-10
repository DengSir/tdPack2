-- Sorting.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/10/2019, 11:02:51 AM

local tinsert, wipe = table.insert, table.wipe or wipe
local ipairs = ipairs

---@type ns
local ns = select(2, ...)

local Pack = ns.Pack

---@class Sorting
---@field private bags Bag[]
local Sorting = Pack:NewModule('Sorting')

function Sorting:OnInitialize()
    self.bags = {}
end

function Sorting:OnEnable()
    if Pack:IsOptionBag() then
        local bag = Pack:GetBag()
        tinsert(self.bags, bag)
        bag:Sort()
    end
    if Pack:IsOptionBank() then
        local bank = Pack:GetBank()
        tinsert(self.bags, bank)
        bank:Sort()
    end
end

function Sorting:OnDisable()
    wipe(self.bags)
end

function Sorting:Process()
    local complete = true
    for _, bag in ipairs(self.bags) do
        if not bag:Pack() then
            complete = false
        end
    end
    return complete
end

function Sorting:IsLocked()
    for _, bag in ipairs(self.bags) do
        if bag:IsLocked() then
            return true
        end
    end
end
