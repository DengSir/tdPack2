-- TreeView.lua
-- @Author : DengSir (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/20/2018, 4:28:53 PM

local ns = select(2, ...)

local setmetatable, ipairs, type, select = setmetatable, ipairs, type, select
local tinsert, tremove = table.insert, table.remove
local ceil, min, abs = math.ceil, math.min, math.abs
local coroutine = coroutine

local CreateFrame, HybridScrollFrame_Update = CreateFrame, HybridScrollFrame_Update

local UIParent = UIParent

local WHERE_AFTER = 1
local WHERE_BEFORE = 2
local WHERE_IN = 3

local TreeStatus = ns.Addon:NewClass('TreeStatus')

function TreeStatus:Constructor()
    self.fold = setmetatable({}, {__mode = 'k'})
end

function TreeStatus:Iterate(start)
    local index = 0

    local function Iterate(tree, depth)
        for i, item in ipairs(tree) do
            index = index + 1
            if not start or index >= start then
                coroutine.yield(depth, item, i, tree)
            end
            if type(item) == 'table' and type(item.children) == 'table' and not self.fold[item] then
                Iterate(item.children, depth + 1)
            end
        end
    end

    return coroutine.wrap(function()
        return Iterate(self.itemTree, 1)
    end)
end

function TreeStatus:GetCount()
    local function GetCount(tree, depth)
        local count = 0
        for i, item in ipairs(tree) do
            count = count + 1
            if type(item) == 'table' and type(item.children) == 'table' and not self.fold[item] then
                count = count + GetCount(item.children, depth + 1)
            end
        end
        return count
    end
    return GetCount(self.itemTree, 1)
end

local TreeView = ns.Addon:NewClass('TreeView', ns.ScrollFrame)
ns.TreeView = TreeView

LibStub('AceTimer-3.0'):Embed(TreeView)

function TreeView:Constructor()
    self.treeStatus = TreeStatus:New()
    self:SetCallback('OnItemCreated', self.OnItemCreated)
    self:SetCallback('OnItemDragStart', self.OnItemDragStart)
    self:SetCallback('OnItemDragStop', self.OnItemDragStop)
end

local ITEM_SCRIPTS = setmetatable({}, {
    __index = function(t, script)
        local name = script:gsub('^On', 'OnItem')
        t[script] = function(button, ...)
            button.treeView:Fire(name, button, ...)
        end
        return t[script]
    end,
})

function TreeView:BindScript(button, ...)
    for i = 1, select('#', ...) do
        local script = select(i, ...)
        button:SetScript(script, ITEM_SCRIPTS[script])
    end
end

function TreeView:OnItemCreated(button)
    button.treeView = self
    self:BindScript(button, 'OnDragStart', 'OnDragStop', 'OnEnter', 'OnLeave')
end

function TreeView:OnItemDragStart(button)
    self.pickingButton = button
    self:ReleaseButton(button)
    tremove(button.parent, button.index)

    button:SetParent(UIParent)
    button:SetFrameStrata('DIALOG')
    button:StartMoving()
    button:LockHighlight()

    self:Refresh()
    self:ScheduleRepeatingTimer('OnTimer', 0.1)
    self:ScheduleRepeatingTimer('UpdateInsert', 0.03)
    self:UpdateInsert()
end

function TreeView:OnItemDragStop(button)
    button:StopMovingOrSizing()
    button:UnlockHighlight()
    button:Hide()
    button:SetFrameStrata('MEDIUM')

    if self.putTarget then
        if self.putWhere == WHERE_BEFORE then
            tinsert(self.putTarget.parent, self.putTarget.index, button.item)
        elseif self.putWhere == WHERE_AFTER then
            tinsert(self.putTarget.parent, self.putTarget.index + 1, button.item)
        else
            local parent = self.putTarget.item
            parent.children = parent.children or {}
            tinsert(parent.children, button.item)
        end
        self.putWhere = nil
        self.putTarget = nil
        self:Fire('OnOrdered')
    else
        print(button.index)
        tinsert(button.parent, button.index, button.item)
    end

    if self.inserter then
        self.inserter:Hide()
    end
    self.pickingButton = nil
    self:CancelAllTimers()
    self:RestoreButton(button)
    self:Refresh()
end

function TreeView:OnTimer()
    if self.pickingButton:GetTop() > self:GetTop() then
        self.scrollBar:SetValue(self.scrollBar:GetValue() - self.buttonHeight)
    elseif self.pickingButton:GetBottom() < self:GetBottom() then
        self.scrollBar:SetValue(self.scrollBar:GetValue() + self.buttonHeight)
    end
end

function TreeView:UpdateInsert()
    if not self.inserter then
        local inserter = CreateFrame('Frame', nil, self:GetScrollChild())
        inserter:SetSize(self:GetWidth(), 2)

        local bg = inserter:CreateTexture(nil, 'ARTWORK')
        bg:SetAllPoints(true)
        bg:SetColorTexture(0, 1, 1, 0.4)

        self.inserter = inserter
    end

    local where, target, last
    if abs(self:GetLeft() - self.pickingButton:GetLeft()) < self:GetWidth() then
        local top = self.pickingButton:GetTop()

        for _, button in ipairs(self.buttons) do
            if button:IsVisible() then
                local delta = button:GetTop() - top
                local canPutIn = self:Fire('OnCheckItemCanPutIn', self.pickingButton.item, button.item)
                local canPutInParent = self:Fire('OnCheckItemCanPutIn', self.pickingButton.item, button.parent)

                if abs(delta) < self.buttonHeight / 4 and canPutIn then
                    target = button
                    where = WHERE_IN
                elseif delta < 0 and abs(delta) < self.buttonHeight and canPutInParent then
                    target = button
                    where = WHERE_BEFORE
                elseif delta > 0 and delta < self.buttonHeight * 2 / 3 and not self:IsItemExpend(button.item) and
                    canPutInParent then
                    target = button
                    where = WHERE_AFTER
                end

                if target then
                    break
                end
                last = button
            end
        end
    end

    -- if not target and last then
    --     if last:GetBottom() - top < self.buttonHeight then
    --         where = WHERE_AFTER
    --         target = {parent = self.treeStatus.itemTree, index = #self.treeStatus.itemTree}
    --     end
    -- end

    if target then
        self.putTarget = target
        self.putWhere = where

        self.inserter:ClearAllPoints()
        self.inserter:SetWidth(self:GetWidth() - 5 - (target.depth - 1) * 20)
        self.inserter:Show()

        if where == WHERE_AFTER then
            self.inserter:SetPoint('TOPRIGHT', target, 'BOTTOMRIGHT')
            self.inserter:SetHeight(3)
        elseif where == WHERE_BEFORE then
            self.inserter:SetPoint('BOTTOMRIGHT', target, 'TOPRIGHT')
            self.inserter:SetHeight(3)
        else
            self.inserter:SetPoint('TOPRIGHT', target, 'TOPRIGHT')
            self.inserter:SetPoint('BOTTOMRIGHT', target, 'BOTTOMRIGHT')
        end
    else
        self.putTarget = nil
        self.putWhere = nil
        self.inserter:Hide()
    end
end

function TreeView:update()
    local offset = self:GetOffset()
    local buttons = self.buttons
    local treeStatus = self.treeStatus
    local containerHeight = self:GetHeight()
    local buttonHeight = self.buttonHeight or buttons[1]:GetHeight()
    local itemCount = treeStatus:GetCount()
    local maxCount = ceil(containerHeight / buttonHeight) + 1
    local buttonCount = min(maxCount, itemCount)

    self.buttonHeight = buttonHeight

    local iter = treeStatus:Iterate(offset + 1)

    for i = 1, buttonCount do
        local index = i + offset
        local button = buttons[i]
        if index > itemCount then
            button:Hide()
        else
            local depth, item, index, parent = iter()

            button.index = index
            button.parent = parent
            button.depth = depth
            button.item = item
            button.scrollFrame = self
            button:SetID(index)
            button:Show()
            self:Fire('OnItemFormatting', button, item, depth)
        end
    end

    for i = buttonCount + 1, #buttons do
        buttons[i]:Hide()
    end
    HybridScrollFrame_Update(self, itemCount * (buttonHeight + self.itemSpacing) - self.itemSpacing + self.paddingTop +
                                 self.paddingBottom, containerHeight)
end

function TreeView:SetItemTree(itemTree)
    self.treeStatus.itemTree = itemTree
    self:Refresh()
end

function TreeView:ToggleItem(item)
    self.treeStatus.fold[item] = not self.treeStatus.fold[item] or nil
    self:Refresh()
end

function TreeView:IsItemExpend(item)
    return not self.treeStatus.fold[item] and type(item) == 'table' and type(item.children) == 'table' and
               #item.children > 0
end
