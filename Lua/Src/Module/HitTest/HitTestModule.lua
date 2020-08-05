-- @Author: jow
-- @Date:   2020/8/5 9:59
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class HitTestModule:BaseModule
local HitTestModule = class("HitTestModule", super)

function HitTestModule:ctor()
    super.ctor(self)
    ---@type HitTestView
    self.view = nil
end

function HitTestModule:showView()
    self.view = App.uiManager:showView(LuaClass.HitTestView)
end

function HitTestModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return HitTestModule
