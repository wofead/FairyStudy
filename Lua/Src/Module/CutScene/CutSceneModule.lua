---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class CutSceneModule:BaseModule
local CutSceneModule = class("CutSceneModule", super)

function CutSceneModule:ctor()
    super.ctor(self)
    ---@type CutSceneView
    self.view = nil
end

function CutSceneModule:showView()
    self.view = App.uiManager:showView(LuaClass.CutSceneView)
end

function CutSceneModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return CutSceneModule