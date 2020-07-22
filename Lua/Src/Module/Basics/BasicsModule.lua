---Author：  houn
---DATE：    2020/7/15
---DES:      基本功能界面

local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class BasicsModule:BaseModule
local BasicsModule = class("BasicsModule", super)

function BasicsModule:ctor()
    super.ctor(self)
    ---@type BasicView
    self.view = nil
end

function BasicsModule:showView()
    self.view = App.uiManager:showView(LuaClass.BasicsView)
end

function BasicsModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return BasicsModule