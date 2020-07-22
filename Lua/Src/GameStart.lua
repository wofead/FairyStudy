---Author：  houn
---DATE：    2020/7/7
---DES:      游戏开始主程序

local LuaClass = LuaClass
local super = LuaClass.BaseLuaComponent
---@class GameStart:BaseLuaComponent
local GameStart = class("GameStart", super)

function GameStart:ctor(gameObject)
    super.ctor(self, gameObject)
    self:init()
end

function GameStart:init()
    App.mainModule:showView()
end

return GameStart