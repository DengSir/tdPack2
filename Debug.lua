-- Debug.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/26/2019, 11:06:50 AM

if true then
    return
end

local GUI = LibStub('tdGUI-1.0')

local Frame = GUI:GetClass('BasicPanel'):New(UIParent)
Frame:SetSize(300, 300)
Frame:SetPoint('CENTER')

local List = GUI:GetClass('ListView'):New(Frame)
List:SetPoint('TOPLEFT', 20, -40)
List:SetPoint('BOTTOMRIGHT', -20, 20)

local items = {}
for i = 1, 100000 do
    if GetItemIcon(i) ~= 134400 then
        tinsert(items, i)
    end
end

List:SetItemList(items)
List:SetCallback('OnItemCreated', function(_, button)
    button:SetNormalFontObject('GameFontNormalLeft')
end)
List:SetCallback('OnItemFormatting', function(_, button, id)
    local name, link, quality = GetItemInfo(id)
    local icon = GetItemIcon(id)
    button:SetText(format('|T%s:16|t %s', icon, link or 'Loading'))
end)
List:SetCallback('OnItemEnter', function(_, button, id)
    GameTooltip:SetOwner(button, 'ANCHOR_RIGHT')
    GameTooltip:SetHyperlink('item:' .. id)
    GameTooltip:Show()
end)
List:Refresh()

C_Timer.After(3, function()
    print('Start')
    TDDB_PACK2.ITEMS = {}

    local function Save(id)
        TDDB_PACK2.ITEMS[tostring(id)] = {
            info = {GetItemInfo(id)},
            spell = {GetItemSpell(id)},
            equip = IsEquippableItem(id),
            family = GetItemFamily(id),
        }
    end

    local f = CreateFrame('Frame')
    f:SetScript('OnEvent', function(_, _, id, ok)
        if ok then
            Save(id)
        else
            print('no', id)
        end
    end)
    f:RegisterEvent('GET_ITEM_INFO_RECEIVED')

    local ITEMS = CopyTable(items)
    local timer
    local getter = function()
        for i = 1, 100 do
            local id = tremove(ITEMS)
            if id then
                local name = GetItemInfo(id)
                if name then
                    Save(id)
                end
            else
                print('Done')
                timer:Cancel()
                return
            end
        end
    end

    timer = C_Timer.NewTicker(0.1, getter)
end)
