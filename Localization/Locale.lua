-- Locale.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/17/2024, 3:32:09 PM
--
local A = ...
local function T(l, f)
    local o = LibStub('AceLocale-3.0'):NewLocale(A, l)
    if o then f(o) end
end

T('deDE', function(L)
-- @locale:language=deDE@
L = L or {}
--[[Translation missing --]]
--[[ L["Add advance rule"] = "Add advance rule"--]] 
--[[Translation missing --]]
--[[ L["Add rule"] = "Add rule"--]] 
--[[Translation missing --]]
--[[ L["Advancee rules use ItemSearchModify-1.3"] = "Advancee rules use ItemSearchModify-1.3"--]] 
--[[Translation missing --]]
--[[ L["Already exists"] = "Already exists"--]] 
--[[Translation missing --]]
--[[ L["Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"] = "Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure |cffff191919DELETE|r rule?"] = "Are you sure |cffff191919DELETE|r rule?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure to |cffff1919RESET|r rules?"] = "Are you sure to |cffff1919RESET|r rules?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure you want to restore the current Settings?"] = "Are you sure you want to restore the current Settings?"--]] 
--[[Translation missing --]]
--[[ L["Bag"] = "Bag"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
--[[Translation missing --]]
--[[ L["Bank and bag stacking together"] = "Bank and bag stacking together"--]] 
--[[Translation missing --]]
--[[ L["Buttons"] = "Buttons"--]] 
--[[Translation missing --]]
--[[ L["Character Specific Settings"] = "Character Specific Settings"--]] 
--[[Translation missing --]]
--[[ L["COMMENT_CLASS"] = "Class items"--]] 
--[[Translation missing --]]
--[[ L["Drag to modify the sorting order"] = "Drag to modify the sorting order"--]] 
--[[Translation missing --]]
--[[ L["Edit rule"] = "Edit rule"--]] 
--[[Translation missing --]]
--[[ L["Enable chat message"] = "Enable chat message"--]] 
--[[Translation missing --]]
--[[ L["Enjoy!"] = "Enjoy!"--]] 
--[[Translation missing --]]
--[[ L["Help"] = "Help"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Cloth"] = "Cloth"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Cooking"] = "Cooking"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Elemental"] = "Elemental"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Enchanting"] = "Enchanting"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Herb"] = "Herb"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Jewelry"] = "Jewelry"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Leather"] = "Leather"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Metal & Stone"] = "Metal & Stone"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Mount"] = "Mount"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Pet"] = "Pet"--]] 
--[[Translation missing --]]
--[[ L["Keep bank items stack full"] = "Keep bank items stack full"--]] 
--[[Translation missing --]]
--[[ L["KEYWORD_CLASS"] = "Classes"--]] 
--[[Translation missing --]]
--[[ L["Leave bank, pack cancel."] = "Leave bank, pack cancel."--]] 
--[[Translation missing --]]
--[[ L["Left Click"] = "Left Click"--]] 
--[[Translation missing --]]
--[[ L["Name (Optional)"] = "Name (Optional)"--]] 
--[[Translation missing --]]
--[[ L["None"] = "None"--]] 
--[[Translation missing --]]
--[[ L["OPEN_OPTIONS"] = "Open options"--]] 
--[[Translation missing --]]
--[[ L["OPEN_RULE_OPTIONS"] = "Open rule options"--]] 
--[[Translation missing --]]
--[[ L["Pack canceled."] = "Pack canceled."--]] 
--[[Translation missing --]]
--[[ L["Pack finish."] = "Pack finish."--]] 
--[[Translation missing --]]
--[[ L["Player enter combat, pack cancel."] = "Player enter combat, pack cancel."--]] 
--[[Translation missing --]]
--[[ L["Player in combat"] = "Player in combat"--]] 
--[[Translation missing --]]
--[[ L["Player is dead"] = "Player is dead"--]] 
--[[Translation missing --]]
--[[ L["Please drop the item, money or skills."] = "Please drop the item, money or skills."--]] 
--[[Translation missing --]]
--[[ L["Profile"] = "Profile"--]] 
--[[Translation missing --]]
--[[ L["Put in an item to add simple rule"] = "Put in an item to add simple rule"--]] 
--[[Translation missing --]]
--[[ L["Put where?"] = "Put where?"--]] 
--[[Translation missing --]]
--[[ L["Reset rule"] = "Reset rule"--]] 
--[[Translation missing --]]
--[[ L["Restore default Settings"] = "Restore default Settings"--]] 
--[[Translation missing --]]
--[[ L["Reverse pack"] = "Reverse pack"--]] 
--[[Translation missing --]]
--[[ L["Right Click"] = "Right Click"--]] 
--[[Translation missing --]]
--[[ L["Root"] = "Root"--]] 
--[[Translation missing --]]
--[[ L["Rule"] = "Rule"--]] 
--[[Translation missing --]]
--[[ L["Rules"] = "Rules"--]] 
--[[Translation missing --]]
--[[ L["Rules restore to default."] = "Rules restore to default."--]] 
--[[Translation missing --]]
--[[ L["SAVE"] = "Save to bank"--]] 
--[[Translation missing --]]
--[[ L["Save to bank when default packing"] = "Save to bank when default packing"--]] 
--[[Translation missing --]]
--[[ L["SAVING_DESC"] = "Save items to bank."--]] 
--[[Translation missing --]]
--[[ L["SAVING_NAME"] = "Saving"--]] 
--[[Translation missing --]]
--[[ L["Select an icon (Optional)"] = "Select an icon (Optional)"--]] 
--[[Translation missing --]]
--[[ L["Some slot is locked"] = "Some slot is locked"--]] 
--[[Translation missing --]]
--[[ L["SORT"] = "Default pack"--]] 
--[[Translation missing --]]
--[[ L["SORT_ASC"] = "Sort asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG"] = "Sort bag"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG_ASC"] = "Sort bag asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG_DESC"] = "Sort bag desc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK"] = "Sort bank"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK_ASC"] = "Sort bank asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK_DESC"] = "Sort bank desc"--]] 
--[[Translation missing --]]
--[[ L["SORT_DESC"] = "Sort desc"--]] 
--[[Translation missing --]]
--[[ L["SORTING_DESC"] = "Sort bags and bank."--]] 
--[[Translation missing --]]
--[[ L["SORTING_NAME"] = "Sorting"--]] 
--[[Translation missing --]]
--[[ L["Tools"] = "Tools"--]] 
--[[Translation missing --]]
--[[ L["Transporter"] = "Transporter"--]] 
--[[Translation missing --]]
--[[ L["UPDATE_RULES_CONFIRM"] = [=[The current version of tdPack2 updates a large number of rules. Do you want to reset the rules to the default settings?
Help to choose:
1. I know what this prompt is saying: choose for yourself
2. I don’t know how to choose: Accept
]=]--]] 
--[[Translation missing --]]
--[[ L["Usuable"] = "Usuable"--]]
-- @end-locale@
end)

