-- @Author: jow
-- @Date:   2020/8/7 15:14
-- @Des:    
local LuaClass = LuaClass
local super = nil
---@class ObjectPool
local ObjectPool = class("ObjectPool", super)

function ObjectPool:ctor(constructor, init, reset, destroy)
    self.constructor = constructor
    self.init = init
    self.reset = reset
    self.destroy = destroy
    self.cacheArr = {}
    self.cacheDic = {}
end

function ObjectPool:add(obj)
    if isValid(obj) then
        if not self.cacheDic[obj] then
            if self.reset then
                self.reset(obj)
            end
            table.insert(self.cacheArr, obj)
            self.cacheDic[obj] = true
        end
    end
end

function ObjectPool:get(...)
    local obj
    if #self.cacheArr > 0 then
        obj = table.remove(self.cacheArr)
        self.cacheDic[obj] = false
    else
        obj = self.constructor()
    end
    if self.init then
        self.init(obj, ...)
    end
    return obj
end

function ObjectPool:destroy()
    if self.destroy then
        for _, v in ipairs(self.cacheArr) do
            self.destroy(v)
        end
    end
    self.cacheArr = {}
    self.cacheDic = {}
end

return ObjectPool
