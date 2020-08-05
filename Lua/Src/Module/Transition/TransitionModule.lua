-- @Author: jow
-- @Date:   2020/8/5 10:12
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class TransitionModule:BaseModule
local TransitionModule = class("TransitionModule", super)

function TransitionModule:ctor()
    super.ctor(self)
    ---@type TransitionView
    self.view = nil
end

function TransitionModule:showView()
    self.view = App.uiManager:showView(LuaClass.TransitionView)
end

function TransitionModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return TransitionModule
