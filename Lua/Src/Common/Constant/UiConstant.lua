---Author：  houn
---DATE：    2020/6/26
---DES:      UI配置加载文件

--[[
    参数配置：
    moduleConfig : ui资源的模块名称(必要参数)，参数为LuaClass.ModuleConstant中的枚举 eg.LuaClass.ModuleConstant.LOGIN
    packageName： Ui包名
    cmpName : ui资源中的组件名称(必要参数)
    layerType : ui层级名称,默认值为 App.UiManager.LayerType.FixedLayer
    isRepeat ： 是否是可重复界面, 默认值是false,可重复界面只要在界面列表中，那么将不会从缓存中拿，而是直接创建
    isAutoClose : 界面是否会被自动关闭，默认是false,当值为false的时候，只有主动调App.UiManager:CloseView()关闭界面
    isCanBacked : 当该界面被覆盖时是否需要保留，让上层界面回退到当前界面 默认是true
    isCache : 界面是否需要被缓存
    isFallScreen : 是否是全屏界面
--]]

---@class UiConstant
local UiConstant = {
    ---@type ModuleConstant
    moduleConfig = "",
    ---@type string
    componentName = "",
    ---@type string
    packageName = "",
    ---@type string
    layerType = "",
    ---@type boolean
    isCanComeback = "",
    ---@type boolean
    isRepeat = "",
    ---@type boolean
    isAutoClose = "",
    ---@type boolean
    isCache = "",
    ---@type boolean
    isFallScreen = "",
}

---主界面
UiConstant.Main = {
    moduleConfig = LuaClass.ModuleConstant.Main,
    packageName = "MainView",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Bag = {
    moduleConfig = LuaClass.ModuleConstant.Bag,
    packageName = "Bag",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Basics = {
    moduleConfig = LuaClass.ModuleConstant.Basics,
    packageName = "Basics",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.List = {
    UiConstant.Bag,
    UiConstant.Basics,
}
return UiConstant