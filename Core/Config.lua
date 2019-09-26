-- Config.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 7:22:32 PM

---@type ns
local ns = select(2, ...)
---@type L
local L = ns.L

local GetSpellInfo = GetSpellInfo
local GetItemClassInfo, GetItemSubClassInfo = GetItemClassInfo, GetItemSubClassInfo

local CONTAINER = GetItemClassInfo(LE_ITEM_CLASS_CONTAINER) -- 容器
local QUIVER = GetItemClassInfo(LE_ITEM_CLASS_QUIVER) -- 箭袋
local RECIPE = GetItemClassInfo(LE_ITEM_CLASS_RECIPE) -- 配方
local TRADEGOODS = GetItemClassInfo(LE_ITEM_CLASS_TRADEGOODS) -- 商品
local CONSUMABLE = GetItemClassInfo(LE_ITEM_CLASS_CONSUMABLE) -- 消耗品
local QUEST = GetItemClassInfo(LE_ITEM_CLASS_QUESTITEM) -- 任务
local MISC = GetItemClassInfo(LE_ITEM_CLASS_MISCELLANEOUS) -- 其它
local PROJECTILE = GetItemClassInfo(LE_ITEM_CLASS_PROJECTILE) -- 弹药
local REAGENT = GetItemClassInfo(LE_ITEM_CLASS_REAGENT) -- 材料
local FISHINGPOLE = GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_FISHINGPOLE) -- 鱼竿

local function Rule(rule, icon, comment, children)
    return {rule = rule, comment = comment, icon = icon, children = children}
end

local function Type(name, icon, children)
    return Rule('type:' .. name, icon, name, children)
end

local function TipLocale(key, icon, children)
    return Rule('tip:' .. L['KEYWORD_' .. key], icon, L['COMMENT_' .. key], children)
end

local function Tip(tip, icon, children)
    return Rule('tip:' .. tip, icon, nil, children)
end

local function Spell(id, icon, children)
    local spellName = GetSpellInfo(id)
    return Rule('spell:' .. spellName, icon, spellName, children)
end

ns.DEFAULT_CUSTOM_ORDER = {
    HEARTHSTONE_ITEM_ID, -- 炉石
    TipLocale('MOUNT', 132261), -- 坐骑
    5060, -- 潜行者工具
    2901, -- 矿工锄
    5956, -- 铁匠锤
    7005, -- 剥皮刀
    Type(FISHINGPOLE, 132932), -- 鱼竿
    Rule(EQUIPSET_EQUIP, 132722), -- 装备
    Type(CONTAINER, 133652), -- 容器
    Type(QUIVER, 134407), -- 箭袋
    Type(PROJECTILE, 132382), -- 弹药
    Type(RECIPE, 134939), -- 配方
    Type(TRADEGOODS, 132905, {
        TipLocale('CLASS', 132273), -- 职业
    }), -- 商品
    Type(CONSUMABLE, 134829, {
        TipLocale('CLASS', 132273), -- 职业
        Spell(746, 133685), -- 急救
        Spell(433, 133945), -- 食物
        Spell(430, 132794), -- 水
        Spell(439, 134830), -- 治疗药水
        Spell(438, 134851), -- 法力药水
    }), -- 消耗品
    Type(REAGENT, 133587), -- 材料
    Type(MISC, 134400), -- 其它
    Type(QUEST, [[Interface\ContainerFrame\UI-Icon-QuestBang]], {
        Tip(ITEM_STARTS_QUEST), -- 接任务
    }), -- 任务
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
