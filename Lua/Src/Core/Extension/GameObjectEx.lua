---Author：  houn
---DATE：    2020/6/27
---DES:      对gameObject的扩张

---@type UnityEngine.GameObject
local GameObjectEx = LuaClass.Extension(LuaClass.GameObject)

---@return BaseLuaComponent
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

---获取引用计数
function GameObjectEx:getUseReflectNum()
    return self.useReflectNum or 0
end

-- 获得一个Lua组件
function GameObjectEx:getLuaComponent(module)
    if self.luaComponent then
        return self.luaComponent:get(module)
    end
end

-- 移除一个Lua组件
function GameObjectEx:removeLuaComponent(module)
    if self.luaComponent then
        return self.luaComponent:remove(module)
    end
end

---@return FairyGUI.UIPanel
function GameObjectEx:addUIToSelf(packageName, cmpname)
    local panel = self:AddComponent(typeof(LuaClass.GuiUIPanel))
    panel.packageName = packageName
    panel.componentName = cmpname
    --设置renderMode的方式
    panel.container.renderMode = LuaClass.RenderMode.WorldSpace
    --设置sortingOrder的方式
    panel:SetSortingOrder(1000, true)
    --设置摄像机
    panel.container.renderCamera = LuaClass.Camera.main
    --设置大小，单位是米，所以要除以100
    panel.container:SetScale(
            panel.container.scale.x / LuaClass.GameConfig.PIXELS_PER_UNIT,
            panel.container.scale.y / LuaClass.GameConfig.PIXELS_PER_UNIT
    )
    panel:CreateUI()

    panel.gameObject.layer = LuaClass.GlobalConstant.MAP_LAYER
    return panel
end

return GameObjectEx