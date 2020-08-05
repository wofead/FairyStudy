-- @Author: jow
-- @Date:   2020/8/5 10:04
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class ModelModule:BaseModule
local ModelModule = class("ModelModule", super)

function ModelModule:ctor()
    super.ctor(self)
    ---@type ModelView
    self.view = nil
end

function ModelModule:showView()
    self.view = App.uiManager:showView(LuaClass.ModelView)
end

function ModelModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return ModelModule
