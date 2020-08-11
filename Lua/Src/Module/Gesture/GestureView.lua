-- @Author: jow
-- @Date:   2020/8/5 9:49
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class GestureView:BaseUi
local GestureView = class("GestureView", super)

local module = App.gestureModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
GestureView.uiConfig = LuaClass.UiConstant.Gesture

function GestureView:init()
    local holder = self.ui.holder
    self.ball = LuaClass.GameObject.Find("globe").transform
    self.gesture1 = LuaClass.GuiSwipeGesture(holder)
    self.gesture2 = LuaClass.GuiLongPressGesture(holder)
    self.gesture3 = LuaClass.GuiPinchGesture(holder)
    self.gesture4 = LuaClass.GuiRotationGesture(holder)

end

function GestureView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function GestureView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
    registerEventFunc(self.gesture1, eventType.Move, handler(self, self.OnSwipeMove))
    registerEventFunc(self.gesture1, eventType.End, handler(self, self.OnSwipeEnd))
    registerEventFunc(self.gesture2, eventType.Action, handler(self, self.OnHold))
    registerEventFunc(self.gesture3, eventType.Action, handler(self, self.OnPinch))
    registerEventFunc(self.gesture4, eventType.Action, handler(self, self.OnRotate))
end

---@param context FairyGUI.EventContext
function GestureView:OnSwipeMove(context)
    ---@type FairyGUI.SwipeGesture
    local gesture = context.sender
    local v = LuaClass.Vector3()
    if math.abs(gesture.delta.x) > math.abs(gesture.delta.y) then
        v.y = v.y - math.round(gesture.delta.x)
        if math.abs(v.y) < 2 then
            return
        end
    else
        v.x = v.x - math.round(gesture.delta.y)
        if math.abs(v.x) < 2 then
            return
        end
    end
    self.ball:Rotate(v, LuaClass.Space.World)
end

---@param context FairyGUI.EventContext
function GestureView:OnSwipeEnd(context)
    ---@type FairyGUI.SwipeGesture
    local gesture = context.sender
    local v = LuaClass.Vector3()
    if math.abs(gesture.velocity.x) > math.abs(gesture.velocity.y) then
        v.y = v.y - math.round(LuaClass.Mathf.Sign(gesture.velocity.x) * math.sqrt(math.abs(gesture.velocity.x)))
        if math.abs(v.y) < 2 then
            return
        end
    else
        v.x = v.x - math.round(LuaClass.Mathf.Sign(gesture.velocity.y) * math.sqrt(math.abs(gesture.velocity.y)))
        if math.abs(v.x) < 2 then
            return
        end
    end
    LuaClass.GuiGTween.To(v, LuaClass.Vector3.zero, 0.3):SetTarget(self.ball):OnUpdate(
            function(tweener)
                self.ball:Rotate(tweener.deltaValue.vec3, LuaClass.Space.World)
            end)
end

---@param context FairyGUI.EventContext
function GestureView:OnHold(context)
    LuaClass.GuiGTween.Shake(self.ball.transform.localPosition, 0.05, 0.5):SetTarget(self.ball):OnUpdate(
            function(tweener)
                self.ball.transform.localPosition = LuaClass.Vector3(tweener.value.x, tweener.value.y, self.ball.transform.localPosition.z)
            end)
end

---@param context FairyGUI.EventContext
function GestureView:OnPinch(context)
    LuaClass.GuiGTween.Kill(self.ball)
    ---@type FairyGUI.PinchGesture
    local gesture = context.sender
    local value = LuaClass.Mathf.Clamp(self.ball.localScale.x + gesture.delta, 0.3, 2)
    self.ball.localScale = LuaClass.Vector3(value, value, value)
end

---@param context FairyGUI.EventContext
function GestureView:OnRotate(context)
    LuaClass.GuiGTween.Kill(self.ball)
    ---@type FairyGUI.RotationGesture
    local gesture = context.sender
    self.ball:Rotate(LuaClass.Vector3.forward, -gesture.delta, LuaClass.Space.World)
end

function GestureView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function GestureView:closeView()
    module:closeView()
end

function GestureView:onExit()
    self:unRegisterEvent()
end

function GestureView:dispose()
    super.dispose(self)
end

return GestureView
