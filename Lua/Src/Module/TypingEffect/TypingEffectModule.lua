-- @Author: jow
-- @Date:   2020/8/5 10:11
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class TypingEffectModule:BaseModule
local TypingEffectModule = class("TypingEffectModule", super)

function TypingEffectModule:ctor()
    super.ctor(self)
    ---@type TypingEffectView
    self.view = nil
end

function TypingEffectModule:showView()
    self.view = App.uiManager:showView(LuaClass.TypingEffectView)
end

function TypingEffectModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return TypingEffectModule
