-- @Author: jow
-- @Date:   2020/8/5 9:58
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class HeadBarModule:BaseModule
local HeadBarModule = class("HeadBarModule", super)

function HeadBarModule:ctor()
    super.ctor(self)
    ---@type HeadBarView
    self.view = nil
end

function HeadBarModule:showView()
    self.view = App.uiManager:showView(LuaClass.HeadBarView)
end

function HeadBarModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return HeadBarModule
