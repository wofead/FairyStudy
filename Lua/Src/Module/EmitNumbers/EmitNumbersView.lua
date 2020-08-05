---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class EmitNumbersView:BaseUi
local EmitNumbersView = class("EmitNumbersView", super)

local module = App.emitNumbersModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
EmitNumbersView.uiConfig = LuaClass.UiConstant.EmitNumbers

function EmitNumbersView:init()
end

function EmitNumbersView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function EmitNumbersView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function EmitNumbersView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function EmitNumbersView:closeView()
    module:closeView()
end

function EmitNumbersView:onExit()
    self:unRegisterEvent()
end

function EmitNumbersView:dispose()
    super.dispose(self)
end

return EmitNumbersView