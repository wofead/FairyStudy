-- @Author: jow
-- @Date:   2020/8/5 10:11
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class TurnCardView:BaseUi
local TurnCardView = class("TurnCardView", super)

local module = App.turnCardModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
TurnCardView.uiConfig = LuaClass.UiConstant.TurnCard

function TurnCardView:init()
end

function TurnCardView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function TurnCardView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function TurnCardView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function TurnCardView:closeView()
    module:closeView()
end

function TurnCardView:onExit()
    self:unRegisterEvent()
end

function TurnCardView:dispose()
    super.dispose(self)
end

return TurnCardView
