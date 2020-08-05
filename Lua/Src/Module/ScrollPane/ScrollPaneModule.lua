-- @Author: jow
-- @Date:   2020/8/5 10:08
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class ScrollPaneModule:BaseModule
local ScrollPaneModule = class("ScrollPaneModule", super)

function ScrollPaneModule:ctor()
    super.ctor(self)
    ---@type ScrollPaneView
    self.view = nil
end

function ScrollPaneModule:showView()
    self.view = App.uiManager:showView(LuaClass.ScrollPaneView)
end

function ScrollPaneModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return ScrollPaneModule
