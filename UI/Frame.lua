-- Frame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/24/2019, 6:22:14 PM

local ns = select(2, ...)

local Frame = ns.Addon:NewClass('Frame', 'Frame')
LibStub('AceEvent-3.0'):Embed(Frame)
ns.Frame = Frame

local function OnShow(self)
    if self.SetupEvents then
        self:SetupEvents()
    end
end

local function OnHide(self)
    self:UnregisterAllEvents()
    self:UnregisterAllMessages()
end

function Frame:Constructor()
    self:HookScript('OnShow', OnShow)
    self:HookScript('OnHide', OnHide)
end
