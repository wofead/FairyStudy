-- @Author: jow
-- @Date:   2020/8/7 16:18
-- @Des:    
local LuaClass = LuaClass
local super = nil
---@class EmitComponent
local EmitComponent = class("EmitComponent", super)

EmitComponent.hurtFont1 = "ui://EmitNumbers/number1"
EmitComponent.hurtFont2 = "ui://EmitNumbers/number2"
EmitComponent.criticalSign = "ui://EmitNumbers/critical"
EmitComponent.offset = 2.2

function EmitComponent:ctor()
    self:init()
end

function EmitComponent:init()
    ---@type FairyGUI.GComponent
    self.component = LuaClass.GuiGComponent()
    self.component.touchable = false
    ---@type FairyGUI.GLoader
    self.symbolLoader = LuaClass.GuiGLoader()
    self.symbolLoader.autoSize = true
    self.component:AddChild(self.symbolLoader)
    ---@type FairyGUI.GTextField
    self.numText = LuaClass.GuiGTextField()
    self.numText.autoSize = LuaClass.AutoSizeType.Both
    self.component:AddChild(self.numText)
end

---@param owner UnityEngine.GameObject
function EmitComponent:onHpChange(owner, type, value, critic)
    self.owner = owner
    local tf = self.numText.textFormat
    if type == 1 then
        tf.font = EmitComponent.hurtFont1
    else
        tf.font = EmitComponent.hurtFont2
    end
    self.numText.textFormat = tf
    self.numText.text = "-" .. value
    if critic then
        self.symbolLoader.url = EmitComponent.criticalSign
    else
        self.symbolLoader.url = ""
    end
    self:updateLayout()
    self.component.alpha = 1
    local toX = math.random(0, 80) * 2
    local toY = math.random(0, 80) * 2
    LuaClass.GuiGTween.To(LuaClass.Vector2.zero, LuaClass.Vector2(toX, toY), 1):SetTarget(self.component):OnUpdate(function(tweener)
        self:updatePos(tweener.value.vec2)
    end)    :OnComplete(function()
        self:onComplete()
    end)
    self.component:TweenFade(0, 0.5):SetDelay(0.5)
end

function EmitComponent:updateLayout()
    self.component:SetSize(self.symbolLoader.width + self.numText.width, math.max(self.symbolLoader.height, self.numText.height))
    self.numText:SetXY(self.symbolLoader.width > 0 and self.symbolLoader.width + 2 or 0, (self.component.height - self.numText.height) / 2)
    self.symbolLoader.y = (self.component.height - self.symbolLoader.height) / 2
end

---@param vec2 UnityEngine.Vector2
function EmitComponent:updatePos(pos)
    local ownerPos = self.owner.position
    ownerPos.y = ownerPos.y + EmitComponent.offset
    local screenPos = LuaClass.Camera.main:WorldToScreenPoint(ownerPos)
    screenPos.y = LuaClass.Screen.height - screenPos.y
    local pt = LuaClass.GuiGRoot.inst:GlobalToLocal(LuaClass.Vector2(screenPos.x, screenPos.y))
    self.component:SetXY(pt.x + pos.x - self.component.actualWidth / 2, pt.y + pos.y - self.component.actualHeight / 2)
end

function EmitComponent:onComplete()
    self.owner = nil
    self.component.visible = false
    App.poolManager:pushComponent(self)
    if self.component.parent then
        LuaClass.GuiGTween.Kill(self.component)
    end
end

return EmitComponent
