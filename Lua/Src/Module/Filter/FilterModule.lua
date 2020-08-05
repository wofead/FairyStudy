---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class FilterModule:BaseModule
local FilterModule = class("FilterModule", super)

function FilterModule:ctor()
    super.ctor(self)
    ---@type FilterView
    self.view = nil
end

function FilterModule:showView()
    self.view = App.uiManager:showView(LuaClass.FilterView)
end

function FilterModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return FilterModule