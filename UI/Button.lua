-- Button.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 7:35:50 PM

local ns = select(2, ...)
local L = ns.L

local function OnClick(self, click)
    if click == 'LeftButton' then
        ns.Addon:Pack()
    elseif click == 'RightButton' then
        ns.Addon:OpenOption()
    end
end

local function OnEnter(self)
    if not GameTooltip:GetOwner() or not GameTooltip:IsVisible() then
        GameTooltip:SetOwner(self, 'BOTTOM_RIGHT')
    end
    GameTooltip:AddLine('tdPack2')
    GameTooltip:AddLine(L['<Left Click> '] .. L['Pack bags'], 1, 1, 1)
    GameTooltip:AddLine(L['<Right Click> '] .. L['Open options'], 1, 1, 1)
    GameTooltip:Show()
end

function ns.SetupButton(button, condition)
    button:RegisterForClicks('LeftButtonUp', 'RightButtonUp')

    if type(condition) == 'function' then
        button:HookScript('OnClick', function(self, click)
            if condition(self) then
                OnClick(self, click)
            end
        end)
        button:HookScript('OnEnter', function(self)
            if condition(self) then
                OnEnter(self)
            end
        end)
    else
        button:HookScript('OnClick', OnClick)
        button:HookScript('OnEnter', OnEnter)
    end
    button:HookScript('OnLeave', GameTooltip_Hide)
end
