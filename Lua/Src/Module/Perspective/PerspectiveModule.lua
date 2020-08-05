-- @Author: jow
-- @Date:   2020/8/5 10:06
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class PerspectiveModule:BaseModule
local PerspectiveModule = class("PerspectiveModule", super)

function PerspectiveModule:ctor()
    super.ctor(self)
    ---@type PerspectiveView
    self.view = nil
end

function PerspectiveModule:showView()
    self.view = App.uiManager:showView(LuaClass.PerspectiveView)
end

function PerspectiveModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return PerspectiveModule
