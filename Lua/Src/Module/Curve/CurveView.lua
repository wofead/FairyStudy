---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class CurveView:BaseUi
local CurveView = class("CurveView", super)

local module = App.curveModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
CurveView.uiConfig = LuaClass.UiConstant.Curve

function CurveView:init()
end

function CurveView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function CurveView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function CurveView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function CurveView:closeView()
    module:closeView()
end

function CurveView:onExit()
    self:unRegisterEvent()
end

function CurveView:dispose()
    super.dispose(self)
end

return CurveView