-- @Author: jow
-- @Date:   2020/8/5 10:05
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class ParticlesModule:BaseModule
local ParticlesModule = class("ParticlesModule", super)

function ParticlesModule:ctor()
    super.ctor(self)
    ---@type ParticlesView
    self.view = nil
end

function ParticlesModule:showView()
    self.view = App.uiManager:showView(LuaClass.ParticlesView)
end

function ParticlesModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return ParticlesModule
