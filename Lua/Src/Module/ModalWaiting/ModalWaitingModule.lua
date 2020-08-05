-- @Author: jow
-- @Date:   2020/8/5 10:04
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class ModalWaitingModule:BaseModule
local ModalWaitingModule = class("ModalWaitingModule", super)

function ModalWaitingModule:ctor()
    super.ctor(self)
    ---@type ModalWaitingView
    self.view = nil
end

function ModalWaitingModule:showView()
    self.view = App.uiManager:showView(LuaClass.ModalWaitingView)
end

function ModalWaitingModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return ModalWaitingModule
