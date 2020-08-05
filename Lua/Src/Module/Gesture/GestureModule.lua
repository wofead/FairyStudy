-- @Author: jow
-- @Date:   2020/8/5 9:46
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class GestureModule:BaseModule
local GestureModule = class("GestureModule", super)

function GestureModule:ctor()
    super.ctor(self)
    ---@type GestureView
    self.view = nil
end

function GestureModule:showView()
    self.view = App.uiManager:showView(LuaClass.GestureView)
end

function GestureModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return GestureModule
