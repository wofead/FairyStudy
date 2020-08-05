---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseModule
---@class EmojiModule:BaseModule
local EmojiModule = class("EmojiModule", super)

function EmojiModule:ctor()
    super.ctor(self)
    ---@type EmojiView
    self.view = nil
end

function EmojiModule:showView()
    self.view = App.uiManager:showView(LuaClass.EmojiView)
end

function EmojiModule:closeView()
    if isValid(self.view) then
        App.uiManager:closeView(self.view)
        self.view = nil
    end
end

return EmojiModule