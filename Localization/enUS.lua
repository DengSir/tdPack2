-- @debug@
local L = LibStub('AceLocale-3.0'):NewLocale(..., 'enUS', true)
-- @end-debug@
--[[@non-debug@
local L = LibStub('AceLocale-3.0'):NewLocale(..., 'enUS', true, true)
--@end-non-debug@]]
if not L then
    return
end

-- @locale:language=enUS@
L = L or {}
L["Add advance rule"] = true
L["Add rule"] = true
L["Advancee rules use ItemSearchModify-1.3"] = true
L["Already exists"] = true
L["Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"] = true
L["Are you sure |cffff191919DELETE|r rule?"] = true
L["Are you sure to |cffff1919RESET|r rules?"] = true
L["Are you sure you want to restore the current Settings?"] = true
L["Bag"] = true
L["Bank"] = true
L["Bank and bag stacking together"] = true
L["Buttons"] = true
L["Character Specific Settings"] = true
L["COMMENT_CLASS"] = "Class items"
L["Drag to modify the sorting order"] = true
L["Edit rule"] = true
L["Enable chat message"] = true
L["Enjoy!"] = true
L["Help"] = true
L["ITEM_TAG: Cloth"] = "Cloth"
L["ITEM_TAG: Cooking"] = "Cooking"
L["ITEM_TAG: Elemental"] = "Elemental"
L["ITEM_TAG: Enchanting"] = "Enchanting"
L["ITEM_TAG: Herb"] = "Herb"
L["ITEM_TAG: Jewelry"] = "Jewelry"
L["ITEM_TAG: Leather"] = "Leather"
L["ITEM_TAG: Metal & Stone"] = "Metal & Stone"
L["ITEM_TAG: Mount"] = "Mount"
L["ITEM_TAG: Pet"] = "Pet"
L["Keep bank items stack full"] = true
L["KEYWORD_CLASS"] = "Classes"
L["Leave bank, pack cancel."] = true
L["Left Click"] = true
L["Name (Optional)"] = true
L["None"] = true
L["OPEN_OPTIONS"] = "Open options"
L["OPEN_RULE_OPTIONS"] = "Open rule options"
L["Pack canceled."] = true
L["Pack finish."] = true
L["Player enter combat, pack cancel."] = true
L["Player in combat"] = true
L["Player is dead"] = true
L["Please drop the item, money or skills."] = true
L["Profile"] = true
L["Put in an item to add simple rule"] = true
L["Put where?"] = true
L["Reset rule"] = true
L["Restore default Settings"] = true
L["Reverse pack"] = true
L["Right Click"] = true
L["Root"] = true
L["Rule"] = true
L["Rules"] = true
L["Rules restore to default."] = true
L["SAVE"] = "Save to bank"
L["Save to bank when default packing"] = true
L["SAVING_DESC"] = "Save items to bank."
L["SAVING_NAME"] = "Saving"
L["Select an icon (Optional)"] = true
L["Some slot is locked"] = true
L["SORT"] = "Default pack"
L["SORT_ASC"] = "Sort asc"
L["SORT_BAG"] = "Sort bag"
L["SORT_BAG_ASC"] = "Sort bag asc"
L["SORT_BAG_DESC"] = "Sort bag desc"
L["SORT_BANK"] = "Sort bank"
L["SORT_BANK_ASC"] = "Sort bank asc"
L["SORT_BANK_DESC"] = "Sort bank desc"
L["SORT_DESC"] = "Sort desc"
L["SORTING_DESC"] = "Sort bags and bank."
L["SORTING_NAME"] = "Sorting"
L["Tools"] = true
L["Transporter"] = true
L["UPDATE_RULES_CONFIRM"] = [=[The current version of tdPack2 updates a large number of rules. Do you want to reset the rules to the default settings?
Help to choose:
1. I know what this prompt is saying: choose for yourself
2. I don’t know how to choose: Accept
]=]
L["Usuable"] = true
-- @end-locale@

-- @debug@
-- @import:language=enUS@
L['Leave bank, pack cancel.'] = true
L['Player enter combat, pack cancel.'] = true
L['Player is dead'] = true
L['Player in combat'] = true
L['Please drop the item, money or skills.'] = true
L['Some slot is locked'] = true
L['Pack finish.'] = true
L['Pack canceled.'] = true
L['Reverse pack'] = true
L['Enable chat message'] = true
L['Character Specific Settings'] = true
L['Restore default Settings'] = true
L['Are you sure you want to restore the current Settings?'] = true
L['Left Click'] = true
L['Right Click'] = true
L['Rules'] = true
L['Buttons'] = true
L['Bag'] = true
L['Bank'] = true
L['Reset rule'] = true
L['Are you sure to |cffff1919RESET|r rules?'] = true
L['Profile'] = true
L['SORTING_NAME'] = 'Sorting'
L['SORTING_DESC'] = 'Sort bags and bank.'
L['SAVING_NAME'] = 'Saving'
L['SAVING_DESC'] = 'Save items to bank.'
L['Already exists'] = true
L['Add advance rule'] = true
L['Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?'] = true
L['Are you sure |cffff191919DELETE|r rule?'] = true
L['Root'] = true
L['Rule'] = true
L['Put where?'] = true
L['Name (Optional)'] = true
L['Select an icon (Optional)'] = true
L['Save to bank when default packing'] = true
L['Keep bank items stack full'] = true
L['Bank and bag stacking together'] = true
L['Help'] = true
L['Drag to modify the sorting order'] = true
L['Put in an item to add simple rule'] = true
L['Enjoy!'] = true
L['Rules restore to default.'] = true
L['Add rule'] = true
L['Edit rule'] = true
L.UPDATE_RULES_CONFIRM =
    [[The current version of tdPack2 updates a large number of rules. Do you want to reset the rules to the default settings?
Help to choose:
1. I know what this prompt is saying: choose for yourself
2. I don’t know how to choose: Accept
]]
-- for actions
L.None = true
L.SORT = 'Default pack'
L.SORT_BAG = 'Sort bag'
L.SORT_BAG_ASC = 'Sort bag asc'
L.SORT_BAG_DESC = 'Sort bag desc'
L.SORT_BANK = 'Sort bank'
L.SORT_BANK_ASC = 'Sort bank asc'
L.SORT_BANK_DESC = 'Sort bank desc'
L.SORT_ASC = 'Sort asc'
L.SORT_DESC = 'Sort desc'
L.OPEN_RULE_OPTIONS = 'Open rule options'
L.OPEN_OPTIONS = 'Open options'
L.SAVE = 'Save to bank'
-- rules comment
L.COMMENT_CLASS = 'Class items'
-- for rules
L.KEYWORD_CLASS = 'Classes'
L.Tools = true
L.Transporter = true
L.Usuable = true
L['ITEM_TAG: Cloth'] = 'Cloth'
L['ITEM_TAG: Leather'] = 'Leather'
L['ITEM_TAG: Metal & Stone'] = 'Metal & Stone'
L['ITEM_TAG: Cooking'] = 'Cooking'
L['ITEM_TAG: Herb'] = 'Herb'
L['ITEM_TAG: Elemental'] = 'Elemental'
L['ITEM_TAG: Enchanting'] = 'Enchanting'
L['ITEM_TAG: Jewelry'] = 'Jewelry'
L['ITEM_TAG: Mount'] = 'Mount'
L['ITEM_TAG: Pet'] = 'Pet'

L['Advancee rules use ItemSearchModify-1.3'] = true
-- @locale-fill@

-- @end-import@
-- @end-debug@
