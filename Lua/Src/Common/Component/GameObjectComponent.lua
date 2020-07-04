---Author：  houn
---DATE：    2020/6/27
---DES:      GameObject组件

local LuaClass = LuaClass
local super = nil
---@class GameObjectComponent
local GameObjectComponent = class("GameObjectComponent", super)

---@param gameObject GameObject
function GameObjectComponent:ctor(gameObject)
    self.gameObject = gameObject
    self.components = {}


end

function GameObjectComponent:add(module, ...)
    local isExist = self:get(module)
    if isExist then
        print("Same GameObjectComponent can't be added twice" .. module.__cname .. debug.traceback())
        return isExist
    end
    local component = module(self.gameObject)
    table.insert(self.components, component)
end

function GameObjectComponent:get(module)
    for i, v in ipairs(self.components) do
        if iskindof(v, module.__cname) then
            return v
        end
    end
end

function GameObjectComponent:remove(module)
    for i,v in ipairs(self._components) do
        if iskindof(v, module.__cname) then
            table.remove(self._components, i)
            break
        end
    end
end

return GameObjectComponent