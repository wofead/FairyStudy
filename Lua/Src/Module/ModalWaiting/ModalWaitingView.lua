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
    LuaClass.GuiUIConfig.globalModalWaiting = "ui://ModalWaiting/GlobalModalWaiting"
    LuaClass.GuiUIConfig.windowModalWaiting = "ui://ModalWaiting/WindowModalWaiting"
end

function ModalWaitingView:onEnter()
    super.onEnter(self)
    self:registerEvent()
    LuaClass.GuiGRoot.inst:ShowModalWait()
    self.timer = App.timeManager:add(3000, function()
    end, 3000, function()
        LuaClass.GuiGRoot.inst:CloseModalWait()
    end)
end

function ModalWaitingView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
    registerEventFunc(self.ui.n0, eventType.Click, handler(self, self.showWindow))
end

function ModalWaitingView:showWindow()
    if not self.window then
        local view = LuaClass.GuiWindow()
        ---@type WindowC
        local window = LuaClass.WindowC(view)
        self.window = window
    end
    self.window:show()
end

function ModalWaitingView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function ModalWaitingView:closeView()
    if self.timer then
        App.timeManager:remove(self.timer)
    end
    module:closeView()
end

function ModalWaitingView:onExit()
    self:unRegisterEvent()
end

function ModalWaitingView:dispose()
    super.dispose(self)
end

return ModalWaitingView
