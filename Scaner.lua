-- Scaner.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 6/18/2021, 11:06:53 AM
--
---@type ns
local ns = select(2, ...)

function tdPack2Scan()
    local valids = (function()
        local r = {}
        for i = 1, 32 do
            r[bit.lshift(1, i - 1)] = true
        end
        return r
    end)()

    local bags = {
        [bit.lshift(1, 4 - 1)] = '制皮',
        [bit.lshift(1, 5 - 1)] = '铭文',
        [bit.lshift(1, 6 - 1)] = '草药',
        [bit.lshift(1, 7 - 1)] = '附魔',
        [bit.lshift(1, 8 - 1)] = '工程',
        [bit.lshift(1, 10 - 1)] = '宝石',
        [bit.lshift(1, 11 - 1)] = '矿石',
        [bit.lshift(1, 12 - 1)] = '灵魂',
        [bit.lshift(1, 16 - 1)] = '钓鱼',
        [bit.lshift(1, 17 - 1)] = '烹饪',
        [bit.lshift(1, 20 - 1)] = '玩具',
        [bit.lshift(1, 21 - 1)] = 'Archaeology',
        [bit.lshift(1, 22 - 1)] = 'Alchemy',
        [bit.lshift(1, 23 - 1)] = 'Blacksmithing',
        [bit.lshift(1, 24 - 1)] = 'First Aid',
        [bit.lshift(1, 25 - 1)] = '珠宝',
        [bit.lshift(1, 26 - 1)] = 'Skinning',
        [bit.lshift(1, 27 - 1)] = 'Tailoring',
    }

    local co
    local waitings = {}
    local f = CreateFrame('Frame')
    f:RegisterEvent('GET_ITEM_INFO_RECEIVED')
    f:SetScript('OnEvent', function(_, _, itemId, ok)
        if waitings[itemId] then
            coroutine.resume(co, GetItemInfo(itemId))
        end
    end)

    local function wait(itemId)
        waitings[itemId] = true
        coroutine.yield()
    end

    local function getBags(family)
        local sb = {}
        for k, v in pairs(bags) do
            if bit.band(family, k) > 0 then
                tinsert(sb, v)
            end
        end
        return table.concat(sb, ',')
    end

    co = coroutine.create(function()
        for itemId in pairs(ns.ITEM_FAMILIES) do
            local name = GetItemInfo(itemId)
            if not name then
                name = wait(itemId)
                print(name)
            end

            if not name then
                print(itemId)
            else
                local f = GetItemFamily(itemId)
                if not valids[f] then
                    print(f, itemId, getBags(f), (select(2, GetItemInfo(itemId))))
                end
            end

        end
        print('done')
    end)

    coroutine.resume(co)
end
