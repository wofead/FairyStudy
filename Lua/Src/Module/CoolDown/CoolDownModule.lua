---Author：  houn
---DATE：    2020/8/5
---DES:      
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class CoolDownModule:BaseModule
local CoolDownModule = class("CoolDownModule", super)

function CoolDownModule:ctor()
    super.ctor(self)
    ---@type CoolDownView
    self.view = nil
end

function CoolDownModule:showView()
    self.view = App.uiManager:showView(LuaClass.CoolDownView)
end

function CoolDownModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return CoolDownModule