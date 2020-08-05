---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class CutSceneView:BaseUi
local CutSceneView = class("CutSceneView", super)

local module = App.cutSceneModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
CutSceneView.uiConfig = LuaClass.UiConstant.CutScene

function CutSceneView:init()
end

function CutSceneView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function CutSceneView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function CutSceneView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function CutSceneView:closeView()
    module:closeView()
end

function CutSceneView:onExit()
    self:unRegisterEvent()
end

function CutSceneView:dispose()
    super.dispose(self)
end

return CutSceneView