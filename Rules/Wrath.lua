-- Wrath.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 3/9/2026, 10:03:10 AM
--
---@class ns
local ns = select(2, ...)

local L = ns.L
local C = ns.C

local Enum = Enum

local GetSpellInfo = GetSpellInfo

ns.RuleMaker()

local CONSUMABLE = C.Item.GetItemClassInfo(Enum.ItemClass.Consumable) -- 消耗品
local QUEST = C.Item.GetItemClassInfo(Enum.ItemClass.Questitem) -- 任务
local MISC = C.Item.GetItemClassInfo(Enum.ItemClass.Miscellaneous) -- 其它

ns.DEFAULT_SORTING_RULES = {
    Group(L['Transporter'], 134414, {
        HEARTHSTONE_ITEM_ID, -- 炉石
        44315, -- 召回卷轴 III
        44314, -- 召回卷轴 II
        37118, -- 召回卷轴 I
        37863, -- 烈酒的遥控器
    }), --
    Group(L['Usuable'], 294476, {
        23821, -- 气阀微粒提取器
        49040, -- 基维斯
        40769, -- 废物贩卖机器人制造器
        34113, -- 战地修理机器人110G
        18232, -- 修理机器人74A型
    }), --
    Group(L['Tools'], 134065, {
        5060, -- 潜行者工具
        9149, -- 点金石
        40772, -- 侏儒军刀
        44452, -- 符文泰坦神铁棒
        22463, -- 符文恒金棒
        22462, -- 符文精金棒
        22461, -- 符文魔铁棒
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
        20815, -- 珠宝制作工具
        20824, -- 简易研磨器
        39505, -- 学者的书写工具
        Weapon(Enum.ItemWeaponSubclass.Fishingpole, 132932), -- 鱼竿
        33820, -- 饱经风霜的渔帽
        46349, -- 大厨的帽子
    }), --
    Rule(EQUIPSET_EQUIP, 132722, 'equip'), -- 装备
    Type(Enum.ItemClass.Projectile, 132382), -- 弹药
    Type(Enum.ItemClass.Container, 133652), -- 容器
    Type(Enum.ItemClass.Quiver, 134407), -- 箭袋
    Type(Enum.ItemClass.Recipe, 134939), -- 配方
    Rule(CONSUMABLE, 134829, 'type:' .. CONSUMABLE .. ' & tip:!' .. QUEST .. ' & spell', {
        Consumable(7, 133692), -- 绷带
        Consumable(3, 134742), -- 合剂
        Consumable(2, 134773), -- 药剂
        Spell(439, 134830), -- 治疗药水
        Spell(438, 134851), -- 法力药水
        Consumable(1, 134729), -- 药水
        Consumable(4, 134937), -- 卷轴
        Consumable(5, 133953, {
            43015, -- 鱼
            34753, -- 猪
            -- Spell(44166, 134051), -- 恢复体能
            -- SpellId(57366, 134034, SPELL_STAT2_NAME), -- 敏捷
            -- SpellId(57370, 134016, SPELL_STAT1_NAME), -- 力量
            -- SpellId(33260, 134009, ATTACK_POWER_TOOLTIP), -- AP
            -- SpellId(33264, 134044, STAT_SPELLDAMAGE), -- 法伤
            -- SpellId(57359, 134040, STAT_HIT_CHANCE), -- 命中
            -- SpellId(33269, 134904, STAT_SPELLHEALING), -- 治疗
            -- SpellId(43706, 134019, SPELL_CRIT_CHANCE), -- 法暴
            -- SpellId(33266, 134035, MANA_REGEN), -- 5回
            -- SpellId(33258, 133902, SPELL_STAT3_NAME), -- 耐力
            -- SpellId(35271, 134004, SPELL_STAT3_NAME), -- 耐力
            -- SpellId(33253, 134030, SPELL_STAT3_NAME), -- 耐力
            -- SpellId(45618, 133915, STAT_CATEGORY_RESISTANCE), -- 抗性
            Spell(433, 133945), -- 进食
            Spell(430, 132794), -- 喝水
        }), -- 食物和饮料
        Consumable(6, 133604), -- 物品强化
        Group(GetSpellInfo(7620), 136245, {46006, 34861, 6533, 6532, 6530, 6529}), -- 鱼饵
    }), -- 消耗品
    Type(Enum.ItemClass.Tradegoods, 132905, {
        Tip(format(ITEM_CLASSES_ALLOWED, ''), 132273), -- 职业
        Trade(2, 133715), -- 爆炸物
        Trade(3, 134441), -- 装置
        Trade(1, 133025), -- 零件
        Trade(5, 132903), -- 布料
        Trade(6, 134256), -- 皮革
        Trade(7, 133217), -- 金属和矿石
        Trade(8, 134027), -- 肉类
        Trade(9, 134215), -- 草药
        Trade(10, 135819), -- 元素
        Trade(12, 132864), -- 附魔
        Trade(4, 134379), -- 珠宝加工
        Trade(13, 132850), -- 原料
    }), -- 商品
    Type(Enum.ItemClass.Gem, 133272, {
        Gem(0, 134083), -- 红
        Gem(2, 134114), -- 黄
        Gem(1, 134080), -- 蓝
        Gem(5, 134111), -- 橙
        Gem(4, 134093), -- 绿
        Gem(3, 134103), -- 紫
        Gem(8, 132886), -- 棱彩
        Gem(6, 134098), -- 多彩
        Gem(7, 134087), -- 简易
    }), -- 珠宝
    Rule(MISC, 134237, 'type:!' .. QUEST .. ' & tip:!' .. QUEST, {
        Misc(Enum.ItemClass.Reagent, 133587), -- 材料
        Type(Enum.ItemClass.Consumable, 134420), -- 消耗品
        Type(Enum.ItemClass.Miscellaneous, 134400), -- 其它
        Type(Enum.ItemClass.Key, 134237), -- 钥匙
    }), --
    Rule(QUEST, 133469, 'type:' .. QUEST .. ' | tip:' .. QUEST, {
        Tip(ITEM_STARTS_QUEST, 132836), -- 接任务
        Rule(nil, 133942, 'spell'), --
    }), -- 任务
}

ns.DEFAULT_SAVING_RULES = {
    16885, -- 重垃圾箱
    Trade(1, 133025), -- 零件
    Trade(5, 132903), -- 布料
    Trade(6, 134256), -- 皮革
    Trade(7, 133217), -- 金属和矿石
    Trade(8, 134027), -- 肉类
    Trade(9, 134215), -- 草药
    Trade(10, 135819), -- 元素
    Trade(12, 132864), -- 附魔
    Trade(4, 134379), -- 珠宝加工
    Trade(13, 132850), -- 原料
    Type(Enum.ItemClass.Gem, 133272),
}
