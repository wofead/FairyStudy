-- @Author: jow
-- @Date:   2020/8/5 9:57
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class GuideView:BaseUi
local GuideView = class("GuideView", super)

local module = App.guideModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
GuideView.uiConfig = LuaClass.UiConstant.Guide

function GuideView:init()
    ---@type FairyGUI.GComponent
    local guideLayer = LuaClass.GuiUIPackage.CreateObject("Guide", "GuideLayer")
    guideLayer:SetSize(LuaClass.GuiGRoot.inst.width, LuaClass.GuiGRoot.inst.height)
    guideLayer:AddRelation(LuaClass.GuiGRoot.inst, LuaClass.GuiRelationType.Size)
    self.guideLayer = guideLayer
    ---@type FairyGUI.GButton
    self.bagBtn = self.ui.bagBtn
end

function GuideView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function GuideView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))

    registerEventFunc(ui.bagBtn, eventType.Click, handler(self, self.onBagBtn))
    registerEventFunc(ui.n2, eventType.Click, handler(self, self.onGuideBtn))
end

function GuideView:onBagBtn()
    self.guideLayer:RemoveFromParent()
end

function GuideView:onGuideBtn()
    LuaClass.GuiGRoot.inst:AddChild(self.guideLayer)
    local rect = self.bagBtn:TransformRect(LuaClass.Rect(0, 0, self.bagBtn.width, self.bagBtn.height), self.guideLayer)
    ---@type FairyGUI.GObject
    local window = self.guideLayer:GetChild("window")
    window.size = LuaClass.Vector2(rect.size.x, rect.size.y)
    window:TweenMove(LuaClass.Vector2(rect.position.x, rect.position.y),0.5)
end

function GuideView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function GuideView:closeView()
    module:closeView()
end

function GuideView:onExit()
    self:unRegisterEvent()
end

function GuideView:dispose()
    super.dispose(self)
end

return GuideView
