---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class CurveView:BaseUi
local CurveView = class("CurveView", super)

local module = App.curveModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
CurveView.uiConfig = LuaClass.UiConstant.Curve

function CurveView:init()
    local list = self.ui.list
    list:SetVirtualAndLoop()
    list.itemRenderer = handler(self, self.itemRenderer)
    list.numItems = 5
    list.scrollPane.onScroll:Add(handler(self, self.itemEffect))
    self:itemEffect()
end

function CurveView:itemRenderer(index, obj)
    obj:SetPivot(0.5, 0.5)
    obj.icon = LuaClass.GuiUIPackage.GetItemURL("Curve", "n" + (index + 1))
end

function CurveView:itemEffect()
    local list = self.ui.list
    --change the scale according to the distance to middle
    local midX = list.scrollPane.posX + list.viewWidth / 2
    local cnt = list.numChildren
    for i = 1, cnt do
        local obj = list:GetChildAt(i - 1)
        local dist = math.abs(midX - obj.x - obj.width / 2)
        if dist > obj.width then
            obj:SetScale(1, 1)
        else
            local s = 1 + (1 - dist / obj.width) * 0.24
            obj:SetScale(s, s)
        end
    end
end

function CurveView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function CurveView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function CurveView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function CurveView:closeView()
    module:closeView()
end

function CurveView:onExit()
    self:unRegisterEvent()
end

function CurveView:dispose()
    super.dispose(self)
end

return CurveView