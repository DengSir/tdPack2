-- Junk.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 11:10:04 PM

---@type ns
local ns = select(2, ...)

local JunkOrder = ns.Addon:NewClass('JunkOrder', ns.Order)
ns.JunkOrder = JunkOrder

function JunkOrder:Constructor(profile)
    self.cache = {}
    self:Build(profile)
end

function JunkOrder:Build(profile)
    for i, v in ipairs(profile) do
        if type(v) == 'number' then
            self.cache[v] = true
        end
    end
end

function JunkOrder:GetOrder(item)
    return self:IsJunk(item) and '9' or '0'
end

---@param item Item
function JunkOrder:IsJunk(item)
    local itemId = item:GetItemId()
    if self.cache[itemId] then
        return false
    end
    if Scrap then
        return Scrap:IsJunk(itemId)
    else
        local _, _, quality, _, _, _, _, _, _, _, price = GetItemInfo(itemId)
        return quality == LE_ITEM_QUALITY_POOR and price and price > 0
    end
end
