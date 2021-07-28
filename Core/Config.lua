-- Config.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 7:22:32 PM
local ipairs = ipairs
local tinsert = table.insert

---@type ns
local ns = select(2, ...)
---@type L
local L = ns.L

---- WOW
local GetSpellInfo = GetSpellInfo
local GetItemClassInfo = GetItemClassInfo
local GetItemSubClassInfo = GetItemSubClassInfo

local function Rule(name, icon, rule, c)
    local children
    if c then
        children = {}
        local exists = {}
        for i, v in ipairs(c) do
            local isAdv = ns.IsAdvanceRule(v)
            if isAdv and (not v.rule or not exists[v.rule]) then
                tinsert(children, v)
                if v.rule then
                    exists[v.rule] = true
                end
            end
            if not isAdv then
                tinsert(children, v)
            end
        end
    end
    return {rule = rule, comment = name, icon = icon, children = children}
end

local function Group(name, icon, children)
    return Rule(name, icon, nil, children)
end

local function Type(type, icon, children)
    local name = GetItemClassInfo(type)
    return Rule(name, icon, 'type:' .. name, children)
end

local function SubType(type, subType, icon, children)
    local name = GetItemSubClassInfo(type, subType)
    return Rule(name, icon, 'type:' .. name, children)
end

local function Weapon(subType, icon, children)
    return SubType(LE_ITEM_CLASS_WEAPON, subType, icon, children)
end

local function Misc(subType, icon, children)
    return SubType(LE_ITEM_CLASS_MISCELLANEOUS, subType, icon, children)
end

local function Trade(subType, icon, children)
    return SubType(LE_ITEM_CLASS_TRADEGOODS, subType, icon, children)
end

local function Consumable(subType, icon, children)
    return SubType(LE_ITEM_CLASS_CONSUMABLE, subType, icon, children)
end

local function Slot(name, icon, children)
    return Rule(name, icon, 'slot:' .. name, children)
end

local function TipLocale(key, icon, children)
    return Rule(L['COMMENT_' .. key], icon, 'tip:' .. L['KEYWORD_' .. key], children)
end

local function Tip(tip, icon, children)
    return Rule(tip, icon, 'tip:' .. tip, children)
end

local function Tag(key, icon, children)
    local l = L['ITEM_TAG: ' .. key]
    return Rule(l, icon, 'tag:' .. l, children)
end

local function Spell(id, icon, children)
    local spellName = GetSpellInfo(id)
    return Rule(spellName, icon, 'spell:' .. spellName, children)
end

local CONSUMABLE = GetItemClassInfo(LE_ITEM_CLASS_CONSUMABLE) -- 消耗品
local QUEST = GetItemClassInfo(LE_ITEM_CLASS_QUESTITEM) -- 任务
local MISC = GetItemClassInfo(LE_ITEM_CLASS_MISCELLANEOUS) -- 其它
local TRADEGOODS = GetItemClassInfo(LE_ITEM_CLASS_TRADEGOODS) -- 商品
local MOUNT = GetItemSubClassInfo(LE_ITEM_CLASS_MISCELLANEOUS, LE_ITEM_MISCELLANEOUS_MOUNT)

