-- @Author: jow
-- @Date:   2020/8/5 9:59
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class JoyStickView:BaseUi
local JoyStickView = class("JoyStickView", super)

local module = App.joyStickModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
JoyStickView.uiConfig = LuaClass.UiConstant.JoyStick

function JoyStickView:init()
end

function JoyStickView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function JoyStickView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function JoyStickView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function JoyStickView:closeView()
    module:closeView()
end

function JoyStickView:onExit()
    self:unRegisterEvent()
end

function JoyStickView:dispose()
    super.dispose(self)
end

return JoyStickView
