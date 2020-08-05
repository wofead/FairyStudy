-- @Author: jow
-- @Date:   2020/8/5 10:05
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class ParticlesView:BaseUi
local ParticlesView = class("ParticlesView", super)

local module = App.particlesModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
ParticlesView.uiConfig = LuaClass.UiConstant.Particles

function ParticlesView:init()
end

function ParticlesView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function ParticlesView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function ParticlesView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function ParticlesView:closeView()
    module:closeView()
end

function ParticlesView:onExit()
    self:unRegisterEvent()
end

function ParticlesView:dispose()
    super.dispose(self)
end

return ParticlesView
