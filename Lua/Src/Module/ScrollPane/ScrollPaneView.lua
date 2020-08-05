-- @Author: jow
-- @Date:   2020/8/5 10:08
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class ScrollPaneView:BaseUi
local ScrollPaneView = class("ScrollPaneView", super)

local module = App.scrollPaneModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
ScrollPaneView.uiConfig = LuaClass.UiConstant.ScrollPane

function ScrollPaneView:init()
end

function ScrollPaneView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function ScrollPaneView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function ScrollPaneView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function ScrollPaneView:closeView()
    module:closeView()
end

function ScrollPaneView:onExit()
    self:unRegisterEvent()
end

function ScrollPaneView:dispose()
    super.dispose(self)
end

return ScrollPaneView