T('esES', function(L)
-- @locale:language=esES@
L = L or {}
--[[Translation missing --]]
--[[ L["Add advance rule"] = "Add advance rule"--]] 
--[[Translation missing --]]
--[[ L["Add rule"] = "Add rule"--]] 
--[[Translation missing --]]
--[[ L["Advancee rules use ItemSearchModify-1.3"] = "Advancee rules use ItemSearchModify-1.3"--]] 
--[[Translation missing --]]
--[[ L["Already exists"] = "Already exists"--]] 
--[[Translation missing --]]
--[[ L["Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"] = "Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure |cffff191919DELETE|r rule?"] = "Are you sure |cffff191919DELETE|r rule?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure to |cffff1919RESET|r rules?"] = "Are you sure to |cffff1919RESET|r rules?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure you want to restore the current Settings?"] = "Are you sure you want to restore the current Settings?"--]] 
--[[Translation missing --]]
--[[ L["Bag"] = "Bag"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
--[[Translation missing --]]
--[[ L["Bank and bag stacking together"] = "Bank and bag stacking together"--]] 
--[[Translation missing --]]
--[[ L["Buttons"] = "Buttons"--]] 
--[[Translation missing --]]
--[[ L["Character Specific Settings"] = "Character Specific Settings"--]] 
--[[Translation missing --]]
--[[ L["COMMENT_CLASS"] = "Class items"--]] 
--[[Translation missing --]]
--[[ L["Drag to modify the sorting order"] = "Drag to modify the sorting order"--]] 
--[[Translation missing --]]
--[[ L["Edit rule"] = "Edit rule"--]] 
--[[Translation missing --]]
--[[ L["Enable chat message"] = "Enable chat message"--]] 
--[[Translation missing --]]
--[[ L["Enjoy!"] = "Enjoy!"--]] 
--[[Translation missing --]]
--[[ L["Help"] = "Help"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Cloth"] = "Cloth"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Cooking"] = "Cooking"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Elemental"] = "Elemental"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Enchanting"] = "Enchanting"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Herb"] = "Herb"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Jewelry"] = "Jewelry"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Leather"] = "Leather"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Metal & Stone"] = "Metal & Stone"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Mount"] = "Mount"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Pet"] = "Pet"--]] 
--[[Translation missing --]]
--[[ L["Keep bank items stack full"] = "Keep bank items stack full"--]] 
--[[Translation missing --]]
--[[ L["KEYWORD_CLASS"] = "Classes"--]] 
--[[Translation missing --]]
--[[ L["Leave bank, pack cancel."] = "Leave bank, pack cancel."--]] 
--[[Translation missing --]]
--[[ L["Left Click"] = "Left Click"--]] 
--[[Translation missing --]]
--[[ L["Name (Optional)"] = "Name (Optional)"--]] 
--[[Translation missing --]]
--[[ L["None"] = "None"--]] 
--[[Translation missing --]]
--[[ L["OPEN_OPTIONS"] = "Open options"--]] 
--[[Translation missing --]]
--[[ L["OPEN_RULE_OPTIONS"] = "Open rule options"--]] 
--[[Translation missing --]]
--[[ L["Pack canceled."] = "Pack canceled."--]] 
--[[Translation missing --]]
--[[ L["Pack finish."] = "Pack finish."--]] 
--[[Translation missing --]]
--[[ L["Player enter combat, pack cancel."] = "Player enter combat, pack cancel."--]] 
--[[Translation missing --]]
--[[ L["Player in combat"] = "Player in combat"--]] 
--[[Translation missing --]]
--[[ L["Player is dead"] = "Player is dead"--]] 
--[[Translation missing --]]
--[[ L["Please drop the item, money or skills."] = "Please drop the item, money or skills."--]] 
--[[Translation missing --]]
--[[ L["Profile"] = "Profile"--]] 
--[[Translation missing --]]
--[[ L["Put in an item to add simple rule"] = "Put in an item to add simple rule"--]] 
--[[Translation missing --]]
--[[ L["Put where?"] = "Put where?"--]] 
--[[Translation missing --]]
--[[ L["Reset rule"] = "Reset rule"--]] 
--[[Translation missing --]]
--[[ L["Restore default Settings"] = "Restore default Settings"--]] 
--[[Translation missing --]]
--[[ L["Reverse pack"] = "Reverse pack"--]] 
--[[Translation missing --]]
--[[ L["Right Click"] = "Right Click"--]] 
--[[Translation missing --]]
--[[ L["Root"] = "Root"--]] 
--[[Translation missing --]]
--[[ L["Rule"] = "Rule"--]] 
--[[Translation missing --]]
--[[ L["Rules"] = "Rules"--]] 
--[[Translation missing --]]
--[[ L["Rules restore to default."] = "Rules restore to default."--]] 
--[[Translation missing --]]
--[[ L["SAVE"] = "Save to bank"--]] 
--[[Translation missing --]]
--[[ L["Save to bank when default packing"] = "Save to bank when default packing"--]] 
--[[Translation missing --]]
--[[ L["SAVING_DESC"] = "Save items to bank."--]] 
--[[Translation missing --]]
--[[ L["SAVING_NAME"] = "Saving"--]] 
--[[Translation missing --]]
--[[ L["Select an icon (Optional)"] = "Select an icon (Optional)"--]] 
--[[Translation missing --]]
--[[ L["Some slot is locked"] = "Some slot is locked"--]] 
--[[Translation missing --]]
--[[ L["SORT"] = "Default pack"--]] 
--[[Translation missing --]]
--[[ L["SORT_ASC"] = "Sort asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG"] = "Sort bag"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG_ASC"] = "Sort bag asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG_DESC"] = "Sort bag desc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK"] = "Sort bank"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK_ASC"] = "Sort bank asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK_DESC"] = "Sort bank desc"--]] 
--[[Translation missing --]]
--[[ L["SORT_DESC"] = "Sort desc"--]] 
--[[Translation missing --]]
--[[ L["SORTING_DESC"] = "Sort bags and bank."--]] 
--[[Translation missing --]]
--[[ L["SORTING_NAME"] = "Sorting"--]] 
--[[Translation missing --]]
--[[ L["Tools"] = "Tools"--]] 
--[[Translation missing --]]
--[[ L["Transporter"] = "Transporter"--]] 
--[[Translation missing --]]
--[[ L["UPDATE_RULES_CONFIRM"] = [=[The current version of tdPack2 updates a large number of rules. Do you want to reset the rules to the default settings?
Help to choose:
1. I know what this prompt is saying: choose for yourself
2. I don’t know how to choose: Accept
]=]--]] 
--[[Translation missing --]]
--[[ L["Usuable"] = "Usuable"--]]
-- @end-locale@
end)

