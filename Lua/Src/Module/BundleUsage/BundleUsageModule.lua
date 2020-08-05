---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class BundleUsageModule:BaseModule
local BundleUsageModule = class("BundleUsageModule", super)

function BundleUsageModule:ctor()
    super.ctor(self)
    ---@type BundleUsageView
    self.view = nil
end

function BundleUsageModule:showView()
    self.view = App.uiManager:showView(LuaClass.BundleUsageView)
end

function BundleUsageModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end


return BundleUsageModule