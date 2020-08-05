---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class BundleUsageView:BaseUi
local BundleUsageView = class("BundleUsageView", super)

local module = App.bundleUsageModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
BundleUsageView.uiConfig = LuaClass.UiConstant.BundleUsage

function BundleUsageView:init()
end

function BundleUsageView:onEnter()
    self.view:GetTransition("t0"):Play()
    super.onEnter(self)
    self:registerEvent()
end

function BundleUsageView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function BundleUsageView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function BundleUsageView:closeView()
    module:closeView()
end

function BundleUsageView:onExit()
    self:unRegisterEvent()
end

function BundleUsageView:dispose()
    super.dispose(self)
end

return BundleUsageView