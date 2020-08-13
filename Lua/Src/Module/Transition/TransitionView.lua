-- @Author: jow
-- @Date:   2020/8/5 10:12
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class TransitionView:BaseUi
local TransitionView = class("TransitionView", super)

local module = App.transitionModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
TransitionView.uiConfig = LuaClass.UiConstant.Transition

function TransitionView:init()
    ---@type FairyGUI.GGroup
    local group = self.ui.g0
    self.group = group
    ---@type FairyGUI.GComponent
    self.g1 = LuaClass.GuiUIPackage.CreateObject("Transition", "BOSS")
    ---@type FairyGUI.GComponent
    self.g2 = LuaClass.GuiUIPackage.CreateObject("Transition", "BOSS_SKILL")
    ---@type FairyGUI.GComponent
    self.g3 = LuaClass.GuiUIPackage.CreateObject("Transition", "TRAP")
    ---@type FairyGUI.GComponent
    self.g4 = LuaClass.GuiUIPackage.CreateObject("Transition", "GoodHit")
    ---@type FairyGUI.GComponent
    self.g5 = LuaClass.GuiUIPackage.CreateObject("Transition", "PowerUp")
    self.g5:GetTransition("t0"):SetHook("play_num_now", handler(self, self.playNum))
    ---@type FairyGUI.GComponent
    self.g6 = LuaClass.GuiUIPackage.CreateObject("Transition", "PathDemo")
end

function TransitionView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function TransitionView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
    registerEventFunc(ui.btn0, eventType.Click, function()
        self:play(self.g1)
    end)
    registerEventFunc(ui.btn1, eventType.Click, function()
        self:play(self.g2)
    end)
    registerEventFunc(ui.btn2, eventType.Click, function()
        self:play(self.g3)
    end)
    registerEventFunc(ui.btn3, eventType.Click, handler(self, self.play4))
    registerEventFunc(ui.btn4, eventType.Click, handler(self, self.play5))
    registerEventFunc(ui.btn5, eventType.Click, function()
        self:play(self.g6)
    end)
end

---@param component FairyGUI.GComponent
function TransitionView:play(component)
    self.group.visible = false
    LuaClass.GuiGRoot.inst:AddChild(component)
    local t = component:GetTransition("t0")
    t:Play(1, 0, function()
        self.group.visible = true
        LuaClass.GuiGRoot.inst:RemoveChild(component)
    end)
end

function TransitionView:play4()
    ---@type FairyGUI.GComponent
    local component = self.g4
    self.group.visible = false
    component.x = LuaClass.GuiGRoot.inst.width - component.width - 20
    component.y = 100
    LuaClass.GuiGRoot.inst:AddChild(component)
    local t = component:GetTransition("t0")
    t:Play(3, 0, function()
        self.group.visible = true
        LuaClass.GuiGRoot.inst:RemoveChild(component)
    end)
end

function TransitionView:play5()
    ---@type FairyGUI.GComponent
    local component = self.g5
    self.group.visible = false
    component.x = 20
    component.y = LuaClass.GuiGRoot.inst.height - component.height - 100
    LuaClass.GuiGRoot.inst:AddChild(component)
    self.startValue = 10000
    local add = math.random(1000, 3000)
    self.endValue = self.startValue + add
    component:GetChild("value").text = "" .. self.startValue
    component:GetChild("add_value").text = "" .. add
    local t = component:GetTransition("t0")
    t:Play(function()
        self.group.visible = true
        LuaClass.GuiGRoot.inst:RemoveChild(component)
    end)
end

function TransitionView:playNum()
    LuaClass.GuiGTween.To(self.startValue, self.endValue, 0.3):SetEase(LuaClass.EaseType.Linear):OnUpdate(function(tweener)
        self.g5:GetChild("value").text = "" .. tweener.value.x
    end)
end

function TransitionView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function TransitionView:closeView()
    module:closeView()
end

function TransitionView:onExit()
    self:unRegisterEvent()
end

function TransitionView:dispose()
    super.dispose(self)
end

return TransitionView
