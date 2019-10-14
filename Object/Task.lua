-- Task.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/14/2019, 2:16:54 PM

---@type ns
local ns = select(2, ...)

---@class Task
local Task = ns.Addon:NewClass('Task')

function Task:Constructor()
    self.running = false
end

function Task._Meta:__call()
    if not self.running then
        if ns.Pack:IsLocked() then
            return false
        end

        self:Prepare()
        self.running = true
    end

    if self:Process() then
        self:Finish()
        self.running = nil
        return true
    end

    return false
end

function Task:Prepare()
    error('Not implementation')
end

function Task:Process()
    error('Not implementation')
end

function Task:Finish()
    error('Not implementation')
end
