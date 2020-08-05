---Author：  houn
---DATE：    2020/8/5
---DES:

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class CoolDownView:BaseUi
local CoolDownView = class("CoolDownView", super)

local module = App.coolDownModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
CoolDownView.uiConfig = LuaClass.UiConstant.CoolDown

function CoolDownView:init()
end

function CoolDownView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function CoolDownView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function CoolDownView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function CoolDownView:closeView()
    module:closeView()
end

function CoolDownView:onExit()
    self:unRegisterEvent()
end

function CoolDownView:dispose()
    super.dispose(self)
end


return CoolDownView