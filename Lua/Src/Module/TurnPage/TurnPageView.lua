-- @Author: jow
-- @Date:   2020/8/5 10:11
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class TurnPageView:BaseUi
local TurnPageView = class("TurnPageView", super)

local module = App.turnPageModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
TurnPageView.uiConfig = LuaClass.UiConstant.TurnPage

function TurnPageView:init()
end

function TurnPageView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function TurnPageView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function TurnPageView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function TurnPageView:closeView()
    module:closeView()
end

function TurnPageView:onExit()
    self:unRegisterEvent()
end

function TurnPageView:dispose()
    super.dispose(self)
end

return TurnPageView
