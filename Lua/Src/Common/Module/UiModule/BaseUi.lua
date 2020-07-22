---Author：  houn
---DATE：    2020/7/5
---DES:      Ui基类

local LuaClass = LuaClass
local super = nil
---@class BaseUi
local BaseUi = class("BaseUi", super)
function BaseUi.createUiSearcher(view)
    local result = {}
    local m = {}
    local function getChildInSubNodes(childNum, key, node)
        if childNum == 0 then
            return nil
        end
        local child = nil
        local subNodeTable = {}
        for i = 1, childNum do
            local curNode = node:GitChildAt(i - 1)
            if isValid(curNode) and curNode.GetChild then
                child = curNode:GetChild(key)
                if isValid(child) then
                    return child
                end
            end
        end

        for i = 1, childNum do
            local curNode = node:GitChildAt(i - 1)
            local subNodeLen = curNode.numChildren
            if isValid(subNodeLen) and subNodeLen > 0 then
                child = getChildInSubNodes(subNodeLen, key, curNode)
                if isValid(child) then
                    return child
                end
            end
        end
        return child
    end

    m.__index = function(t, key)
        local child = m[k]
        if isValid(child) then
            return child
        end
        child = view:GetChild(key)
        if isValid(child) then
            m[key] = child
            return child
        end
        child = getChildInSubNodes(view.numChildren, key, view)
        if isValid(child) then
            m[key] = child
        end
        return child
    end
    setmetatable(result, m)
    return result
end

function BaseUi:initConfig(view)
    ---@type UiConstant
    local uiConfig = self.uiConfig
    self.pkgPath = LuaClass.AssetPathUtilEx.getPackageUrl(uiConfig.packageName)
    self.pkgName = uiConfig.packageName
    self.cmpName = uiConfig.componentName
    self.layerType = uiConfig.layerType or App.uiManager.LayerType.WindowLayer
    self.isCanComeback = setDefultValue(uiConfig.isCanComeback, true)
    self.isRepeat = setDefultValue(uiConfig.isRepeat,false)
    ---界面是否会被自动关闭
    self.isAutoClose = setDefultValue(uiConfig.isAutoClose,true)
    ---界面是否会被缓存
    self.isCache = setDefultValue(uiConfig.isCache,true)
    ---是否是全屏界面
    self.isFullScreen = setDefultValue(uiConfig.isFallScreen,false)
    ---@type FairyGUI.GComponent
    self.view = view
    self.ui = BaseUi.createUiSearcher(view)
    if self.isFullScreen then
        self:setFullScreen()
    end
    self:init()
end

function BaseUi:init()
end

---设置背景全屏
function BaseUi:setFullScreen()
    self.view:MakeFullScreen()
    local offX = (LuaClass.GameConfig.CC_DESIGN_RESOLUTION.width - LuaClass.GuiGRoot.inst.width) / 2
    local offY = (LuaClass.GameConfig.CC_DESIGN_RESOLUTION.height - LuaClass.GuiGRoot.inst.height) / 2
    self.view:SetXY(offX,offY)

    local viewBg = self.view:GetChild("viewBg")
    if isValid(viewBg) then
        local scaleW = LuaClass.GuiGRoot.inst.width / LuaClass.GameConfig.CC_DESIGN_RESOLUTION.width
        local scaleH = LuaClass.GuiGRoot.inst.height / LuaClass.GameConfig.CC_DESIGN_RESOLUTION.height
        local scale = scaleW
        if scaleH > scaleW then
            scale = scaleH
        end
        viewBg:SetScale(scale,scale)
    end
end

--- UI初始化时调用
function BaseUi:onInitialize(closeCallBack,...)
    self.closeCallBack = closeCallBack
    self:onEnter(...)
    self:refresh()
end

--- ui关闭
function BaseUi:close()
    self.view:RemoveFromParent()
    self:onExit()
end

--- ui销毁
function BaseUi:dispose()
    self:close()
    self.view:Dispose()
end

---界面被覆盖后，重新显示在最上层时调用，子类可重写这个方法
function BaseUi:refresh()
    print("BaseUI:refresh")
end

--- 所有子类必须重写这个方法,并且界面逻辑必须写在这个方法或者这个方法之后的方法里，不建议写在ctor中
function BaseUi:onEnter(...)
    print("BaseUI:onEnter")
    -- self:registerEvent()
end
--- 子类可重写这个方法,UI退出后的逻辑
function BaseUi:onExit()
    if isValid(self._closeCallBack) then
        self._closeCallBack()
    end
    -- self:unRegisterEvent()
    print("BaseUI:onExit")
end


-- 注册侦听事件(界面事件侦听注册)
function BaseUi:registerEvent()
end


-- 移除侦听事件(界面事件侦听移除)
function BaseUi:unRegisterEvent()
end

return BaseUi