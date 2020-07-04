---Author：  houn
---DATE：    2020/6/26
---DES:      UI配置加载文件

--[[
    参数配置：
    moduleConfig : ui资源的模块名称(必要参数)，参数为LuaClass.ModuleConstant中的枚举 eg.LuaClass.ModuleConstant.LOGIN
    cmpName : ui资源中的组件名称(必要参数)
    layerType : ui层级名称,默认值为 App.UiManager.LayerType.FixedLayer
    isRepeat ： 是否是可重复界面, 默认值是false,可重复界面只要在界面列表中，那么将不会从缓存中拿，而是直接创建
    isAutoClose : 界面是否会被自动关闭，默认是false,当值为false的时候，只有主动调App.UiManager:CloseView()关闭界面
    isCanBacked : 当该界面被覆盖时是否需要保留，让上层界面回退到当前界面 默认是true
    isCache : 界面是否需要被缓存
    isFallScreen : 是否是全屏界面
--]]

---@class UIConstant
local UIConstant = {}

---战斗界面
UIConstant.MAIN_VIEW = {
    moduleConfig = LuaClass.ModuleConstant.FIGHT,
    cmpName = "/NewFight2/Component/FightUI",
    layerType = App.UIManager.LayerType.FixedLayer,
    isCanBacked = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

return UIConstant