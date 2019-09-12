-- Config.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 7:22:32 PM

---@type ns
local ns = select(2, ...)
local L = ns.L

local WEAPON = GetItemClassInfo(LE_ITEM_CLASS_WEAPON) -- 武器
local ARMOR = GetItemClassInfo(LE_ITEM_CLASS_ARMOR) -- 护甲
local CONTAINER = GetItemClassInfo(LE_ITEM_CLASS_CONTAINER) -- 容器
local QUIVER = GetItemClassInfo(LE_ITEM_CLASS_QUIVER) -- 箭袋
local RECIPE = GetItemClassInfo(LE_ITEM_CLASS_RECIPE) -- 配方
local TRADEGOODS = GetItemClassInfo(LE_ITEM_CLASS_TRADEGOODS) -- 商品
local CONSUMABLE = GetItemClassInfo(LE_ITEM_CLASS_CONSUMABLE) -- 消耗品
local QUEST = GetItemClassInfo(LE_ITEM_CLASS_QUESTITEM) -- 任务
local MISC = GetItemClassInfo(LE_ITEM_CLASS_MISCELLANEOUS) -- 其它
local PROJECTILE = GetItemClassInfo(LE_ITEM_CLASS_PROJECTILE) -- 弹药
local FISHINGPOLE = GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_FISHINGPOLE) -- 鱼竿

ns.DEFAULT_CUSTOM_ORDER = {
    HEARTHSTONE_ITEM_ID, -- 炉石
    'tip:' .. L.KeywordMount, --
    5060, -- 潜行者工具
    2901, -- 矿工锄
    5956, -- 铁匠锤
    7005, -- 剥皮刀
    'type:' .. FISHINGPOLE, --
    'type:' .. WEAPON, --
    'type:' .. ARMOR, --
    'type:' .. CONTAINER, --
    'type:' .. QUIVER, --
    'type:' .. PROJECTILE, --
    'type:' .. RECIPE, --
    'type:' .. TRADEGOODS .. ' & tip:' .. L.KeywordClass, --
    'type:' .. TRADEGOODS, --
    'type:' .. CONSUMABLE .. ' & tip:' .. L.KeywordClass, --
    'type:' .. CONSUMABLE .. ' & tip:' .. L.KeywordFood, --
    'type:' .. CONSUMABLE .. ' & tip:' .. L.KeywordWater, --
    'type:' .. CONSUMABLE, --
    'type:' .. CONSUMABLE, --
    'type:' .. MISC, --
    'type:' .. QUEST, --
}

ns.DEFAULT_EQUIP_LOC_ORDER = {
    'INVTYPE_2HWEAPON', -- 双手
    'INVTYPE_WEAPON', -- 单手
    'INVTYPE_WEAPONMAINHAND', -- 主手
    'INVTYPE_WEAPONOFFHAND', -- 副手
    'INVTYPE_SHIELD', -- 副手
    'INVTYPE_HOLDABLE', -- 副手物品
    'INVTYPE_RANGED', -- 远程
    'INVTYPE_RELIC', -- 圣物
    -- 'INVTYPE_RANGEDRIGHT',      --远程
    -- 'INVTYPE_THROWN',           --投掷
    'INVTYPE_HEAD', -- 头部
    'INVTYPE_SHOULDER', -- 肩部
    'INVTYPE_CHEST', -- 胸部
    'INVTYPE_ROBE', -- 胸部
    'INVTYPE_HAND', -- 手
    'INVTYPE_LEGS', -- 腿部
    'INVTYPE_WRIST', -- 手腕
    'INVTYPE_WAIST', -- 腰部
    'INVTYPE_FEET', -- 脚
    'INVTYPE_CLOAK', -- 背部
    'INVTYPE_NECK', -- 颈部
    'INVTYPE_FINGER', -- 手指
    'INVTYPE_TRINKET', -- 饰品
    'INVTYPE_BODY', -- 衬衣
    'INVTYPE_TABARD', -- 战袍
    'INVTYPE_WEAPONMAINHAND_PET', -- 主要攻击
    'INVTYPE_AMMO', -- 弹药
    'INVTYPE_BAG', -- 背包
    'INVTYPE_QUIVER', -- 箭袋
}
