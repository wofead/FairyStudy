-- @Author: jow
-- @Date:   2020/8/5 9:59
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class HeadBarView:BaseUi
local HeadBarView = class("HeadBarView", super)

local module = App.headBarModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
HeadBarView.uiConfig = LuaClass.UiConstant.HeadBar

function HeadBarView:init()
end

function HeadBarView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function HeadBarView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function HeadBarView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function HeadBarView:closeView()
    module:closeView()
end

function HeadBarView:onExit()
    self:unRegisterEvent()
end

function HeadBarView:dispose()
    super.dispose(self)
end

return HeadBarView
