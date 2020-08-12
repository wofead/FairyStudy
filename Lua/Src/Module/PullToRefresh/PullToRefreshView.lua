-- @Author: jow
-- @Date:   2020/8/5 10:06
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class PullToRefreshView:BaseUi
local PullToRefreshView = class("PullToRefreshView", super)

local module = App.pullToRefreshModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
PullToRefreshView.uiConfig = LuaClass.UiConstant.PullToRefresh

function PullToRefreshView:init()
    ---@type FairyGUI.GList
    local list1 = self.ui.list1
    list1.itemRenderer = handler(self, self.renderItemList1)
    list1:SetVirtual()
    list1.numItems = 1
    list1.scrollPane.onPullDownRelease:Add(handler(self, self.onPullDownToRefresh))
    self.list1 = list1

    ---@type FairyGUI.GList
    local list2 = self.ui.list2
    list2.itemRenderer = handler(self, self.renderItemList2)
    list2:SetVirtual()
    list2.numItems = 1
    list2.scrollPane.onPullDownRelease:Add(handler(self, self.onPullUpToRefresh))
    self.list2 = list2
end

function PullToRefreshView:renderItemList1(index, obj)
    obj.title = "Item " .. (self.list1.numItems - index - 1)
end

function PullToRefreshView:renderItemList2(index, obj)
    obj.title = "Item " .. index
end

function PullToRefreshView:onPullDownToRefresh()
    local header = self.list1.scrollPane.header
    if header.ReadyToRefresh then
        header:SetRefreshStatus(2)
        self.list1.scrollPane:LockHeader(header.sourceHeight)
        self.timer1 = App.timeManager:add(2000, function()
        end, 2000, function()

        end)
    end
end

function PullToRefreshView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function PullToRefreshView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function PullToRefreshView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function PullToRefreshView:closeView()
    module:closeView()
end

function PullToRefreshView:onExit()
    self:unRegisterEvent()
end

function PullToRefreshView:dispose()
    super.dispose(self)
end

return PullToRefreshView
