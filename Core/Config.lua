-- Config.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 7:22:32 PM

---@type ns
local ns = select(2, ...)
---@type L
local L = ns.L

---- WOW
local GetSpellInfo = GetSpellInfo
local GetItemClassInfo = GetItemClassInfo
local GetItemSubClassInfo = GetItemSubClassInfo

local CONTAINER = GetItemClassInfo(LE_ITEM_CLASS_CONTAINER) -- 容器
local QUIVER = GetItemClassInfo(LE_ITEM_CLASS_QUIVER) -- 箭袋
local RECIPE = GetItemClassInfo(LE_ITEM_CLASS_RECIPE) -- 配方
local TRADEGOODS = GetItemClassInfo(LE_ITEM_CLASS_TRADEGOODS) -- 商品
local CONSUMABLE = GetItemClassInfo(LE_ITEM_CLASS_CONSUMABLE) -- 消耗品
local QUEST = GetItemClassInfo(LE_ITEM_CLASS_QUESTITEM) -- 任务
local MISC = GetItemClassInfo(LE_ITEM_CLASS_MISCELLANEOUS) -- 其它
local PROJECTILE = GetItemClassInfo(LE_ITEM_CLASS_PROJECTILE) -- 弹药
local REAGENT = GetItemClassInfo(LE_ITEM_CLASS_REAGENT) -- 材料
local KEY = GetItemClassInfo(LE_ITEM_CLASS_KEY) -- 钥匙
local FISHINGPOLE = GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, LE_ITEM_WEAPON_FISHINGPOLE) -- 鱼竿

local function Rule(rule, icon, comment, c)
    local children
    if c then
        children = {}
        local exists = {}
        for i, v in ipairs(c) do
            if not exists[v.rule] then
                tinsert(children, v)
                exists[v.rule] = true
            end
        end
    end
    return {rule = rule, comment = comment, icon = icon, children = children}
end

local function Type(name, icon, children)
    return Rule('type:' .. name, icon, name, children)
end

local function TipLocale(key, icon, children)
    return Rule('tip:' .. L['KEYWORD_' .. key], icon, L['COMMENT_' .. key], children)
end

local function Tip(tip, icon, children)
    return Rule('tip:' .. tip, icon, tip, children)
end

local function Spell(id, icon, children)
    local spellName = GetSpellInfo(id)
    return Rule('spell:' .. spellName, icon, spellName, children)
end

local function Equip(key, icon)
    return Rule('equip:' .. key, icon, key)
end

ns.DEFAULT_CUSTOM_ORDER = {
    HEARTHSTONE_ITEM_ID, -- 炉石
    TipLocale('MOUNT', 132261), -- 坐骑
    5060, -- 潜行者工具
    2901, -- 矿工锄
    5956, -- 铁匠锤
    7005, -- 剥皮刀
    Type(FISHINGPOLE, 132932), -- 鱼竿
    Rule('equip', 132722, EQUIPSET_EQUIP, {
        Equip(INVTYPE_2HWEAPON, 135324), -- 双手
        Equip(INVTYPE_WEAPONMAINHAND, 133045), -- 主手
        Equip(INVTYPE_WEAPON, 135641), -- 单手
        Equip(INVTYPE_SHIELD, 134955), -- 副手盾
        Equip(INVTYPE_WEAPONOFFHAND, 134955), -- 副手
        Equip(INVTYPE_HOLDABLE, 134333), -- 副手物品
        Equip(INVTYPE_RANGED, 135498), -- 远程
        Equip(INVTYPE_RELIC, 134915), -- 圣物
        Equip(INVTYPE_HEAD, 133136), -- 头部
        Equip(INVTYPE_NECK, 133294), -- 颈部
        Equip(INVTYPE_SHOULDER, 135033), -- 肩部
        Equip(INVTYPE_CLOAK, 133768), -- 背部
        Equip(INVTYPE_CHEST, 132644), -- 胸部
        Equip(INVTYPE_ROBE, 132644), -- 胸部
        Equip(INVTYPE_WRIST, 132608), -- 手腕
        Equip(INVTYPE_HAND, 132948), -- 手
        Equip(INVTYPE_WAIST, 132511), -- 腰部
        Equip(INVTYPE_LEGS, 134588), -- 腿部
        Equip(INVTYPE_FEET, 132541), -- 脚
        Equip(INVTYPE_FINGER, 133345), -- 手指
        Equip(INVTYPE_TRINKET, 134010), -- 饰品
        Equip(INVTYPE_BODY, 135022), -- 衬衣
        Equip(INVTYPE_TABARD, 135026), -- 战袍
    }), -- 装备
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
    Rule('type:!' .. QUEST .. ' & tip:!' .. QUEST, 134237, MISC, {
        Type(MISC, 134400), -- 其它
        Type(KEY, 134237), -- 钥匙
    }), --
    Tip(ITEM_STARTS_QUEST, 132836), -- 接任务
    Type(QUEST, 133469, {
        Rule('spell', 133942), --
    }), -- 任务
}
