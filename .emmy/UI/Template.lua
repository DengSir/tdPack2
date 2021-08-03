---@class tdPack2RuleItemTemplate : Button
---@field Status Texture
---@field Text FontString
---@field Rule FontString
---@field NormalTexture Texture
---@field HighlightTexture Texture
local tdPack2RuleItemTemplate = {}

---@class __tdPack2ScrollFrameTemplate_scrollBar : HybridScrollBarTemplate , Slider

---@class tdPack2ScrollFrameTemplate : HybridScrollFrameTemplate , ScrollFrame
---@field scrollBar __tdPack2ScrollFrameTemplate_scrollBar
local tdPack2ScrollFrameTemplate = {}

---@class tdPack2TabButtonTemplate : Button
---@field LeftDisabled Texture
---@field MiddleDisabled Texture
---@field RightDisabled Texture
---@field Left Texture
---@field Middle Texture
---@field Right Texture
---@field HighlightTexture Texture
---@field Text FontString
local tdPack2TabButtonTemplate = {}

---@class __tdPack2RuleOptionTemplate_Resize : PanelResizeButtonTemplate , Button

---@class tdPack2RuleOptionTemplate : ButtonFrameTemplate , Frame
---@field Resize __tdPack2RuleOptionTemplate_Resize
local tdPack2RuleOptionTemplate = {}

---@class __tdPack2RuleEditorTemplate_RuleInput : InputBoxTemplate , EditBox

---@class tdPack2WhereDropdown : UIDropDownMenuTemplate , Frame

---@class __tdPack2RuleEditorTemplate_CommentInput : InputBoxTemplate , EditBox

---@class __tdPack2RuleEditorTemplate_ExecButton : UIPanelButtonTemplate , Button

---@class __tdPack2RuleEditorTemplate_CancelButton : UIPanelButtonTemplate , Button

---@class tdPack2RuleEditorTemplate : BackdropTemplate , Frame
---@field Header Texture
---@field Title FontString
---@field LabelRule FontString
---@field LabelWhere FontString
---@field LabelComment FontString
---@field LabelIcons FontString
---@field RuleInput __tdPack2RuleEditorTemplate_RuleInput
---@field WhereDropDown tdPack2WhereDropdown
---@field CommentInput __tdPack2RuleEditorTemplate_CommentInput
---@field IconsFrame Frame
---@field ExecButton __tdPack2RuleEditorTemplate_ExecButton
---@field CancelButton __tdPack2RuleEditorTemplate_CancelButton
local tdPack2RuleEditorTemplate = {}
