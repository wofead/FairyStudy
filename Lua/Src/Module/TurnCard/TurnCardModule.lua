-- @Author: jow
-- @Date:   2020/8/5 10:11
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class TurnCardModule:BaseModule
local TurnCardModule = class("TurnCardModule", super)

function TurnCardModule:ctor()
    super.ctor(self)
    ---@type TurnCardView
    self.view = nil
end

function TurnCardModule:showView()
    self.view = App.uiManager:showView(LuaClass.TurnCardView)
end

function TurnCardModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return TurnCardModule
