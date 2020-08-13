-- @Author: jow
-- @Date:   2020/8/13 18:22
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseLuaComponent
---@class CardItemView:BaseLuaComponent
local CardItemView = class("CardItemView", super)

---@param btn FairyGUI.GButton
function CardItemView:ctor(gameObject, btn)
    super.ctor(self, gameObject)
    self.btn = btn
    ---@type FairyGUI.GObject
    self.back = btn:GetChild("n0")
    ---@type FairyGUI.GObject
    self.front = btn:GetChild("icon")
    self.front.visible = false
end

function CardItemView:opened()
    return self.front.visible
end

function CardItemView:setOpened(value)
    LuaClass.GuiGTween.Kill(self.btn)
    self.front.visible = value
    self.back.visible = not value
end

function CardItemView:setPerspective()
    self.front.displayObject.perspective = true
    self.back.displayObject.perspective = true
end

function CardItemView:turn()
    if LuaClass.GuiGTween.IsTweening(self.btn) then
        return
    end
    local toOpen = not self.front.visible
    LuaClass.GuiGTween.To(0, 180, 0.8):SetTarget(self.btn):SetEase(LuaClass.EaseType.QuadOut):OnUpdate(
            handler(self, self.turnInTween)
    ):SetUserData(toOpen)
end

function CardItemView:turnInTween(tweener)
    local toOpen = tweener.userData
    local v = tweener.value.x
    if toOpen then
        self.back.rotationY = v
        self.front.rotationY = -180 + v
        if v > 90 then
            self.front.visible = true
            self.back.visible = false
        end
    else
        self.back.rotationY = -180 + v
        self.front.rotationY = v
        if v > 90 then
            self.front.visible = false
            self.back.visible = true
        end
    end
end
return CardItemView
