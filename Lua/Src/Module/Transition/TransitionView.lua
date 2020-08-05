-- @Author: jow
-- @Date:   2020/8/5 10:12
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class TransitionView:BaseUi
local TransitionView = class("TransitionView", super)

local module = App.transitionModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
TransitionView.uiConfig = LuaClass.UiConstant.Transition

function TransitionView:init()
end

function TransitionView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function TransitionView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function TransitionView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function TransitionView:closeView()
    module:closeView()
end

function TransitionView:onExit()
    self:unRegisterEvent()
end

function TransitionView:dispose()
    super.dispose(self)
end

return TransitionView
