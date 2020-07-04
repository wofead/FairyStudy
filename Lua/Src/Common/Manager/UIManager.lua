---Author：  houn
---DATE：    2020/6/26
---DES:      ui创建管理类

local LuaClass = LuaClass
local super = nil
---@class UIManager
local UIManager = class("UIManager", super)
local INT32MAX = 2147483647
local MaxOpenViewLength = 8

UIManager.LayerSort = {
    "FixedLayer",
    "WindowLayer",
    "FloatLayer",
    "TopLayer"
}

UIManager.LayerType = {
    ---底层固定层
    FixedLayer = "FixedLayer",
    ---弹窗层
    WindowLayer = "WindowLayer",
    ---浮动信息弹出层
    FloatLayer = "FloatLayer",
    ---最顶层
    TopLayer = "TopLayer",
}

function UIManager:ctor()
    self._allOpenViewList = {}
    self._layerAllViewDic = {}
    self._layerDic = {}
    self._viewCacheDic = {}
    self.repeatViewCount = 1

    for _, layerName in ipairs(self.LayerSort) do
        local layer = LuaClass.GuiGComponent()
        layer.name = self.LayerType[value]
        LuaClass.GuiGRoot.inst:AddChild(layer)
        layer.fairyBatching  = true
        self._layerDic[layerName] = layer
        self._layerAllViewDic[layerName] = {}
    end

    self.uiStageCamera = LuaClass.GameObject.Find("Stage Camera"):GetComponent(typeof(LuaClass.Camera))
end

function UIManager:addChild(obj, layerType)
    self._layerDic[layerType]:AddChild(obj)
end

function UIManager:createUI(uiConfig)
    ---ui资源的模块路径
    local pkgpath = LuaClass.AssetPathUtilEx.getPkgUrl(uiConfig.moduleConfig)
    ---ui资源中的组件名称
    local cmpname = uiConfig.cmpName

    if isValid(pkgpath) and isValid(cmpname) then
        local package = LuaClass.GuiUIPackage.AddPackage(pkgpath)
        local view = package:CreateObject(cmpname)
        return view
    end

end

return UIManager