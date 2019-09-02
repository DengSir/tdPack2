-- Blizzard.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 9:12:59 PM

local ns = select(2, ...)

local function condition(button)
    return button:GetParent():GetID() == 0
end

local i = 1
while true do
    local button = _G['ContainerFrame' .. i .. 'PortraitButton']
    if not button then
        break
    end
    ns.SetupButton(button, condition)
    i = i + 1
end
