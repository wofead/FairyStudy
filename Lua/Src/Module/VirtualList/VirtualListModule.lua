-- @Author: jow
-- @Date:   2020/8/5 10:10
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class VirtualListModule:BaseModule
local VirtualListModule = class("VirtualListModule", super)

function VirtualListModule:ctor()
    super.ctor(self)
    ---@type VirtualListView
    self.view = nil
end

function VirtualListModule:showView()
    self.view = App.uiManager:showView(LuaClass.VirtualListView)
end

function VirtualListModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return VirtualListModule
