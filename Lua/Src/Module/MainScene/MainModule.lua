---Author：  houn
---DATE：    2020/7/15
---DES:      主界面的module

local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class MainModule:BaseModule
local MainModule = class("MainModule", super)

function MainModule:ctor()
    super.ctor(self)
    ---@type MainView
    self.view = nil
end

function MainModule:showView()
    self.view = App.uiManager:showView(LuaClass.MainView)
end

function MainModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return MainModule