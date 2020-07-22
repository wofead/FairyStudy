---Author：  houn
---DATE：    2020/6/26
---DES:      ui创建管理类

local LuaClass = LuaClass
local super = nil
---@class UiManager
local UiManager = class("UiManager", super)
local INT32MAX = 2147483647
local MaxOpenViewLength = 8

UiManager.LayerSort = {
    "FixedLayer",
    "WindowLayer",
    "FloatLayer",
    "TopLayer"
}

UiManager.LayerType = {
    ---底层固定层
    FixedLayer = "FixedLayer",
    ---弹窗层
    WindowLayer = "WindowLayer",
    ---浮动信息弹出层
    FloatLayer = "FloatLayer",
    ---最顶层
    TopLayer = "TopLayer",
}

function UiManager:ctor()
    ---@type BaseUi[]
    self.allOpenViewList = {}
    self.layerAllViewDic = {}
    self.layerDic = {}
    self.viewCacheDic = {}
    self.repeatViewCount = 1

    for _, layerName in ipairs(self.LayerSort) do
        local layer = LuaClass.GuiGComponent()
        layer.name = self.LayerType[value]
        LuaClass.GuiGRoot.inst:AddChild(layer)
        layer.fairyBatching = true
        self.layerDic[layerName] = layer
        self.layerAllViewDic[layerName] = {}
    end

    self.uiStageCamera = LuaClass.GameObject.Find("Stage Camera"):GetComponent(typeof(LuaClass.Camera))
end

function UiManager:addChild(obj, layerType)
    self.layerDic[layerType]:AddChild(obj)
end

---@param uiConfig UiConstant
function UiManager:createUI(uiConfig)
    ---ui资源的模块路径
    local packagePath = LuaClass.AssetPathUtilEx.getPackageUrl(uiConfig.packageName)
    ---ui资源中的组件名称
    local componentName = uiConfig.componentName

    if isValid(packagePath) and isValid(componentName) then
        local package = LuaClass.GuiUIPackage.AddPackage(packagePath)
        local view = package:CreateObject(componentName)
        return view
    end

end