T('frFR', function(L)
-- @locale:language=frFR@
L = L or {}
--[[Translation missing --]]
--[[ L["Add advance rule"] = "Add advance rule"--]] 
--[[Translation missing --]]
--[[ L["Add rule"] = "Add rule"--]] 
--[[Translation missing --]]
--[[ L["Advancee rules use ItemSearchModify-1.3"] = "Advancee rules use ItemSearchModify-1.3"--]] 
--[[Translation missing --]]
--[[ L["Already exists"] = "Already exists"--]] 
--[[Translation missing --]]
--[[ L["Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"] = "Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure |cffff191919DELETE|r rule?"] = "Are you sure |cffff191919DELETE|r rule?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure to |cffff1919RESET|r rules?"] = "Are you sure to |cffff1919RESET|r rules?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure you want to restore the current Settings?"] = "Are you sure you want to restore the current Settings?"--]] 
--[[Translation missing --]]
--[[ L["Bag"] = "Bag"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
--[[Translation missing --]]
--[[ L["Bank and bag stacking together"] = "Bank and bag stacking together"--]] 
--[[Translation missing --]]
--[[ L["Buttons"] = "Buttons"--]] 
--[[Translation missing --]]
--[[ L["Character Specific Settings"] = "Character Specific Settings"--]] 
--[[Translation missing --]]
--[[ L["COMMENT_CLASS"] = "Class items"--]] 
--[[Translation missing --]]
--[[ L["Drag to modify the sorting order"] = "Drag to modify the sorting order"--]] 
--[[Translation missing --]]
--[[ L["Edit rule"] = "Edit rule"--]] 
--[[Translation missing --]]
--[[ L["Enable chat message"] = "Enable chat message"--]] 
--[[Translation missing --]]
--[[ L["Enjoy!"] = "Enjoy!"--]] 
--[[Translation missing --]]
--[[ L["Help"] = "Help"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Cloth"] = "Cloth"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Cooking"] = "Cooking"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Elemental"] = "Elemental"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Enchanting"] = "Enchanting"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Herb"] = "Herb"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Jewelry"] = "Jewelry"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Leather"] = "Leather"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Metal & Stone"] = "Metal & Stone"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Mount"] = "Mount"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Pet"] = "Pet"--]] 
--[[Translation missing --]]
--[[ L["Keep bank items stack full"] = "Keep bank items stack full"--]] 
--[[Translation missing --]]
--[[ L["KEYWORD_CLASS"] = "Classes"--]] 
--[[Translation missing --]]
--[[ L["Leave bank, pack cancel."] = "Leave bank, pack cancel."--]] 
--[[Translation missing --]]
--[[ L["Left Click"] = "Left Click"--]] 
--[[Translation missing --]]
--[[ L["Name (Optional)"] = "Name (Optional)"--]] 
--[[Translation missing --]]
--[[ L["None"] = "None"--]] 
--[[Translation missing --]]
--[[ L["OPEN_OPTIONS"] = "Open options"--]] 
--[[Translation missing --]]
--[[ L["OPEN_RULE_OPTIONS"] = "Open rule options"--]] 
--[[Translation missing --]]
--[[ L["Pack canceled."] = "Pack canceled."--]] 
--[[Translation missing --]]
--[[ L["Pack finish."] = "Pack finish."--]] 
--[[Translation missing --]]
--[[ L["Player enter combat, pack cancel."] = "Player enter combat, pack cancel."--]] 
--[[Translation missing --]]
--[[ L["Player in combat"] = "Player in combat"--]] 
--[[Translation missing --]]
--[[ L["Player is dead"] = "Player is dead"--]] 
--[[Translation missing --]]
--[[ L["Please drop the item, money or skills."] = "Please drop the item, money or skills."--]] 
--[[Translation missing --]]
--[[ L["Profile"] = "Profile"--]] 
--[[Translation missing --]]
--[[ L["Put in an item to add simple rule"] = "Put in an item to add simple rule"--]] 
--[[Translation missing --]]
--[[ L["Put where?"] = "Put where?"--]] 
--[[Translation missing --]]
--[[ L["Reset rule"] = "Reset rule"--]] 
--[[Translation missing --]]
--[[ L["Restore default Settings"] = "Restore default Settings"--]] 
--[[Translation missing --]]
--[[ L["Reverse pack"] = "Reverse pack"--]] 
--[[Translation missing --]]
--[[ L["Right Click"] = "Right Click"--]] 
--[[Translation missing --]]
--[[ L["Root"] = "Root"--]] 
--[[Translation missing --]]
--[[ L["Rule"] = "Rule"--]] 
--[[Translation missing --]]
--[[ L["Rules"] = "Rules"--]] 
--[[Translation missing --]]
--[[ L["Rules restore to default."] = "Rules restore to default."--]] 
--[[Translation missing --]]
--[[ L["SAVE"] = "Save to bank"--]] 
--[[Translation missing --]]
--[[ L["Save to bank when default packing"] = "Save to bank when default packing"--]] 
--[[Translation missing --]]
--[[ L["SAVING_DESC"] = "Save items to bank."--]] 
--[[Translation missing --]]
--[[ L["SAVING_NAME"] = "Saving"--]] 
--[[Translation missing --]]
--[[ L["Select an icon (Optional)"] = "Select an icon (Optional)"--]] 
--[[Translation missing --]]
--[[ L["Some slot is locked"] = "Some slot is locked"--]] 
--[[Translation missing --]]
--[[ L["SORT"] = "Default pack"--]] 
--[[Translation missing --]]
--[[ L["SORT_ASC"] = "Sort asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG"] = "Sort bag"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG_ASC"] = "Sort bag asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG_DESC"] = "Sort bag desc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK"] = "Sort bank"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK_ASC"] = "Sort bank asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK_DESC"] = "Sort bank desc"--]] 
--[[Translation missing --]]
--[[ L["SORT_DESC"] = "Sort desc"--]] 
--[[Translation missing --]]
--[[ L["SORTING_DESC"] = "Sort bags and bank."--]] 
--[[Translation missing --]]
--[[ L["SORTING_NAME"] = "Sorting"--]] 
--[[Translation missing --]]
--[[ L["Tools"] = "Tools"--]] 
--[[Translation missing --]]
--[[ L["Transporter"] = "Transporter"--]] 
--[[Translation missing --]]
--[[ L["UPDATE_RULES_CONFIRM"] = [=[The current version of tdPack2 updates a large number of rules. Do you want to reset the rules to the default settings?
Help to choose:
1. I know what this prompt is saying: choose for yourself
2. I don’t know how to choose: Accept
]=]--]] 
--[[Translation missing --]]
--[[ L["Usuable"] = "Usuable"--]]
-- @end-locale@
end)

