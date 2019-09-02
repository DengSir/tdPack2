-- Bagnon.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 7:37:46 PM

if not Bagnon then
    return
end

local ns = select(2, ...)
local orig_ListMenuButtons = Bagnon.Frame.ListMenuButtons
local buttons = {}

local function CreateButton(frame)
    if not buttons[frame] then
        local button = CreateFrame('Button', nil, frame, 'BagnonMenuButtonTemplate')
        button.Icon:SetTexture(ns.ICON)
        ns.SetupButton(button)
        buttons[frame] = button
    end
    return buttons[frame]
end

function Bagnon.Frame:ListMenuButtons()
    orig_ListMenuButtons(self)
    local frameId = self:GetFrameID()
    if frameId == 'inventory' or frameId == 'bank' then
        tinsert(self.menuButtons, CreateButton(self))
    end
end
