-- @Author: jow
-- @Date:   2020/8/5 10:10
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class VirtualListView:BaseUi
local VirtualListView = class("VirtualListView", super)

local module = App.virtualListModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
VirtualListView.uiConfig = LuaClass.UiConstant.VirtualList

function VirtualListView:init()
    self.uiList = LuaClass.UiList.AddToGuiList(self.ui.mailList, LuaClass.MailItemView)
    local dataList = {}
    for i = 1, 1000 do
        table.insert(dataList, i)
    end
    self.uiList:setDataSource(dataList)
end

function VirtualListView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function VirtualListView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
    registerEventFunc(ui.n6, eventType.Click, function()
        self.uiList.guiList:AddSelection(500, true)
    end)
    registerEventFunc(ui.n7, eventType.Click, function()
        self.uiList.guiList.scrollPane:ScrollTop()
    end)
    registerEventFunc(ui.n8, eventType.Click, function()
        self.uiList.guiList.scrollPane:ScrollBottom()
    end)
end

function VirtualListView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function VirtualListView:closeView()
    module:closeView()
end

function VirtualListView:onExit()
    self:unRegisterEvent()
end

function VirtualListView:dispose()
    super.dispose(self)
end

return VirtualListView