T('itIT', function(L)
-- @locale:language=itIT@
L = L or {}
--[[Translation missing --]]
--[[ L["Add advance rule"] = "Add advance rule"--]] 
--[[Translation missing --]]
--[[ L["Add rule"] = "Add rule"--]] 
--[[Translation missing --]]
--[[ L["Advancee rules use ItemSearchModify-1.3"] = "Advancee rules use ItemSearchModify-1.3"--]] 
--[[Translation missing --]]
--[[ L["Already exists"] = "Already exists"--]] 
--[[Translation missing --]]
--[[ L["Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"] = "Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure |cffff191919DELETE|r rule?"] = "Are you sure |cffff191919DELETE|r rule?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure to |cffff1919RESET|r rules?"] = "Are you sure to |cffff1919RESET|r rules?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure you want to restore the current Settings?"] = "Are you sure you want to restore the current Settings?"--]] 
--[[Translation missing --]]
--[[ L["Bag"] = "Bag"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
--[[Translation missing --]]
--[[ L["Bank and bag stacking together"] = "Bank and bag stacking together"--]] 
--[[Translation missing --]]
--[[ L["Buttons"] = "Buttons"--]] 
--[[Translation missing --]]
--[[ L["Character Specific Settings"] = "Character Specific Settings"--]] 
--[[Translation missing --]]
--[[ L["COMMENT_CLASS"] = "Class items"--]] 
--[[Translation missing --]]
--[[ L["Drag to modify the sorting order"] = "Drag to modify the sorting order"--]] 
--[[Translation missing --]]
--[[ L["Edit rule"] = "Edit rule"--]] 
--[[Translation missing --]]
--[[ L["Enable chat message"] = "Enable chat message"--]] 
--[[Translation missing --]]
--[[ L["Enjoy!"] = "Enjoy!"--]] 
--[[Translation missing --]]
--[[ L["Help"] = "Help"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Cloth"] = "Cloth"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Cooking"] = "Cooking"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Elemental"] = "Elemental"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Enchanting"] = "Enchanting"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Herb"] = "Herb"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Jewelry"] = "Jewelry"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Leather"] = "Leather"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Metal & Stone"] = "Metal & Stone"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Mount"] = "Mount"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Pet"] = "Pet"--]] 
--[[Translation missing --]]
--[[ L["Keep bank items stack full"] = "Keep bank items stack full"--]] 
--[[Translation missing --]]
--[[ L["KEYWORD_CLASS"] = "Classes"--]] 
--[[Translation missing --]]
--[[ L["Leave bank, pack cancel."] = "Leave bank, pack cancel."--]] 
--[[Translation missing --]]
--[[ L["Left Click"] = "Left Click"--]] 
--[[Translation missing --]]
--[[ L["Name (Optional)"] = "Name (Optional)"--]] 
--[[Translation missing --]]
--[[ L["None"] = "None"--]] 
--[[Translation missing --]]
--[[ L["OPEN_OPTIONS"] = "Open options"--]] 
--[[Translation missing --]]
--[[ L["OPEN_RULE_OPTIONS"] = "Open rule options"--]] 
--[[Translation missing --]]
--[[ L["Pack canceled."] = "Pack canceled."--]] 
--[[Translation missing --]]
--[[ L["Pack finish."] = "Pack finish."--]] 
--[[Translation missing --]]
--[[ L["Player enter combat, pack cancel."] = "Player enter combat, pack cancel."--]] 
--[[Translation missing --]]
--[[ L["Player in combat"] = "Player in combat"--]] 
--[[Translation missing --]]
--[[ L["Player is dead"] = "Player is dead"--]] 
--[[Translation missing --]]
--[[ L["Please drop the item, money or skills."] = "Please drop the item, money or skills."--]] 
--[[Translation missing --]]
--[[ L["Profile"] = "Profile"--]] 
--[[Translation missing --]]
--[[ L["Put in an item to add simple rule"] = "Put in an item to add simple rule"--]] 
--[[Translation missing --]]
--[[ L["Put where?"] = "Put where?"--]] 
--[[Translation missing --]]
--[[ L["Reset rule"] = "Reset rule"--]] 
--[[Translation missing --]]
--[[ L["Restore default Settings"] = "Restore default Settings"--]] 
--[[Translation missing --]]
--[[ L["Reverse pack"] = "Reverse pack"--]] 
--[[Translation missing --]]
--[[ L["Right Click"] = "Right Click"--]] 
--[[Translation missing --]]
--[[ L["Root"] = "Root"--]] 
--[[Translation missing --]]
--[[ L["Rule"] = "Rule"--]] 
--[[Translation missing --]]
--[[ L["Rules"] = "Rules"--]] 
--[[Translation missing --]]
--[[ L["Rules restore to default."] = "Rules restore to default."--]] 
--[[Translation missing --]]
--[[ L["SAVE"] = "Save to bank"--]] 
--[[Translation missing --]]
--[[ L["Save to bank when default packing"] = "Save to bank when default packing"--]] 
--[[Translation missing --]]
--[[ L["SAVING_DESC"] = "Save items to bank."--]] 
--[[Translation missing --]]
--[[ L["SAVING_NAME"] = "Saving"--]] 
--[[Translation missing --]]
--[[ L["Select an icon (Optional)"] = "Select an icon (Optional)"--]] 
--[[Translation missing --]]
--[[ L["Some slot is locked"] = "Some slot is locked"--]] 
--[[Translation missing --]]
--[[ L["SORT"] = "Default pack"--]] 
--[[Translation missing --]]
--[[ L["SORT_ASC"] = "Sort asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG"] = "Sort bag"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG_ASC"] = "Sort bag asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG_DESC"] = "Sort bag desc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK"] = "Sort bank"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK_ASC"] = "Sort bank asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK_DESC"] = "Sort bank desc"--]] 
--[[Translation missing --]]
--[[ L["SORT_DESC"] = "Sort desc"--]] 
--[[Translation missing --]]
--[[ L["SORTING_DESC"] = "Sort bags and bank."--]] 
--[[Translation missing --]]
--[[ L["SORTING_NAME"] = "Sorting"--]] 
--[[Translation missing --]]
--[[ L["Tools"] = "Tools"--]] 
--[[Translation missing --]]
--[[ L["Transporter"] = "Transporter"--]] 
--[[Translation missing --]]
--[[ L["UPDATE_RULES_CONFIRM"] = [=[The current version of tdPack2 updates a large number of rules. Do you want to reset the rules to the default settings?
Help to choose:
1. I know what this prompt is saying: choose for yourself
2. I don’t know how to choose: Accept
]=]--]] 
--[[Translation missing --]]
--[[ L["Usuable"] = "Usuable"--]]
-- @end-locale@
end)

