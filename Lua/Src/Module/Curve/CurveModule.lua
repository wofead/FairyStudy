---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class CurveModule:BaseModule
local CurveModule = class("CurveModule", super)

function CurveModule:ctor()
    super.ctor(self)
    ---@type CurveModule
    self.view = nil
end

function CurveModule:showView()
    self.view = App.uiManager:showView(LuaClass.CurveModule)
end

function CurveModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return CurveModule