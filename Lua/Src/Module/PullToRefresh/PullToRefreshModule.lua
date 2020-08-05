-- @Author: jow
-- @Date:   2020/8/5 10:07
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class PullToRefreshModule:BaseModule
local PullToRefreshModule = class("PullToRefreshModule", super)

function PullToRefreshModule:ctor()
    super.ctor(self)
    ---@type PullToRefreshView
    self.view = nil
end

function PullToRefreshModule:showView()
    self.view = App.uiManager:showView(LuaClass.PullToRefreshView)
end

function PullToRefreshModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return PullToRefreshModule