T('koKR', function(L)
-- @locale:language=koKR@
L = L or {}
L["Add advance rule"] = "고급 규칙 추가"
--[[Translation missing --]]
--[[ L["Add rule"] = "Add rule"--]] 
--[[Translation missing --]]
--[[ L["Advancee rules use ItemSearchModify-1.3"] = "Advancee rules use ItemSearchModify-1.3"--]] 
L["Already exists"] = "이미 존재함"
L["Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"] = "규칙과 |cffff1919하위 규칙|r을 |cffff1919삭제|r 하시겠습니까?"
L["Are you sure |cffff191919DELETE|r rule?"] = "규칙을 |cffff1919삭제|r 하시겠습니까?"
--[[Translation missing --]]
--[[ L["Are you sure to |cffff1919RESET|r rules?"] = "Are you sure to |cffff1919RESET|r rules?"--]] 
L["Are you sure you want to restore the current Settings?"] = "현재 설정을 복원 하시겠습니까?"
--[[Translation missing --]]
--[[ L["Bag"] = "Bag"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
L["Bank and bag stacking together"] = "은행과 가방을 함께 중첩"
--[[Translation missing --]]
--[[ L["Buttons"] = "Buttons"--]] 
L["Character Specific Settings"] = "캐릭터 개별 설정"
--[[Translation missing --]]
--[[ L["COMMENT_CLASS"] = "Class items"--]] 
L["Drag to modify the sorting order"] = "정리 순서를 수정하려면 드래그 합니다."
--[[Translation missing --]]
--[[ L["Edit rule"] = "Edit rule"--]] 
L["Enable chat message"] = "대화 메세지 사용"
L["Enjoy!"] = "즐기세요!"
L["Help"] = "도움말"
L["ITEM_TAG: Cloth"] = "천"
L["ITEM_TAG: Cooking"] = "요리"
L["ITEM_TAG: Elemental"] = "원소"
L["ITEM_TAG: Enchanting"] = "마법부여"
L["ITEM_TAG: Herb"] = "약초"
L["ITEM_TAG: Jewelry"] = "보석"
L["ITEM_TAG: Leather"] = "가죽"
L["ITEM_TAG: Metal & Stone"] = "광석과 주괴"
L["ITEM_TAG: Mount"] = "탈것"
L["ITEM_TAG: Pet"] = "애완동물"
L["Keep bank items stack full"] = "은행 아이템을 중첩하여 채움"
--[[Translation missing --]]
--[[ L["KEYWORD_CLASS"] = "Classes"--]] 
L["Leave bank, pack cancel."] = "은행을 떠나 정리를 취소합니다."
L["Left Click"] = "좌클릭"
L["Name (Optional)"] = "이름 (선택 사항)"
L["None"] = "없음"
L["OPEN_OPTIONS"] = "설정 열기"
L["OPEN_RULE_OPTIONS"] = "규칙 설정 열기"
--[[Translation missing --]]
--[[ L["Pack canceled."] = "Pack canceled."--]] 
L["Pack finish."] = "정리 마침."
L["Player enter combat, pack cancel."] = "플레이어 전투 참여로 정리를 취소합니다."
L["Player in combat"] = "플레이어가 전투 중입니다"
L["Player is dead"] = "플레이어가 죽었습니다"
L["Please drop the item, money or skills."] = "아이템, 돈 또는 기술을 떨어뜨려 주세요."
--[[Translation missing --]]
--[[ L["Profile"] = "Profile"--]] 
L["Put in an item to add simple rule"] = "간단한 규칙을 추가하기 위해 아이템을 넣습니다."
L["Put where?"] = "어디에 넣을까요?"
--[[Translation missing --]]
--[[ L["Reset rule"] = "Reset rule"--]] 
L["Restore default Settings"] = "기본 설정 복원"
L["Reverse pack"] = "반대로 정리"
L["Right Click"] = "우클릭"
L["Root"] = "최상위"
L["Rule"] = "규칙"
--[[Translation missing --]]
--[[ L["Rules"] = "Rules"--]] 
--[[Translation missing --]]
--[[ L["Rules restore to default."] = "Rules restore to default."--]] 
L["SAVE"] = "은행에 보관"
L["Save to bank when default packing"] = "기본 정리 시 은행에 보관"
--[[Translation missing --]]
--[[ L["SAVING_DESC"] = "Save items to bank."--]] 
--[[Translation missing --]]
--[[ L["SAVING_NAME"] = "Saving"--]] 
L["Select an icon (Optional)"] = "아이콘 선택 (선택 사항)"
L["Some slot is locked"] = "일부 칸이 잠겨 있음."
L["SORT"] = "기본 정리"
L["SORT_ASC"] = "오름차순 정리"
L["SORT_BAG"] = "가방 정리"
L["SORT_BAG_ASC"] = "가방 오름차순 정리"
L["SORT_BAG_DESC"] = "가방 내림차순 정리"
L["SORT_BANK"] = "은행 정리"
L["SORT_BANK_ASC"] = "은행 오름차순 정리"
L["SORT_BANK_DESC"] = "은행 내림차순 정리"
L["SORT_DESC"] = "내림차순 정리"
--[[Translation missing --]]
--[[ L["SORTING_DESC"] = "Sort bags and bank."--]] 
--[[Translation missing --]]
--[[ L["SORTING_NAME"] = "Sorting"--]] 
L["Tools"] = "도구"
--[[Translation missing --]]
--[[ L["Transporter"] = "Transporter"--]] 
--[[Translation missing --]]
--[[ L["UPDATE_RULES_CONFIRM"] = [=[The current version of tdPack2 updates a large number of rules. Do you want to reset the rules to the default settings?
Help to choose:
1. I know what this prompt is saying: choose for yourself
2. I don’t know how to choose: Accept
]=]--]] 
--[[Translation missing --]]
--[[ L["Usuable"] = "Usuable"--]]
-- @end-locale@
end)

T('ptBR', function(L)
-- @locale:language=ptBR@
L = L or {}
--[[Translation missing --]]
--[[ L["Add advance rule"] = "Add advance rule"--]] 
--[[Translation missing --]]
--[[ L["Add rule"] = "Add rule"--]] 
--[[Translation missing --]]
--[[ L["Advancee rules use ItemSearchModify-1.3"] = "Advancee rules use ItemSearchModify-1.3"--]] 
--[[Translation missing --]]
--[[ L["Already exists"] = "Already exists"--]] 
--[[Translation missing --]]
--[[ L["Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"] = "Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure |cffff191919DELETE|r rule?"] = "Are you sure |cffff191919DELETE|r rule?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure to |cffff1919RESET|r rules?"] = "Are you sure to |cffff1919RESET|r rules?"--]] 
--[[Translation missing --]]
--[[ L["Are you sure you want to restore the current Settings?"] = "Are you sure you want to restore the current Settings?"--]] 
--[[Translation missing --]]
--[[ L["Bag"] = "Bag"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
--[[Translation missing --]]
--[[ L["Bank and bag stacking together"] = "Bank and bag stacking together"--]] 
--[[Translation missing --]]
--[[ L["Buttons"] = "Buttons"--]] 
--[[Translation missing --]]
--[[ L["Character Specific Settings"] = "Character Specific Settings"--]] 
--[[Translation missing --]]
--[[ L["COMMENT_CLASS"] = "Class items"--]] 
--[[Translation missing --]]
--[[ L["Drag to modify the sorting order"] = "Drag to modify the sorting order"--]] 
--[[Translation missing --]]
--[[ L["Edit rule"] = "Edit rule"--]] 
--[[Translation missing --]]
--[[ L["Enable chat message"] = "Enable chat message"--]] 
--[[Translation missing --]]
--[[ L["Enjoy!"] = "Enjoy!"--]] 
--[[Translation missing --]]
--[[ L["Help"] = "Help"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Cloth"] = "Cloth"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Cooking"] = "Cooking"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Elemental"] = "Elemental"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Enchanting"] = "Enchanting"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Herb"] = "Herb"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Jewelry"] = "Jewelry"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Leather"] = "Leather"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Metal & Stone"] = "Metal & Stone"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Mount"] = "Mount"--]] 
--[[Translation missing --]]
--[[ L["ITEM_TAG: Pet"] = "Pet"--]] 
--[[Translation missing --]]
--[[ L["Keep bank items stack full"] = "Keep bank items stack full"--]] 
--[[Translation missing --]]
--[[ L["KEYWORD_CLASS"] = "Classes"--]] 
--[[Translation missing --]]
--[[ L["Leave bank, pack cancel."] = "Leave bank, pack cancel."--]] 
--[[Translation missing --]]
--[[ L["Left Click"] = "Left Click"--]] 
--[[Translation missing --]]
--[[ L["Name (Optional)"] = "Name (Optional)"--]] 
--[[Translation missing --]]
--[[ L["None"] = "None"--]] 
--[[Translation missing --]]
--[[ L["OPEN_OPTIONS"] = "Open options"--]] 
--[[Translation missing --]]
--[[ L["OPEN_RULE_OPTIONS"] = "Open rule options"--]] 
--[[Translation missing --]]
--[[ L["Pack canceled."] = "Pack canceled."--]] 
--[[Translation missing --]]
--[[ L["Pack finish."] = "Pack finish."--]] 
--[[Translation missing --]]
--[[ L["Player enter combat, pack cancel."] = "Player enter combat, pack cancel."--]] 
--[[Translation missing --]]
--[[ L["Player in combat"] = "Player in combat"--]] 
--[[Translation missing --]]
--[[ L["Player is dead"] = "Player is dead"--]] 
--[[Translation missing --]]
--[[ L["Please drop the item, money or skills."] = "Please drop the item, money or skills."--]] 
--[[Translation missing --]]
--[[ L["Profile"] = "Profile"--]] 
--[[Translation missing --]]
--[[ L["Put in an item to add simple rule"] = "Put in an item to add simple rule"--]] 
--[[Translation missing --]]
--[[ L["Put where?"] = "Put where?"--]] 
--[[Translation missing --]]
--[[ L["Reset rule"] = "Reset rule"--]] 
--[[Translation missing --]]
--[[ L["Restore default Settings"] = "Restore default Settings"--]] 
--[[Translation missing --]]
--[[ L["Reverse pack"] = "Reverse pack"--]] 
--[[Translation missing --]]
--[[ L["Right Click"] = "Right Click"--]] 
--[[Translation missing --]]
--[[ L["Root"] = "Root"--]] 
--[[Translation missing --]]
--[[ L["Rule"] = "Rule"--]] 
--[[Translation missing --]]
--[[ L["Rules"] = "Rules"--]] 
--[[Translation missing --]]
--[[ L["Rules restore to default."] = "Rules restore to default."--]] 
--[[Translation missing --]]
--[[ L["SAVE"] = "Save to bank"--]] 
--[[Translation missing --]]
--[[ L["Save to bank when default packing"] = "Save to bank when default packing"--]] 
--[[Translation missing --]]
--[[ L["SAVING_DESC"] = "Save items to bank."--]] 
--[[Translation missing --]]
--[[ L["SAVING_NAME"] = "Saving"--]] 
--[[Translation missing --]]
--[[ L["Select an icon (Optional)"] = "Select an icon (Optional)"--]] 
--[[Translation missing --]]
--[[ L["Some slot is locked"] = "Some slot is locked"--]] 
--[[Translation missing --]]
--[[ L["SORT"] = "Default pack"--]] 
--[[Translation missing --]]
--[[ L["SORT_ASC"] = "Sort asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG"] = "Sort bag"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG_ASC"] = "Sort bag asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BAG_DESC"] = "Sort bag desc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK"] = "Sort bank"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK_ASC"] = "Sort bank asc"--]] 
--[[Translation missing --]]
--[[ L["SORT_BANK_DESC"] = "Sort bank desc"--]] 
--[[Translation missing --]]
--[[ L["SORT_DESC"] = "Sort desc"--]] 
--[[Translation missing --]]
--[[ L["SORTING_DESC"] = "Sort bags and bank."--]] 
--[[Translation missing --]]
--[[ L["SORTING_NAME"] = "Sorting"--]] 
--[[Translation missing --]]
--[[ L["Tools"] = "Tools"--]] 
--[[Translation missing --]]
--[[ L["Transporter"] = "Transporter"--]] 
--[[Translation missing --]]
--[[ L["UPDATE_RULES_CONFIRM"] = [=[The current version of tdPack2 updates a large number of rules. Do you want to reset the rules to the default settings?
Help to choose:
1. I know what this prompt is saying: choose for yourself
2. I don’t know how to choose: Accept
]=]--]] 
--[[Translation missing --]]
--[[ L["Usuable"] = "Usuable"--]]
-- @end-locale@
end)