ns.DEFAULT_SORTING_RULES = {
    HEARTHSTONE_ITEM_ID, -- 炉石
    184871, -- 黑暗之门
    -- @classic@
    Tag('Mount', 132261), -- 坐骑
    Tag('Pet', 132598), -- 宠物
    -- @end-classic@
    -- @bcc@
    Group(MOUNT, 132261, {
        Misc(LE_ITEM_MISCELLANEOUS_MOUNT, 132261), --
        -- 这几个数据有错误
        34061, -- [涡轮加速飞行器控制台]
        34060, -- [飞行器控制台]
        33189, -- [摇摇晃晃的魔法扫帚]
        21176, -- [黑色其拉共鸣水晶]
        23720, -- [乌龟坐骑]
    }), Misc(LE_ITEM_MISCELLANEOUS_COMPANION_PET, 132598, {
        11110, 11474, 11825, 11826, 12264, 12529, 13582, 13583, 13584, 180089, 19054, 19055, 20371, 20651, 21026, 21301,
        21305, 21308, 21309, 22114, 22235, 22780, 22781, 23002, 23007, 23015, 23083, 23712, 23713, 25535, 27445, 30360,
        31665, 31760, 32233, 32465, 32498, 32588, 32616, 32617, 32622, 33154, 33993, 34425, 34518, 34519, 34955, 37297,
        37298, 39656, 5332,
    }), --
    -- @end-bcc@
    Group(L['Tools'], 134065, {
        5060, -- 潜行者工具
        2901, -- 矿工锄
        5956, -- 铁匠锤
        7005, -- 剥皮刀
        9149, -- 点金石
        22463, -- 符文恒金棒
        22462, -- 符文精金棒
        22461, -- 符文魔铁棒
        16207, -- 符文奥金棒
        11145, -- 符文真银棒
        11130, -- 符文金棒
        6339, -- 符文银棒
        6218, -- 符文铜棒
        6219, -- 扳手
        10498, -- 侏儒微调器
        19727, -- 血镰刀
        20815, -- 珠宝制作工具
        4471, -- 燧石和火绒
        Weapon(LE_ITEM_WEAPON_FISHINGPOLE, 132932), -- 鱼竿
    }), --
    Rule(EQUIPSET_EQUIP, 132722, 'equip', {
        Slot(INVTYPE_2HWEAPON, 135324), -- 双手
        Slot(INVTYPE_WEAPONMAINHAND, 133045), -- 主手
        Slot(INVTYPE_WEAPON, 135641), -- 单手
        Slot(INVTYPE_SHIELD, 134955), -- 副手盾
        Slot(INVTYPE_WEAPONOFFHAND, 134955), -- 副手
        Slot(INVTYPE_HOLDABLE, 134333), -- 副手物品
        Slot(INVTYPE_RANGED, 135498), -- 远程
        Weapon(LE_ITEM_WEAPON_GUNS, 135610), -- 枪
        Weapon(LE_ITEM_WEAPON_CROSSBOW, 135533), -- 弩
        Weapon(LE_ITEM_WEAPON_THROWN, 135427), -- 投掷武器
        Weapon(LE_ITEM_WEAPON_WAND, 135473), -- 魔杖
        Slot(INVTYPE_RELIC, 134915), -- 圣物
        Slot(INVTYPE_HEAD, 133136), -- 头部
        Slot(INVTYPE_NECK, 133294), -- 颈部
        Slot(INVTYPE_SHOULDER, 135033), -- 肩部
        Slot(INVTYPE_CLOAK, 133768), -- 背部
        Slot(INVTYPE_CHEST, 132644), -- 胸部
        Slot(INVTYPE_ROBE, 132644), -- 胸部
        Slot(INVTYPE_WRIST, 132608), -- 手腕
        Slot(INVTYPE_HAND, 132948), -- 手
        Slot(INVTYPE_WAIST, 132511), -- 腰部
        Slot(INVTYPE_LEGS, 134588), -- 腿部
        Slot(INVTYPE_FEET, 132541), -- 脚
        Slot(INVTYPE_FINGER, 133345), -- 手指
        Slot(INVTYPE_TRINKET, 134010), -- 饰品
        Slot(INVTYPE_BODY, 135022), -- 衬衣
        Slot(INVTYPE_TABARD, 135026), -- 战袍
    }), -- 装备
    Type(LE_ITEM_CLASS_CONTAINER, 133652), -- 容器
    Type(LE_ITEM_CLASS_QUIVER, 134407), -- 箭袋
    Type(LE_ITEM_CLASS_PROJECTILE, 132382), -- 弹药
    Type(LE_ITEM_CLASS_RECIPE, 134939), -- 配方
    Rule(CONSUMABLE, 134829, 'type:' .. CONSUMABLE .. ' & tip:!' .. QUEST, {
        -- @classic@
        TipLocale('CLASS', 132273), -- 职业
        Spell(746, 133685), -- 急救
        Spell(433, 133945), -- 进食
        Spell(430, 132794), -- 喝水
        Spell(439, 134830), -- 治疗药水
        Spell(438, 134851), -- 法力药水
        -- @end-classic@
        -- @bcc@
        Consumable(7, 133692), -- 绷带
        Consumable(3, 134742), -- 合剂
        Consumable(2, 134773), -- 药剂
        Consumable(1, 134729, {
            Spell(439, 134830), -- 治疗药水
            Spell(438, 134851), -- 法力药水
        }), -- 药水
        Consumable(4, 134937), -- 卷轴
        Consumable(5, 133953, {
            Spell(44166, 134051), -- 恢复体能
            Spell(433, 133945), -- 进食
            Spell(430, 132794), -- 喝水
        }), -- 食物和饮料
        Consumable(6, 133604), -- 物品强化
        Group(GetSpellInfo(7620), 136245, {34861, 6533, 6532, 6530, 6529}),
        -- @end-bcc@
    }), -- 消耗品
    Type(LE_ITEM_CLASS_TRADEGOODS, 132905, {
        TipLocale('CLASS', 132273), -- 职业
        -- @classic@
        Tag('Cloth', 132903), -- 布
        Tag('Leather', 134256), -- 皮
        Tag('Metal & Stone', 133217), -- 金属和矿石
        Tag('Cooking', 134027), -- 烹饪
        Tag('Herb', 134215), -- 草药
        Tag('Elemental', 135819), -- 元素
        Tag('Enchanting', 132864), -- 附魔
        -- @end-classic@
        -- @bcc@
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
        -- @end-bcc@
    }), -- 商品
    Type(LE_ITEM_CLASS_GEM, 133272, {
        SubType(LE_ITEM_CLASS_GEM, 0, 134083), -- 红
        SubType(LE_ITEM_CLASS_GEM, 2, 134114), -- 黄
        SubType(LE_ITEM_CLASS_GEM, 1, 134080), -- 蓝
        SubType(LE_ITEM_CLASS_GEM, 5, 134111), -- 橙
        SubType(LE_ITEM_CLASS_GEM, 4, 134093), -- 绿
        SubType(LE_ITEM_CLASS_GEM, 3, 134103), -- 紫
        SubType(LE_ITEM_CLASS_GEM, 8, 132886), -- 棱彩
        SubType(LE_ITEM_CLASS_GEM, 6, 134098), -- 多彩
        SubType(LE_ITEM_CLASS_GEM, 7, 134087), -- 简易
    }), -- 珠宝
    Type(LE_ITEM_CLASS_REAGENT, 133587), -- 材料
    Rule(MISC, 134237, 'type:!' .. QUEST .. ' & tip:!' .. QUEST, {
        Type(LE_ITEM_CLASS_MISCELLANEOUS, 134400), -- 其它
        Type(LE_ITEM_CLASS_KEY, 134237), -- 钥匙
    }), --
    Rule(QUEST, 133469, 'type:' .. QUEST .. ' | tip:' .. QUEST, {
        Tip(ITEM_STARTS_QUEST, 132836), -- 接任务
        Rule(nil, 133942, 'spell'), --
    }), -- 任务
}

ns.DEFAULT_SAVING_RULES = { --
    16885, -- 重垃圾箱
    Rule(TRADEGOODS, 132905, 'type:' .. TRADEGOODS .. ' & !spell & !bop'),
}
