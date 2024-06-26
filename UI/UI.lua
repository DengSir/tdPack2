-- UI.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/29/2019, 12:49:28 AM
--
---@class ns
local ns = select(2, ...)

---@class UI: AceModule, AceAddon, LibClass-2.0
---@field TreeView UI.TreeView
---@field TreeStatus UI.TreeStatus
---@field RuleEditor UI.RuleEditor
---@field RuleView UI.RuleView
---@field ScrollFrame UI.ScrollFrame
local UI = ns.Addon:NewModule('UI', 'LibClass-2.0')

function UI:OnModuleCreated(module)
    self[module:GetName()] = module

    module.AfterSetup = setmetatable({}, {
        __newindex = function(_, k, v)
            module[k] = function(...)
                if module.OnSetup then
                    return
                end
                module[k] = v
                return v(module, ...)
            end
        end,
    })
end

function UI:OnClassCreated(class, name)
    self[name] = class
end

local function OnShow(shower)
    shower.module:Enable()
end

local function OnHide(shower)
    shower.module:Disable()
end

local function CreateShower(module)
    if not module.Frame then
        return
    end
    module.Frame:Hide()

    local shower = CreateFrame('Frame', nil, module.Frame)
    shower:SetScript('OnShow', OnShow)
    shower:SetScript('OnHide', OnHide)
    shower.module = module
end

---@class UI.Prototype
---@field Frame Frame
local Prototype = {}

function Prototype:Show()
    self:Setup()

    if self.Frame then
        ShowUIPanel(self.Frame)
    end
end

function Prototype:Setup()
    if self.OnSetup then
        self:OnSetup()
        self.OnSetup = nil
        self.AfterSetup = nil
        CreateShower(self)
    end
end

function Prototype:Hide()
    if self.Frame then
        HideUIPanel(self.Frame)
    end
end

function Prototype:SetShown(flag)
    if flag then
        self:Show()
    else
        self:Hide()
    end
end

function Prototype:IsShown()
    return self.Frame and self.Frame:IsShown()
end

UI:SetDefaultModulePrototype(Prototype)
UI:SetDefaultModuleState(false)
