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