T('ruRU', function(L)
-- @locale:language=ruRU@
L = L or {}
L["Add advance rule"] = "Добавить расширенное правило"
L["Add rule"] = "Добавить правило"
L["Advancee rules use ItemSearchModify-1.3"] = "Расширенные правила используют ItemSearchModify-1.3"
L["Already exists"] = "Уже существует"
L["Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"] = "Вы уверены, что хотите |cffff191919УДАЛИТЬ|r правило и его |cffff1919ПОДПРАВИЛА|r?"
L["Are you sure |cffff191919DELETE|r rule?"] = "Вы уверены, что хотите |cffff191919УДАЛИТЬ|r правило?"
L["Are you sure to |cffff1919RESET|r rules?"] = "Вы уверены, что хотите |cffff1919СБРОСИТЬ|r правила?"
L["Are you sure you want to restore the current Settings?"] = "Вы уверены, что хотите восстановить текущие настройки?"
L["Bag"] = "Сумка"
L["Bank"] = "Банк"
L["Bank and bag stacking together"] = "Сумка и банк складываются вместе"
L["Buttons"] = "Кнопки"
L["Character Specific Settings"] = "Настройки для конкретного персонажа"
L["COMMENT_CLASS"] = "Классовые предметы"
L["Drag to modify the sorting order"] = "Перетащите, чтобы изменить порядок сортировки"
L["Edit rule"] = "Редактировать правило"
L["Enable chat message"] = "Включить сообщения в чате"
L["Enjoy!"] = "Наслаждайтесь!"
L["Help"] = "Помощь"
L["ITEM_TAG: Cloth"] = "Ткань"
L["ITEM_TAG: Cooking"] = "Кулинария"
L["ITEM_TAG: Elemental"] = "Стихии"
L["ITEM_TAG: Enchanting"] = "Зачарование"
L["ITEM_TAG: Herb"] = "Трава"
L["ITEM_TAG: Jewelry"] = "Ювелирные изделия"
L["ITEM_TAG: Leather"] = "Кожа"
L["ITEM_TAG: Metal & Stone"] = "Металл и камень"
L["ITEM_TAG: Mount"] = "Маунт"
L["ITEM_TAG: Pet"] = "Питомец"
L["Keep bank items stack full"] = "Держать стопки предметов в банке полными"
L["KEYWORD_CLASS"] = "Классы"
L["Leave bank, pack cancel."] = "Покинуть банк, упаковка отменена."
L["Left Click"] = "ЛКМ"
L["Name (Optional)"] = "Имя (опционально)"
L["None"] = "Ничего"
L["OPEN_OPTIONS"] = "Открыть настройки"
L["OPEN_RULE_OPTIONS"] = "Открыть настройки правил"
L["Pack canceled."] = "Упаковка отменена."
L["Pack finish."] = "Упаковка завершена."
L["Player enter combat, pack cancel."] = "Игрок вступил в бой, упаковка отменена."
L["Player in combat"] = "Игрок в бою"
L["Player is dead"] = "Игрок мертв"
L["Please drop the item, money or skills."] = "Пожалуйста, выбросите предмет, деньги или навыки."
L["Profile"] = "Профиль"
L["Put in an item to add simple rule"] = "Поместите предмет, чтобы добавить простое правило"
L["Put where?"] = "Куда положить?"
L["Reset rule"] = "Сбросить правило"
L["Restore default Settings"] = "Восстановить настройки по умолчанию"
L["Reverse pack"] = "Обратная упаковка"
L["Right Click"] = "ПКМ"
L["Root"] = "Корень"
L["Rule"] = "Правило"
L["Rules"] = "Правила"
L["Rules restore to default."] = "Правила восстановлены по умолчанию."
L["SAVE"] = "Сохранить в банк"
L["Save to bank when default packing"] = "Сохранять в банк при стандартной упаковке"
L["SAVING_DESC"] = "Сохранять предметы в банк."
L["SAVING_NAME"] = "Сохранение"
L["Select an icon (Optional)"] = "Выберите иконку (опционально)"
L["Some slot is locked"] = "Некоторые слоты заблокированы"
L["SORT"] = "Упаковка по умолчанию"
L["SORT_ASC"] = "Сортировать по возрастанию"
L["SORT_BAG"] = "Сортировать сумку"
L["SORT_BAG_ASC"] = "Сортировать сумку по возрастанию"
L["SORT_BAG_DESC"] = "Сортировать сумку по убыванию"
L["SORT_BANK"] = "Сортировать банк"
L["SORT_BANK_ASC"] = "Сортировать банк по возрастанию"
L["SORT_BANK_DESC"] = "Сортировать банк по убыванию"
L["SORT_DESC"] = "Сортировать по убыванию"
L["SORTING_DESC"] = "Сортировать сумки и банк."
L["SORTING_NAME"] = "Сортировка"
L["Tools"] = "Инструменты"
L["Transporter"] = "Транспортер"
L["UPDATE_RULES_CONFIRM"] = [=[Текущая версия tdPack2 обновляет большое количество правил. Хотите сбросить правила на настройки по умолчанию?
Помощь в выборе:
1. Я знаю, о чем этот запрос: выберите самостоятельно
2. Я не знаю, как выбрать: Принять
]=]
L["Usuable"] = "Используемый"
-- @end-locale@
end)