---@param viewClass BaseUi
function UiManager:showView(viewClass, closeCallBack, ...)
    local uiConfig = viewClass.uiConfig
    local viewClassName = viewClass.__cname
    if not uiConfig then
        error("not find uiConfig: " .. viewClassName)
        return
    end
    ---@type BaseUi
    local module = nil
    if self.viewCacheDic[viewClassName] then
        module = self.viewCacheDic[viewClassName]
    else
        local view = self:createUI(uiConfig)
        if not view then
            error("create ui error: " .. viewClassName)
            return
        end
        local displayObject = view.displayObject
        local tempGameObject = displayObject.gameObject
        module = tempGameObject:addLuaComponent(viewClass)
        module:initConfig(view)

        if module.isCache then
            self.viewCacheDic[viewClassName] = module
        end
    end

    module.__newName = self:generateUiKey(module)
    if not isValid(module.__newName) then
        return
    end

    if isValid(module) then
        if not module.isRepeat then
            local sameViewIndex = -1
            for index, value in ipairs(self.allOpenViewList) do
                if value.__cname == module.__cname then
                    sameViewIndex = index
                    break
                end
            end
            if sameViewIndex ~= -1 then
                self:closeView(self.allOpenViewList[sameViewIndex])
            end
        end

        if module.layerType == self.LayerType.FixedLayer then
            for index = #self.allOpenViewList, 1, -1 do
                local view = self.allOpenViewList[index]
                if view.layerType ~= self.LayerType.FixedLayer then
                    self:closeView(view)
                end
            end
        end

        --3、判断上一个界面是否需要被隐藏
        if #self.allOpenViewList > 0 then
            local lastView = self.allOpenViewList[#self.allOpenViewList]
            if isValid(lastView) then
                if not lastView.isCanComeback then
                    self:closeView(lastView)
                end
            end
        end
        --4、添加界面到列表
        table.insert(self.allOpenViewList, module)
        table.insert(self.layerAllViewDic[module.layerType], module)

        --5、判断列表长度是否超过最大长度
        if #self.allOpenViewList > MaxOpenViewLength then
            for i = 1, #self.allOpenViewList do
                local view = self.allOpenViewList[i]
                if view.isAutoClose then
                    self:closeView(view)
                    break
                end
            end
        end

        ---6、初始化界面
        module.view.visible = true
        self.layerDic[module.layerType]:AddChild(module.view)
        module:onInitialize(closeCallBack, ...)
    end
    return module
end

---@param view BaseUi
function UiManager:closeView(view)
    ---@param module  BaseUi
    function removeFromLayerViewDic(module)
        for index, value in ipairs(self.layerAllViewDic[module.layerType]) do
            if module == value then
                table.remove(self.layerAllViewDic[module.layerType], index)
                break
            end
        end
    end

    local cname = view.__cname
    if not isValid(cname) then
        error("请传入正确的moduleType")
        return
    end

    --1、判断要关闭的界面是不是最上层显示的界面
    if #self.allOpenViewList <= 0 then
        error("没有打开的界面了，请检查！")
        return
    end
    local topView = self.allOpenViewList[#self.allOpenViewList]
    local isCloseTopView = view.__newName == topView.__newName or view.__cname == topView.__cname

    --2、关闭当前界面
    for index, value in ipairs(self.allOpenViewList) do
        ---@type BaseUI
        local theView = self.allOpenViewList[index]
        if view.__newName == theView.__newName or view.__cname == theView.__cname then
            table.remove(self.allOpenViewList, index)
            removeFromLayerViewDic(view)
            view.view.visible = false
            if view.isCache then
                view:close()
            else
                view:dispose()
            end
            break
        end
    end

    --3、如果关闭的是最上层显示的界面，则需要刷新当前最上层显示界面
    if isCloseTopView and #self.allOpenViewList > 0 then
        ---@type BaseUI
        local topView = self.allOpenViewList[#self.allOpenViewList]
        topView.view.visible = true
        topView:refresh()
    end
end

function UiManager:clearUICacheByClassName(className)
    self.viewCacheDic[className] = nil
end

---清理UI界面缓存
function UiManager:clearUICache()
    for index, value in ipairs(self.allOpenViewList) do

    end
end

---获取浮动层
---@return GameObject
function UiManager:getFloatLayer()
    return self.layerDic[self.LayerType.FloatLayer]
end

---获取最上层
---@return GameObject
function UiManager:getTopLayer()
    return self.layerDic[self.LayerType.TopLayer]
end

function UiManager:createUIByModule(moduleType, ...)
    local module = moduleType(...)
    local packagePath = module.packagePath
    local componentName = module.componentName
    local view = nil
    if isValid(packagePath) and isValid(componentName) then
        local package = LuaClass.GuiUIPackage.AddPackage(packagePath)
        view = package:CreateObject(componentName)
    end
    return view
end

function UiManager:createUIByName(packageConfig, componentName)
    local packagePath = LuaClass.AssetPathUtilEx.getPkgUrl(packageConfig)
    local package = LuaClass.GuiUIPackage.AddPackage(packagePath)
    local view = package:CreateObject(componentName)
    return view
end

---加载FairyGUI包资源
function UiManager:addUiPackage(packagePath)
    return LuaClass.GuiUIPackage.AddPackage(packagePath)
end

--- 卸载UI包
---包卸载后，所有包里包含的贴图等资源均会被卸载，由包里创建出来的组件也无法显示正常（虽然不会报错），所以这些组件应该（或已经）被销毁。
function UiManager:removeUiPackage(packagePath)
    LuaClass.GuiUIPackage.RemovePackage(packagePath)
end

function UiManager:generateUiKey(module)
    local cname = ""
    if type(module) == "table" then
        cname = module.__cname
    end
    cname = cname .. "_" .. tostring(self.repeatViewCount) .. "_" .. os.time()
    self.repeatViewCount = self.repeatViewCount + 1
    if self.repeatViewCount >= 99999 then
        self.repeatViewCount = 0
    end
    return cname
end

return UiManager