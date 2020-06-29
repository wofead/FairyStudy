---Author：  houn
---DATE：    2020/6/26
---DES:      

local LuaClass = LuaClass
local super = nil
---@class PoolManager
local PoolManager = class("PoolManager", super)

function PoolManager:ctor()
    self.bombDic = {}

    self.poolObj = LuaClass.GameObject("PoolLayer")
end

return PoolManager