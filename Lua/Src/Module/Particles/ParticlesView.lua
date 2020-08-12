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
    local prefab = LuaClass.Resources.Load("npc")
    ---@type UnityEngine.GameObject
    local go = LuaClass.Object.Instantiate(prefab)
    go.transform.localPosition = LuaClass.Vector3(61, -89, 1000)
    go.transform.localScale = LuaClass.Vector3(180, 180, 180)
    go.transform.localEulerAngles = LuaClass.Vector3(0, 100, 1000)
    self.ui.holder:SetNativeObject(LuaClass.GuiGoWrapper(go))
    self.ui.c0.draggable = true
    self.ui.c1.draggable = true
    go = LuaClass.Object.Instantiate(prefab)
    go.transform.localPosition = LuaClass.Vector3(61, -89, 1000)
    go.transform.localScale = LuaClass.Vector3(180, 180, 180)
    go.transform.localEulerAngles = LuaClass.Vector3(0, 100, 1000)
    self.ui.c0:GetChild("effect"):SetNativeObject(LuaClass.GuiGoWrapper(go))
    go = LuaClass.Object.Instantiate(prefab)
    go.transform.localPosition = LuaClass.Vector3(61, -89, 1000)
    go.transform.localScale = LuaClass.Vector3(180, 180, 180)
    go.transform.localEulerAngles = LuaClass.Vector3(0, 100, 1000)
    self.ui.c1:GetChild("effect"):SetNativeObject(LuaClass.GuiGoWrapper(go))
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
