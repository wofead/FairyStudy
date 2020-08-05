-- @Author: jow
-- @Date:   2020/8/5 10:12
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class TreeViewModule:BaseModule
local TreeViewModule = class("TreeViewModule", super)

function TreeViewModule:ctor()
    super.ctor(self)
    ---@type TreeViewView
    self.view = nil
end

function TreeViewModule:showView()
    self.view = App.uiManager:showView(LuaClass.TreeViewView)
end

function TreeViewModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return TreeViewModule
