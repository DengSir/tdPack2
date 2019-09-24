
---@class L
local L = LibStub('AceLocale-3.0'):NewLocale(..., 'zhCN')
if not L then return end

L['Leave bank, pack cancel.'] = '离开银行，整理中止。'
L['Player enter combat, pack cancel.'] = '进入战斗，整理中止。'
L['Packing now'] = '正在整理'
L['Player is dead'] = '角色已死亡'
L['Player in combat'] = '正在战斗'
L['Please drop the item, money or skills.'] = true
L['Pack finish.'] = '整理完成'

L['Reverse pack'] = '反向整理'
L['Enable chat message'] = '启用聊天窗口消息'

L['Left Click'] = '左键'
L['Right Click'] = '右键'

L['Bag button features'] = '背包按钮功能'
L['Bank button features'] = '银行按钮功能'

-- for actions
L.None = '无'
L.SORT = '整理全部'
L.SORT_BAG = '整理背包'
L.SORT_BAG_ASC = '顺序整理背包'
L.SORT_BAG_DESC = '逆序整理背包'
L.SORT_BANK = '整理银行'
L.SORT_BANK_ASC = '顺序整理银行'
L.SORT_BANK_DESC = '逆序整理银行'
L.OPEN_OPTIONS = '打开设置'

-- for rules
L.KEYWORD_MOUNT = '使用： 召唤或解散'
L.KEYWORD_FOOD = '进食时必须保持坐姿'
L.KEYWORD_WATER = '喝水时必须保持坐姿'
L.KEYWORD_CLASS = '职业：'
L.KEYWORD_CONJURED_ITEM = '魔法制造的物品'
