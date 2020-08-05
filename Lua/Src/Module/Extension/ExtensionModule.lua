---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class ExtensionModule:BaseModule
local ExtensionModule = class("ExtensionModule", super)

function ExtensionModule:ctor()
    super.ctor(self)
    ---@type ExtensionView
    self.view = nil
end

function ExtensionModule:showView()
    self.view = App.uiManager:showView(LuaClass.ExtensionView)
end

function ExtensionModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return ExtensionModule