---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class ExtensionView:BaseUi
local ExtensionView = class("ExtensionView", super)

local module = App.extensionModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
ExtensionView.uiConfig = LuaClass.UiConstant.Extension

function ExtensionView:init()
    LuaClass.GuiUIObjectFactory.SetExtension("ui://Extension/mailItem", typeof(LuaClass.GuiGButton), LuaClass.MailItemView)
    ---@type FairyGUI.GList
    local list = self.ui.mailList
    list.itemRenderer = handler(self, self.itemRenderer)
    list:EnsureBoundsCorrect()
    list.numItems = 10
end

---@param item FairyGUI.GComponent
function ExtensionView:itemRenderer(index, item)
    --local view = item.luaTable.view
    --view.title = "Mail title here"
    --view:GetChild("timeText").text = "5 Nov 2015 16:24:33"
    --view:GetController("IsRead").selectedIndex = index % 3 == 1 and 1 or 0
    --view:GetController("c1").selectedIndex = index % 2 == 1 and 1 or 0
    --view.visible = false
    --view:GetTransition("t0"):Play(1, index * 0.2, nil)
    item.title = "Mail title here"
    item:GetChild("timeText").text = "5 Nov 2015 16:24:33"
    item:GetController("IsRead").selectedIndex = index % 3 == 1 and 1 or 0
    item:GetController("c1").selectedIndex = index % 2 == 1 and 1 or 0
    item.visible = false
    item:GetTransition("t0"):Play(1, index * 0.2, nil)
end

function ExtensionView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function ExtensionView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function ExtensionView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function ExtensionView:closeView()
    module:closeView()
end

function ExtensionView:onExit()
    self:unRegisterEvent()
end

function ExtensionView:dispose()
    super.dispose(self)
end

return ExtensionView