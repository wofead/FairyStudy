-- @Author: jow
-- @Date:   2020/8/5 10:02
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class LoopListView:BaseUi
local LoopListView = class("LoopListView", super)

local module = App.loopListModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
LoopListView.uiConfig = LuaClass.UiConstant.LoopList

function LoopListView:init()
end

function LoopListView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function LoopListView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function LoopListView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function LoopListView:closeView()
    module:closeView()
end

function LoopListView:onExit()
    self:unRegisterEvent()
end

function LoopListView:dispose()
    super.dispose(self)
end

return LoopListView
