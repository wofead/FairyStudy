---Author：  houn
---DATE：    2020/6/26
---DES:      对象缓存池

local LuaClass = LuaClass
local super = nil
---@class PoolManager
local PoolManager = class("PoolManager", super)

---@param go UnityEngine.GameObject
local init = function(go)
    if isValid(go) then
        go.transform:Layer(LuaClass.GlobalConstant.MAP_LAYER)
        go.transform:LocalPositionIdentity()
        go.gameObject:SetActive(true)
    end
end

function PoolManager:ctor()
    ---@type table<string, ObjectPool>
    self._poolDict = {}
    self.poolObj = LuaClass.GameObject("PoolLayer")
    self.gameObject = LuaClass.GameObject("PoolManager")
    self.gameObject:Layer(LuaClass.GlobalConstant.HIDE_LAYER)
    self.transform = self.gameObject.transform
end

---@param luaClass BaseLuaComponent
---@return BaseLuaComponent
function PoolManager:popComponent(luaClass)
    local pool = self._poolDict[luaClass.__cname]
    if not pool then
        pool = LuaClass.ObjectPool(
                function()
                    local comp = luaClass:NewGameObject()
                    return comp
                end, init)
        self._poolDict[luaClass.__cname] = pool
    end
    local comp = pool:get()
    while not isValid(comp.gameObject) do
        comp = pool:get()
    end
    return comp
end

---@param comp BaseLuaComponent
function PoolManager:pushComponent(comp)
    if not isValid(comp) then
        return
    end
    local pool = self._poolDict[comp.__cname]
    if pool then
        comp.transform:SetParent(self.transform, false)
        comp.gameObject:SetActive(false)
        pool:add(comp)
    end
end

---@return UnityEngine.GameObject
function PoolManager:popRes(url)
    local pool = self._poolDict[url]
    if not pool then
        pool = LuaClass.ObjectPool(function()
            --- 构造方法
            local prefab = LuaClass.AssetManager.Load(url)
            local go = LuaClass.GameObject.Instantiate(prefab)
            return go
        end, init)
        self._poolDict[url] = pool
    end

    local go = pool:get()
    while not isValid(go) do
        go = pool:get()
    end
    return go
end

function PoolManager:pushRes(url, go)
    if not isValid(go) then
        return
    end
    local pool = self._poolDict[url]
    if pool then
        go.transform:SetParent(self.transform, false)
        go:SetActive(false)
        pool:add(go)
    end
end

---@return UnityEngine.GameObject
function PoolManager:popResPrefab(prefab)
    local pool = self._poolDict[prefab]
    if not pool then
        pool = LuaClass.ObjectPool(
                function()
                    local go = LuaClass.GameObject.Instantiate(prefab)
                    return go
                end, init)
        self._poolDict[prefab] = pool
    end
    local go = pool:get()
    while not isValid(go) do
        go = pool:get()
    end
    return go
end

function PoolManager:pushResPrefab(prefab, go)
    if not isValid(go) then
        return
    end
    local pool = self._poolDict[prefab]
    if pool then
        go.transform:SetParent(self.transform, false)
        go:SetActive(false)
        pool:add(go)
    end
end

function PoolManager:clean()
    self._poolDict = {}
end

return PoolManager