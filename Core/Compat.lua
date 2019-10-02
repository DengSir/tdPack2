-- Compat.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/20/2019, 1:24:08 AM

-- if true then
--     return
-- end

local ns = select(2, ...)
local Addon = ns.Addon

function SortBags()
    Addon:Pack('bag')
end

function SortBankBags()
    Addon:Pack('bank')
end

-- function SortReagentBankBags()
-- end

-- function DepositReagentBank()
-- end
