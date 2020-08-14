-- @Author: jow
-- @Date:   2020/8/5 10:11
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class TurnPageModule:BaseModule
local TurnPageModule = class("TurnPageModule", super)

function TurnPageModule:ctor()
    super.ctor(self)
    ---@type TurnPageView
    self.view = nil
end

function TurnPageModule:showView()
    self.view = App.uiManager:showView(LuaClass.TurnPageView)
end

function TurnPageModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return TurnPageModule
