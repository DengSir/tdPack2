-- Rules.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/26/2026, 10:51:19 AM
--
---@class ns
local ns = select(2, ...)

local C = ns.C
local L = ns.L

local type = type
local tinsert = table.insert
local ipairs = ipairs

local Enum = Enum

local _G = _G
local _ENV = setmetatable({}, {__index = _G})

function ns.RuleMaker()
    setfenv(2, _ENV)
end

setfenv(1, _ENV)

function Rule(name, icon, rule, c)
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

function Group(name, icon, children)
    return Rule(name, icon, nil, children)
end

function Type(type, icon, children)
    local name = C.Item.GetItemClassInfo(type)
    return Rule(name, icon, 'type:' .. name, children)
end

function SubType(type, subType, icon, children)
    local name = C.Item.GetItemSubClassInfo(type, subType)
    return Rule(name, icon, 'type:' .. name, children)
end

function Weapon(subType, icon, children)
    return SubType(Enum.ItemClass.Weapon, subType, icon, children)
end

function Misc(subType, icon, children)
    return SubType(Enum.ItemClass.Miscellaneous, subType, icon, children)
end

function Trade(subType, icon, children)
    return SubType(Enum.ItemClass.Tradegoods, subType, icon, children)
end

function Consumable(subType, icon, children)
    return SubType(Enum.ItemClass.Consumable, subType, icon, children)
end

function Gem(subType, icon, children)
    return SubType(Enum.ItemClass.Gem, subType, icon, children)
end

function Slot(name, icon, children)
    name = _G[name] or name
    return Rule(name, icon, 'inv:' .. name, children)
end

function TipLocale(key, icon, children)
    return Rule(L['COMMENT_' .. key], icon, 'tip:' .. L['KEYWORD_' .. key], children)
end

function Tip(tip, icon, children)
    return Rule(tip, icon, 'tip:' .. tip, children)
end

function Spell(id, icon, children)
    local spellName = _G.GetSpellInfo(id)
    return Rule(spellName, icon, 'spell:' .. spellName, children)
end

function SpellId(id, icon, name, ...)
    local children
    if type(name) == 'table' then
        name, children = nil, name
    else
        children = ...
    end

    local spellName = _G.GetSpellInfo(id)
    return Rule(spellName .. ' - ' .. (name or id), icon, 'spell:' .. id, children)
end

function Tag(key, icon, children)
    local data = ns.ITEM_TAGS[key]
    assert(data, 'Invalid tag: ' .. key)
    local name = data.name:gsub('%s+', '')
    return Rule(data.name, icon, 'tag:' .. name, children)
end
