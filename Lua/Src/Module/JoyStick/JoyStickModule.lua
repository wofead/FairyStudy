-- @Author: jow
-- @Date:   2020/8/5 10:00
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class JoyStickModule:BaseModule
local JoyStickModule = class("JoyStickModule", super)

function JoyStickModule:ctor()
    super.ctor(self)
    ---@type JoyStickView
    self.view = nil
end

function JoyStickModule:showView()
    self.view = App.uiManager:showView(LuaClass.JoyStickView)
end

function JoyStickModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return JoyStickModule
