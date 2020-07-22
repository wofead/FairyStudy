---Author：  houn
---DATE：    2020/7/19
---DES:      背包模块

local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class BagModule:BaseModule
local BagModule = class("BagModule", super)

function BagModule:ctor()
    super.ctor(self)
    ---@type BagView
    self.view = nil
end

function BagModule:showView()
    self.view = App.uiManager:showView(LuaClass.BagView)
end

function BagModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end


return BagModule