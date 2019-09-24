-- ScrollFrame.lua
-- @Author : DengSir (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/20/2018, 7:46:03 PM

local setmetatable, assert, type = setmetatable, assert, type
local tinsert, tremove, tIndexOf = table.insert, table.remove, tIndexOf

local CreateFrame = CreateFrame

local ns = select(2, ...)

local ScrollFrame = ns.Addon:NewClass('ScrollFrame', 'ScrollFrame')
ns.ScrollFrame = ScrollFrame

ScrollFrame.GetOffset = HybridScrollFrame_GetOffset
ScrollFrame.SetOffset = HybridScrollFrame_SetOffset

function ScrollFrame:Constructor()
    self.paddingTop = 3
    self.paddingBottom = 13
    self.itemSpacing = 3
    self.buttonHeight = 10
    self.unused = {}
    self.buttons = setmetatable({}, {
        __index = function(t, i)
            assert(type(i) == 'number')
            return self:GetButton(i)
        end,
    })
    self.scrollBar:SetMinMaxValues(0, 1)
    self.scrollBar:SetValue(0)
    self:SetScript('OnSizeChanged', self.OnSizeChanged)
end

function ScrollFrame:OnUpdate()
    self:SetScript('OnUpdate', nil)
    self:update()
end

function ScrollFrame:OnSizeChanged(width, height)
    self:GetScrollChild():SetSize(width, height)
    self:Refresh()
end

function ScrollFrame:Refresh()
    return self:SetScript('OnUpdate', self.OnUpdate)
end

function ScrollFrame:SetItemTemplate(itemTemplate)
    self.itemTemplate = itemTemplate
    self.itemHeight = self.buttons[1]:GetHeight()
    self.buttonHeight = self.itemHeight + self.itemSpacing
end

function ScrollFrame:GetButton(index)
    local button = self:AllocButton()

    local y = (index - 1)
    if y > 0 then
        y = -y * self.buttonHeight
    end
    y = y - self.paddingTop

    print(index, y, self.buttons, self.itemSpacing)

    button:SetPoint('TOPLEFT', 0, y)
    button:SetPoint('TOPRIGHT', 0, y)
    self.buttons[index] = button
    return button
end

function ScrollFrame:AllocButton()
    local button = tremove(self.unused)
    if button then
        button:SetParent(self:GetScrollChild())
        button:ClearAllPoints()
    else
        button = CreateFrame('Button', nil, self:GetScrollChild(), self.itemTemplate)
        self:Fire('OnItemCreated', button)
    end

    button:SetWidth(self:GetWidth())
    button.scrollFrame = self
    return button
end
