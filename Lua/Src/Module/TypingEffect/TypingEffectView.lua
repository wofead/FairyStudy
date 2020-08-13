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
    local t1 = LuaClass.GuiTypingEffect(self.ui.n2)
    t1:Start()
    LuaClass.GuiTimers.inst:StartCoroutine(t1:Print(0.05))
    --LuaClass.GuiTimers.inst:StartCoroutine(t1:Print(0.05))
    local t2 = LuaClass.GuiTypingEffect(self.ui.n3)
    self.t2 = t2
    t2:Start()
    self.timer = App.timeManager:add(50, handler(self, self.printText), -1, nil)
end

function TypingEffectView:printText(param)
    if not self.t2:Print() then
        App.timeManager:remove(self.timer)
    end
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