T('zhTW', function(L)
-- @locale:language=zhTW@
L = L or {}
L["Add advance rule"] = "添加高級規則"
--[[Translation missing --]]
--[[ L["Add rule"] = "Add rule"--]] 
--[[Translation missing --]]
--[[ L["Advancee rules use ItemSearchModify-1.3"] = "Advancee rules use ItemSearchModify-1.3"--]] 
L["Already exists"] = "已經存在"
L["Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?"] = "確定|cffff1919刪除|r規則和它的|cffff1919子規則|r嗎？"
L["Are you sure |cffff191919DELETE|r rule?"] = "你確定|cffff1919刪除|r規則嗎？"
--[[Translation missing --]]
--[[ L["Are you sure to |cffff1919RESET|r rules?"] = "Are you sure to |cffff1919RESET|r rules?"--]] 
L["Are you sure you want to restore the current Settings?"] = "你確定要重置當前設置嗎？"
--[[Translation missing --]]
--[[ L["Bag"] = "Bag"--]] 
--[[Translation missing --]]
--[[ L["Bank"] = "Bank"--]] 
L["Bank and bag stacking together"] = "銀行和背包一起堆疊"
--[[Translation missing --]]
--[[ L["Buttons"] = "Buttons"--]] 
L["Character Specific Settings"] = "角色獨立設置"
--[[Translation missing --]]
--[[ L["COMMENT_CLASS"] = "Class items"--]] 
L["Drag to modify the sorting order"] = "拖動以改變規則順序"
--[[Translation missing --]]
--[[ L["Edit rule"] = "Edit rule"--]] 
L["Enable chat message"] = "啟用聊天窗口消息"
L["Enjoy!"] = true
L["Help"] = "幫助"
L["ITEM_TAG: Cloth"] = "布"
L["ITEM_TAG: Cooking"] = "烹飪"
L["ITEM_TAG: Elemental"] = "元素"
L["ITEM_TAG: Enchanting"] = "附魔"
L["ITEM_TAG: Herb"] = "草藥"
L["ITEM_TAG: Jewelry"] = "寶石"
L["ITEM_TAG: Leather"] = "皮"
L["ITEM_TAG: Metal & Stone"] = "金屬和礦石"
L["ITEM_TAG: Mount"] = "坐騎"
L["ITEM_TAG: Pet"] = "寵物"
L["Keep bank items stack full"] = "保持銀行物品堆滿"
--[[Translation missing --]]
--[[ L["KEYWORD_CLASS"] = "Classes"--]] 
L["Leave bank, pack cancel."] = "離開銀行，整理中止。"
L["Left Click"] = "左鍵"
L["Name (Optional)"] = "名稱（可選）"
L["None"] = "無"
L["OPEN_OPTIONS"] = "打開設置"
L["OPEN_RULE_OPTIONS"] = "打開規則設置"
--[[Translation missing --]]
--[[ L["Pack canceled."] = "Pack canceled."--]] 
L["Pack finish."] = "整理完成"
L["Player enter combat, pack cancel."] = "進入戰鬥，整理中止。"
L["Player in combat"] = "正在戰鬥"
L["Player is dead"] = "角色已死亡"
L["Please drop the item, money or skills."] = true
--[[Translation missing --]]
--[[ L["Profile"] = "Profile"--]] 
L["Put in an item to add simple rule"] = "放下一個物品以添加簡單規則"
L["Put where?"] = "放在哪？"
--[[Translation missing --]]
--[[ L["Reset rule"] = "Reset rule"--]] 
L["Restore default Settings"] = "恢覆默認設置"
L["Reverse pack"] = "反向整理"
L["Right Click"] = "右鍵"
L["Root"] = "根"
L["Rule"] = "規則"
--[[Translation missing --]]
--[[ L["Rules"] = "Rules"--]] 
--[[Translation missing --]]
--[[ L["Rules restore to default."] = "Rules restore to default."--]] 
L["SAVE"] = "保存"
L["Save to bank when default packing"] = "默認整理同時保存到銀行"
--[[Translation missing --]]
--[[ L["SAVING_DESC"] = "Save items to bank."--]] 
--[[Translation missing --]]
--[[ L["SAVING_NAME"] = "Saving"--]] 
L["Select an icon (Optional)"] = "選擇一個圖標（可選）"
L["Some slot is locked"] = "一些物品已鎖定"
L["SORT"] = "默認整理"
L["SORT_ASC"] = "順序整理全部"
L["SORT_BAG"] = "整理背包"
L["SORT_BAG_ASC"] = "順序整理背包"
L["SORT_BAG_DESC"] = "逆序整理背包"
L["SORT_BANK"] = "整理銀行"
L["SORT_BANK_ASC"] = "順序整理銀行"
L["SORT_BANK_DESC"] = "逆序整理銀行"
L["SORT_DESC"] = "逆序整理背包"
--[[Translation missing --]]
--[[ L["SORTING_DESC"] = "Sort bags and bank."--]] 
--[[Translation missing --]]
--[[ L["SORTING_NAME"] = "Sorting"--]] 
L["Tools"] = "工具"
--[[Translation missing --]]
--[[ L["Transporter"] = "Transporter"--]] 
--[[Translation missing --]]
--[[ L["UPDATE_RULES_CONFIRM"] = [=[The current version of tdPack2 updates a large number of rules. Do you want to reset the rules to the default settings?
Help to choose:
1. I know what this prompt is saying: choose for yourself
2. I don’t know how to choose: Accept
]=]--]] 
--[[Translation missing --]]
--[[ L["Usuable"] = "Usuable"--]]
-- @end-locale@
end)
