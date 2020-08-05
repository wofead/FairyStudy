-- @Author: jow
-- @Date:   2020/8/5 9:49
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class GestureView:BaseUi
local GestureView = class("GestureView", super)


local module = App.gestureModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
GestureView.uiConfig = LuaClass.UiConstant.Gesture

function GestureView:init()
end

function GestureView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function GestureView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function GestureView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function GestureView:closeView()
    module:closeView()
end

function GestureView:onExit()
    self:unRegisterEvent()
end

function GestureView:dispose()
    super.dispose(self)
end


return GestureView
