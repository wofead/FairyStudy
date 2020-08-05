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