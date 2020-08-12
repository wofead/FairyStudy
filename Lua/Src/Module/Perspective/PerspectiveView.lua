-- @Author: jow
-- @Date:   2020/8/5 10:06
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class PerspectiveView:BaseUi
local PerspectiveView = class("PerspectiveView", super)

local module = App.perspectiveModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
PerspectiveView.uiConfig = LuaClass.UiConstant.Perspective

function PerspectiveView:init()
    ---@type FairyGUI.GComponent
    local uiPanel1 = LuaClass.GuiUIPackage.CreateObject("Perspective", "Panel")
    ---@type FairyGUI.GComponent
    local uiPanel2 = LuaClass.GuiUIPackage.CreateObject("Perspective", "Panel2")
    ---@type FairyGUI.GList
    local list = uiPanel2:GetChild("mailList")
    list:SetVirtual()
    list.itemRenderer = function(index, obj)
        obj.text = index .. "Mail title here"
    end
    list.numItems = 20
    self.view:AddChild(uiPanel1)
    self.view:AddChild(uiPanel2)
    uiPanel2.container.gameObject.transform.localPosition = LuaClass.Vector3(140, 9, 313)
    --uiPanel2.container.gameObject.transform.localRotation = LuaClass.Vector3(0, -40, 0)
    uiPanel1.container.gameObject.transform.localPosition = LuaClass.Vector3(340, 4.8, 313)
    --uiPanel1.container.gameObject.transform.localRotation = LuaClass.Vector3(0, 40, 0)
    --uiPanel2.container.gameObject.layer = "Default"
    --uiPanel1.container.gameObject.layer = "Default"
end

function PerspectiveView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function PerspectiveView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function PerspectiveView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function PerspectiveView:closeView()
    module:closeView()
end

function PerspectiveView:onExit()
    self:unRegisterEvent()
end

function PerspectiveView:dispose()
    super.dispose(self)
end

return PerspectiveView
