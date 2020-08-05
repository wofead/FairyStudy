-- @Author: jow
-- @Date:   2020/8/5 10:04
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class ModelView:BaseUi
local ModelView = class("ModelView", super)

local module = App.modelModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
ModelView.uiConfig = LuaClass.UiConstant.Model

function ModelView:init()
end

function ModelView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function ModelView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function ModelView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function ModelView:closeView()
    module:closeView()
end

function ModelView:onExit()
    self:unRegisterEvent()
end

function ModelView:dispose()
    super.dispose(self)
end

return ModelView
