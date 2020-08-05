-- @Author: jow
-- @Date:   2020/8/5 10:06
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class PerspectiveView:BaseUi
local PerspectiveView = class("PerspectiveView", super)

local module = App.perspectiveModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
PerspectiveView.uiConfig = LuaClass.UiConstant.Perspective

function PerspectiveView:init()
end

function PerspectiveView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function PerspectiveView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function PerspectiveView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function PerspectiveView:closeView()
    module:closeView()
end

function PerspectiveView:onExit()
    self:unRegisterEvent()
end

function PerspectiveView:dispose()
    super.dispose(self)
end

return PerspectiveView
