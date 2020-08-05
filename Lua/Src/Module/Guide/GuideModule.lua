-- @Author: jow
-- @Date:   2020/8/5 9:58
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class GuideModule:BaseModule
local GuideModule = class("GuideModule", super)

function GuideModule:ctor()
    super.ctor(self)
    ---@type GuideView
    self.view = nil
end

function GuideModule:showView()
    self.view = App.uiManager:showView(LuaClass.GuideView)
end

function GuideModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return GuideModule
