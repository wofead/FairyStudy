-- @Author: jow
-- @Date:   2020/8/5 10:02
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class LoopListModule:BaseModule
local LoopListModule = class("LoopListModule", super)

function LoopListModule:ctor()
    super.ctor(self)
    ---@type LoopListView
    self.view = nil
end

function LoopListModule:showView()
    self.view = App.uiManager:showView(LuaClass.LoopListView)
end

function LoopListModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return LoopListModule
