---Author：  houn
---DATE：    2020/6/27
---DES:      对gameObject的扩张

---@class GameObject
local GameObjectEx = LuaClass.Extension(LuaClass.GameObject)

function GameObjectEx:addLuaComponent(module, ...)
    if self.luaComponent == nil then
        self.luaComponent = 0 --此为关键步骤，初始化C#对象的Lua绑定

        ---@type GameObjectComponent
        self.luaComponent = LuaClass.GameObjectComponent(self)
    end
    if module ~= nil then
        return self.luaComponent:add(module, ...)
    end
end

-- 开启引用计数
function GameObjectEx:openReflect()
    if not self.isOpenReflect then
        self.useReflectNum = 0
        self.isOpenReflect = true
    end
end

function GameObjectEx:retain()
    if self.isOpenReflect then
        self.useReflectNum = self.useReflectNum + 1
        App:cancelAutoRelease(self)
    end
end

function GameObjectEx:release()
    if self.isOpenReflect then
        self.useReflectNum = self.useReflectNum - 1
        if self.useReflectNum <= 0 then
            App:autoRelease(self)
        end
    end
end

return GameObjectEx