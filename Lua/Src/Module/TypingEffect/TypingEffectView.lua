-- @Author: jow
-- @Date:   2020/8/5 10:10
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class TypingEffectView:BaseUi
local TypingEffectView = class("TypingEffectView", super)

local module = App.typingEffectModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
TypingEffectView.uiConfig = LuaClass.UiConstant.TypingEffect

function TypingEffectView:init()
end

function TypingEffectView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function TypingEffectView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function TypingEffectView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function TypingEffectView:closeView()
    module:closeView()
end

function TypingEffectView:onExit()
    self:unRegisterEvent()
end

function TypingEffectView:dispose()
    super.dispose(self)
end

return TypingEffectView
