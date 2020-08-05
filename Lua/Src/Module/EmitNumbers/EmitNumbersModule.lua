---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class EmitNumbersModule:BaseModule
local EmitNumbersModule = class("EmitNumbersModule", super)

function EmitNumbersModule:ctor()
    super.ctor(self)
    ---@type EmitNumbersView
    self.view = nil
end

function EmitNumbersModule:showView()
    self.view = App.uiManager:showView(LuaClass.EmitNumbersView)
end

function EmitNumbersModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return EmitNumbersModule