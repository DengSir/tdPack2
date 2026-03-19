-- Vanilla.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 3/9/2026, 10:03:10 AM
--
---@class ns
local ns = select(2, ...)

local L = ns.L
local C = ns.C

ns.RuleMaker()

local CONSUMABLE = C.Item.GetItemClassInfo(Enum.ItemClass.Consumable) -- 消耗品
local QUEST = C.Item.GetItemClassInfo(Enum.ItemClass.Questitem) -- 任务
local MISC = C.Item.GetItemClassInfo(Enum.ItemClass.Miscellaneous) -- 其它

ns.DEFAULT_SORTING_RULES = {
    HEARTHSTONE_ITEM_ID, -- 炉石
    Tag('Mount', 132261), -- 坐骑
    Tag('Pet', 132598), -- 宠物
    Group(L['Tools'], 134065, {
        5060, -- 潜行者工具
        5175, -- 大地图腾
        5177, -- 水之图腾
        5176, -- 火焰图腾
        5178, -- 空气图腾
        9149, -- 点金石
        16207, -- 符文奥金棒
        11145, -- 符文真银棒
        11130, -- 符文金棒
        6339, -- 符文银棒
        6218, -- 符文铜棒
        7005, -- 剥皮刀
        2901, -- 矿工锄
        5956, -- 铁匠锤
        6219, -- 扳手
        10498, -- 侏儒微调器
        19727, -- 血镰刀
        4471, -- 燧石和火绒
        Weapon(Enum.ItemWeaponSubclass.Fishingpole, 132932), -- 鱼竿
    }), --
    Rule(EQUIPSET_EQUIP, 132722, 'equip', {
        Rule('Set', 132722, 'bset'), --
        Group('非套装', 132722, {
            Slot('INVTYPE_2HWEAPON', 135324), -- 双手
            Slot('INVTYPE_WEAPONMAINHAND', 133045), -- 主手
            Slot('INVTYPE_WEAPON', 135641), -- 单手
            Slot('INVTYPE_SHIELD', 134955), -- 副手盾
            Slot('INVTYPE_WEAPONOFFHAND', 134955), -- 副手
            Slot('INVTYPE_HOLDABLE', 134333), -- 副手物品
            Slot('INVTYPE_RANGED', 135498), -- 远程
            Slot('INVTYPE_RANGEDRIGHT', 135468), -- 远程
            Slot('INVTYPE_THROWN', 132394), -- 投掷武器
            Slot('INVTYPE_RELIC', 134915), -- 圣物
            Slot('INVTYPE_HEAD', 133136), -- 头部
            Slot('INVTYPE_NECK', 133294), -- 颈部
            Slot('INVTYPE_SHOULDER', 135033), -- 肩部
            Slot('INVTYPE_CLOAK', 133768), -- 背部
            Slot('INVTYPE_CHEST', 132644), -- 胸部
            Slot('INVTYPE_ROBE', 132644), -- 胸部
            Slot('INVTYPE_WRIST', 132608), -- 手腕
            Slot('INVTYPE_HAND', 132948), -- 手
            Slot('INVTYPE_WAIST', 132511), -- 腰部
            Slot('INVTYPE_LEGS', 134588), -- 腿部
            Slot('INVTYPE_FEET', 132541), -- 脚
            Slot('INVTYPE_FINGER', 133345), -- 手指
            Slot('INVTYPE_TRINKET', 134010), -- 饰品
            Slot('INVTYPE_BODY', 135022), -- 衬衣
            Slot('INVTYPE_TABARD', 135026), -- 战袍
        }),
    }), -- 装备
    Type(Enum.ItemClass.Projectile, 132382), -- 弹药
    Type(Enum.ItemClass.Container, 133652), -- 容器
    Type(Enum.ItemClass.Quiver, 134407), -- 箭袋
    Type(Enum.ItemClass.Recipe, 134939), -- 配方
    Rule(CONSUMABLE, 134829, 'class:' .. CONSUMABLE .. ' & tip:!' .. QUEST .. ' & spell', {
        TipLocale('CLASS', 132273), -- 职业
        Spell(746, 133685), -- 急救
        Spell(433, 133945), -- 进食
        Spell(430, 132794), -- 喝水
        Spell(439, 134830), -- 治疗药水
        Spell(438, 134851), -- 法力药水
    }), -- 消耗品
    Type(Enum.ItemClass.Tradegoods, 132905, {
        TipLocale('CLASS', 132273), -- 职业
        Tag('Cloth', 132903), -- 布
        Tag('Leather', 134256), -- 皮
        Tag('Metal & Stone', 133217), -- 金属和矿石
        Tag('Cooking', 134027), -- 烹饪
        Tag('Herb', 134215), -- 草药
        Tag('Elemental', 135819), -- 元素
        Tag('Enchanting', 132864), -- 附魔
    }), -- 商品
    Rule(MISC, 134237, 'class:!' .. QUEST .. ' & tip:!' .. QUEST, {
        Type(Enum.ItemClass.Consumable, 134420), -- 消耗品
        Type(Enum.ItemClass.Miscellaneous, 134400), -- 其它
        Type(Enum.ItemClass.Key, 134237), -- 钥匙
    }), --
    Rule(QUEST, 133469, 'class:' .. QUEST .. ' | tip:' .. QUEST, {
        Tip(ITEM_STARTS_QUEST, 132836), -- 接任务
        Rule(nil, 133942, 'spell'), --
    }), -- 任务
}

ns.DEFAULT_SAVING_RULES = {}
