-- ScrollFrame.lua
-- @Author : DengSir (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/20/2018, 7:46:03 PM

local ns = select(2, ...)

local ScrollFrame = ns.Addon:NewClass('ScrollFrame', 'ScrollFrame')
ns.ScrollFrame = ScrollFrame

function ScrollFrame:Constructor()
    self.unused = {}
    self.buttons = setmetatable({}, {
        __index = function(t, i)
            assert(type(i) == 'number')
            local button = self:GetButton(i)
            t[i] = button
            return button
        end,
    })
    self:SetScript('OnSizeChanged', self.OnSizeChanged)
    self:OnSizeChanged(self:GetSize())
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
end

function ScrollFrame:GetButton(index)
    local button = tremove(self.unused)
    if button then
        button:SetParent(self:GetScrollChild())
        button:ClearAllPoints()
    else
        button = CreateFrame('Button', nil, self:GetScrollChild(), self.itemTemplate)
        self:Fire('OnItemCreated', button)
    end

    local y = (index - 1)
    if y > 0 then
        y = -y * (self.buttonHeight or self:GetButton(1):GetHeight())
    end

    button.scrollFrame = self
    button:SetPoint('TOPLEFT', 0, y)
    button:SetPoint('TOPRIGHT', 0, y)
    return button
end

function ScrollFrame:ReleaseButton(button)
    self.buttons[tIndexOf(self.buttons, button)] = nil
end

function ScrollFrame:RestoreButton(button)
    tinsert(self.unused, button)
end

ScrollFrame.GetOffset = HybridScrollFrame_GetOffset
