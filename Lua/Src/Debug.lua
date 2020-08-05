---Author：  houn
---DATE：    2020/6/26
---DES:      debug用的
---@class Debug
local debug

local uiManager = App.uiManager
LuaClass.clearLua("BasicsView")

uiManager.viewCacheDic["BasicsView"] = nil

printJow("Debug", "UI refresh")