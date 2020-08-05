---Author：  houn
---DATE：    2020/7/19
---DES:      背包界面

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class BagView:BaseUi
local BagView = class("BagView", super)
local module = App.bagModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
BagView.uiConfig = LuaClass.UiConstant.Bag

function BagView:init()
end

function BagView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function BagView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
    registerEventFunc(ui.bagBtn,eventType.Click,handler(self, self.showWindow))
end

function BagView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function BagView:showWindow()
    if not self.window then
        ---@type FairyGUI.GComponent
        local view = LuaClass.GuiWindow()
        ---@type BagWindow
        self.window = LuaClass.BagWindow(view)
    end
    self.window:show()
end

function BagView:closeView()
    module:closeView()
end

function BagView:onExit()
    self:unRegisterEvent()
end

function BagView:dispose()
    super.dispose(self)
end

return BagView