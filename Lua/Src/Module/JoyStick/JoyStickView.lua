-- @Author: jow
-- @Date:   2020/8/5 9:59
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class JoyStickView:BaseUi
local JoyStickView = class("JoyStickView", super)

local module = App.joyStickModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
JoyStickView.uiConfig = LuaClass.UiConstant.JoyStick

function JoyStickView:init()
    self.degreeTxt = self.ui.n9
    ---@type FairyGUI.GButton
    self.button = self.ui.joystick
    self.button.changeStateOnClick = false
    self.thumb = self.button:GetChild("thumb")
    self.touchArea = self.ui.joystick_touch
    self.center = self.ui.joystick_center
    self.initX = self.center.x + self.center.width / 2
    self.initY = self.center.y + self.center.height / 2

    self.touchId = -1
    self.radius = 150
end

function JoyStickView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function JoyStickView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))

    registerEventFunc(self.touchArea, eventType.TouchBegin, handler(self, self.onTouchBegin))
    registerEventFunc(self.touchArea, eventType.TouchMove, handler(self, self.onTouchMove))
    registerEventFunc(self.touchArea, eventType.TouchEnd, handler(self, self.onTouchEnd))
end

---@param context FairyGUI.EventContext
function JoyStickView:onTouchBegin(context)
    if self.touchId == -1 then
        ---@type FairyGUI.InputEvent
        local evt = context.data
        self.touchId = evt.touchId

        if self.tweener then
            self.tweener:Kill()
            self.tweener = nil
        end
        local pt = LuaClass.GuiGRoot.inst:GlobalToLocal(LuaClass.Vector2(evt.x, evt.y))
        local bx = pt.x
        local by = pt.y
        self.button.selected = true

        if bx < 0 then
            bx = 0
        elseif bx > self.touchArea.width then
            bx = self.touchArea.width
        end
        if by < self.touchArea.height then
            by = self.touchArea.height
        elseif by > LuaClass.GuiGRoot.inst.height then
            by = LuaClass.GuiGRoot.inst.height
        end
        self.lastStageX = bx
        self.lastStageY = by
        self.startStageX = bx
        self.startStageY = by

        self.center.visible = true

        self.center:SetXY(bx - self.center.width / 2, by - self.center.height / 2)
        self.button:SetXY(bx - self.button.width / 2, by - self.button.height / 2)

        local deltaX = bx - self.initX
        local deltaY = by - self.initY

        local degree = math.atan2(deltaY, deltaX) * 180 / math.pi
        self.thumb.rotation = degree + 90
        context:CaptureTouch()

    end
end

---@param context FairyGUI.EventContext
function JoyStickView:onTouchMove(context)
    ---@type FairyGUI.InputEvent
    local evt = context.data
    if self.touchId ~= -1 and evt.touchId == self.touchId then
        local pt = LuaClass.GuiGRoot.inst:GlobalToLocal(LuaClass.Vector2(evt.x, evt.y))
        local bx = pt.x
        local by = pt.y
        local moveX = bx - self.lastStageX
        local moveY = by - self.lastStageY
        self.lastStageX = bx
        self.lastStageY = by
        local buttonX = self.button.x + moveX
        local buttonY = self.button.y + moveY

        local offsetX = buttonX + self.button.width / 2 - self.startStageX
        local offsetY = buttonY + self.button.height / 2 - self.startStageY

        local rad = math.atan2(offsetY, offsetX)
        local degree = rad * 180 / math.pi
        self.thumb.rotation = degree + 90

        local maxX = self.radius * math.cos(rad)
        local maxY = self.radius * math.sin(rad)
        if math.abs(offsetX) > math.abs(maxX) then
            offsetX = maxX
        end
        if math.abs(offsetY) > math.abs(maxY) then
            offsetY = maxY
        end

        buttonX = self.startStageX + offsetX
        buttonY = self.startStageY + offsetY

        if buttonX < 0 then
            buttonX = 0
        end
        if buttonY > LuaClass.GuiGRoot.inst.height then
            buttonY = LuaClass.GuiGRoot.inst.height
        end

        self.button:SetXY(buttonX - self.button.width / 2, buttonY - self.button.height / 2)
        self.degreeTxt.text = degree .. ""
    end
end

---@param context FairyGUI.EventContext
function JoyStickView:onTouchEnd(context)
    ---@type FairyGUI.InputEvent
    local evt = context.data
    if self.touchId ~= -1 and evt.touchId == self.touchId then
        self.touchId = -1
        self.thumb.rotation = self.thumb.rotation + 180
        self.center.visible = false
        self.tweener = self.button:TweenMove(LuaClass.Vector2(self.initX - self.button.width / 2, self.initY - self.button.height / 2), 0.3):OnComplete(
                function()
                    self.tweener = nil
                    self.button.selected = false
                    self.thumb.rotation = 0
                    self.center.visible = true
                    self.center:SetXY(self.initX - self.center.width / 2, self.initY - self.center.height / 2)
                end)
        self.degreeTxt.text = ""
    end
end

function JoyStickView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function JoyStickView:closeView()
    module:closeView()
end

function JoyStickView:onExit()
    self:unRegisterEvent()
end

function JoyStickView:dispose()
    super.dispose(self)
end

return JoyStickView
