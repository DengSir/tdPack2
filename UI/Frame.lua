-- Frame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/24/2019, 6:22:14 PM

local ns = select(2, ...)

local Frame = ns.Addon:NewClass('Frame', 'Frame')
LibStub('AceEvent-3.0'):Embed(Frame)
ns.Frame = Frame
