-- @Author: jow
-- @Date:   2020/8/5 10:07
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class RenderTextureModule:BaseModule
local RenderTextureModule = class("RenderTextureModule", super)

function RenderTextureModule:ctor()
    super.ctor(self)
    ---@type RenderTextureView
    self.view = nil
end

function RenderTextureModule:showView()
    self.view = App.uiManager:showView(LuaClass.RenderTextureView)
end

function RenderTextureModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return RenderTextureModule
