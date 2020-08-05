-- @Author: jow
-- @Date:   2020/8/5 10:03
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class ModalWaitingView:BaseUi
local ModalWaitingView = class("ModalWaitingView", super)

local module = App.modalWaitingModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
ModalWaitingView.uiConfig = LuaClass.UiConstant.ModalWaiting

function ModalWaitingView:init()
end

function ModalWaitingView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function ModalWaitingView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function ModalWaitingView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function ModalWaitingView:closeView()
    module:closeView()
end

function ModalWaitingView:onExit()
    self:unRegisterEvent()
end

function ModalWaitingView:dispose()
    super.dispose(self)
end

return ModalWaitingView
