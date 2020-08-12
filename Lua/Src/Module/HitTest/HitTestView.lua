-- @Author: jow
-- @Date:   2020/8/5 9:59
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class HitTestView:BaseUi
local HitTestView = class("HitTestView", super)

local module = App.hitTestModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
HitTestView.uiConfig = LuaClass.UiConstant.HitTest

function HitTestView:init()

    self.cube = LuaClass.GameObject.Find("Cube").transform

end

function HitTestView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function HitTestView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))

    LuaClass.GuiStage.inst.onTouchBegin:Add(handler(self, self.onTouchBegin))
end

function HitTestView:onTouchBegin()
    if not LuaClass.GuiStage.isTouchOnUI then
        --LuaClass.RaycastHit
        local hit LuaClass.RaycastHit()
        local ray = LuaClass.Camera.main:ScreenPointToRay(LuaClass.Vector3(LuaClass.GuiStage.inst.touchPosition.x, LuaClass.Screen.height - LuaClass.GuiStage.inst.touchPosition.y, 0))
        if LuaClass.Physics.Raycast(ray) then
            --if hit.transform == self.cube then
                printJow("HitTestView", "Hit the cube")
            --end
        end
    end
end

function HitTestView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function HitTestView:closeView()
    module:closeView()
end

function HitTestView:onExit()
    self:unRegisterEvent()
end

function HitTestView:dispose()
    super.dispose(self)
end

return HitTestView