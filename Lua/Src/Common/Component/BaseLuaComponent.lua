---Author：  houn
---DATE：    2020/7/7
---DES:      

local LuaClass = LuaClass
local super = nil
---@class BaseLuaComponent
local BaseLuaComponent = class("BaseLuaComponent", super)

function BaseLuaComponent:NewGameObject(...)
    ---@type UnityEngine.GameObject
    local go = LuaClass.GameObject(self.__cname)
    local comp = go:addLuaComponent(self, ...)
    return comp
end

---@param gameObject UnityEngine.GameObject
function BaseLuaComponent:ctor(gameObject)
    ---@type UnityEngine.GameObject
    self.gameObject = gameObject
    ---@type UnityEngine.Transform
    self.transform = gameObject.transform
end

function BaseLuaComponent:getLuaComponent(module)
    return self.gameObject:getLuaComponent(module)
end

-- 移除一个Lua组件
function BaseLuaComponent:removeLuaComponent(module)
    return self.gameObject:removeLuaComponent(module)
end

function BaseLuaComponent:addTo(node)
    self.transform:SetParent(node.transform, false)
    return self
end

function BaseLuaComponent:addChild(node)
    node.transform:SetParent(self.transform, false)
    return self
end

function BaseLuaComponent:setPosition(x, y)
    self.transform:LocalPosition(x, y)
end

function BaseLuaComponent:setPositionX(x)
    self.transform:LocalPositionX(x)
    return self
end

function BaseLuaComponent:setPositionY(y)
    self.transform:LocalPositionY(y)
    return self
end

function BaseLuaComponent:setPositionZ(z)
    self.transform:LocalPositionZ(z)
    return self
end

--- 将本地坐标重置为 （0，0，0）
function BaseLuaComponent:localPositionIdentity()
    self.transform:LocalPositionIdentity()
    return self
end

--- 将本地坐标重置为 （0，0，0），
--- 本地缩放重置为（1，1，1），
--- 本地旋转重置为（0，0，0）
function BaseLuaComponent:localIdentity()
    self.transform:LocalIdentity()
    return self
end

---递归遍历子物体，并调用函数
--- @param action Action<Transform>
function BaseLuaComponent:actionRecursion(action)
    self.transform:ActionRecursion(action)
    return self
end

---隐藏物件
function BaseLuaComponent:setVisible(b, layer)
    local hideLayer
    if isValid(b) then
        hideLayer = layer or LuaClass.GlobalConstant.MAP_LAYER
    else
        hideLayer = LuaClass.GlobalConstant.HIDE_LAYER
    end
    if self.hideLayer ~= hideLayer then
        self.hideLayer = hideLayer
        if not self._hideFunc then
            self._hideFunc = function(transform)
                transform.gameObject.layer = self.hideLayer
            end
        end
        self:actionRecursion(self.hideFunc)
    end
    return self
end

---设置物件图层
function BaseLuaComponent:setLayer(layer)
    layer = layer or LuaClass.GlobalConstant.HIDE_LAYER
    if self.layer ~= layer then
        self.layer = layer
        if not self.setLayerFunc then
            self.setLayerFunc = function(transform)
                transform.gameObject.layer = self.layer
            end
        end
        self:actionRecursion(self.setLayerFunc)
    end
    return self
end

function BaseLuaComponent:isVisible()
    if self.gameObject.layer == LuaClass.GlobalConstant.HIDE_LAYER then
        return false
    end
    return true
end

---设置组件的是否激活
function BaseLuaComponent:setActive(b)
    self.gameObject:SetActive(b)
    return self
end

local mQuaternion = LuaClass.Quaternion(0, 0, 0, 0)
---@param value 欧拉角度 旋转
function BaseLuaComponent:rotate(value)
    value = LuaClass.Mathf.IsNan(value) and 0 or value
    local r = LuaClass.Mathf.Deg2Rad * value * 0.5
    local w = LuaClass.Mathf.Cos(r)
    local z = LuaClass.Mathf.Sin(r)
    mQuaternion.x = 0
    mQuaternion.y = 0
    mQuaternion.z = z
    mQuaternion.w = w
    self.transform.localRotation = mQuaternion
    return self
end

---@return Vector3 本地缩放
function BaseLuaComponent:getScale()
    if not self.gameObject._tempScale then
        self.gameObject._tempScale = LuaClass.Vector3()
    end
    xlua.get_local_scale(self.transform, self.gameObject._tempScale)
    return self.gameObject._tempScale
end

function BaseLuaComponent:getRotation()
    if not self.gameObject._tempLocalEulerAngles then
        self.gameObject._tempLocalEulerAngles = LuaClass.Vector3()
    end
    xlua.get_local_eulerangles(self.transform, self.gameObject._tempLocalEulerAngles)
    return self.gameObject._tempLocalEulerAngles.z
end

function BaseLuaComponent:show(layer)
    self:setVisible(true, layer)
    return self
end

function BaseLuaComponent:hide()
    self:setVisible(false)
    return self
end

function BaseLuaComponent:destroyGameObj()
    self.transform:DestroyGameObj()
    return self
end

--- 通知gameObject上的其他组件 调用msg方法
function BaseLuaComponent:sendLuaCompMessage(msg, ...)
    self.gameObject.luaComponent:sendLuaCompMessage(msg, ...)
end

return BaseLuaComponent