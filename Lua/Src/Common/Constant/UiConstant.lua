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

UiConstant.BundleUsage = {
    moduleConfig = LuaClass.ModuleConstant.BundleUsage,
    packageName = "BundleUsage",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.CoolDown = {
    moduleConfig = LuaClass.ModuleConstant.CoolDown,
    packageName = "CoolDown",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Curve = {
    moduleConfig = LuaClass.ModuleConstant.Curve,
    packageName = "Curve",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.CutScene = {
    moduleConfig = LuaClass.ModuleConstant.CutScene,
    packageName = "CutScene",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.EmitNumbers = {
    moduleConfig = LuaClass.ModuleConstant.EmitNumbers,
    packageName = "EmitNumbers",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Emoji = {
    moduleConfig = LuaClass.ModuleConstant.Emoji,
    packageName = "Emoji",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Extension = {
    moduleConfig = LuaClass.ModuleConstant.Extension,
    packageName = "Extension",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Filter = {
    moduleConfig = LuaClass.ModuleConstant.Filter,
    packageName = "Filter",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Gesture = {
    moduleConfig = LuaClass.ModuleConstant.Gesture,
    packageName = "Gesture",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Guide = {
    moduleConfig = LuaClass.ModuleConstant.Guide,
    packageName = "Guide",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.HeadBar = {
    moduleConfig = LuaClass.ModuleConstant.HeadBar,
    packageName = "HeadBar",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.HitTest = {
    moduleConfig = LuaClass.ModuleConstant.HitTest,
    packageName = "HitTest",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.JoyStick = {
    moduleConfig = LuaClass.ModuleConstant.JoyStick,
    packageName = "Joystick",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.LoopList = {
    moduleConfig = LuaClass.ModuleConstant.LoopList,
    packageName = "LoopList",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.ModalWaiting = {
    moduleConfig = LuaClass.ModuleConstant.ModalWaiting,
    packageName = "ModalWaiting",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Model = {
    moduleConfig = LuaClass.ModuleConstant.Model,
    packageName = "Model",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Particles = {
    moduleConfig = LuaClass.ModuleConstant.Particles,
    packageName = "Particles",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Perspective = {
    moduleConfig = LuaClass.ModuleConstant.Perspective,
    packageName = "Perspective",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.PullToRefresh = {
    moduleConfig = LuaClass.ModuleConstant.PullToRefresh,
    packageName = "PullToRefresh",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.RenderTexture = {
    moduleConfig = LuaClass.ModuleConstant.RenderTexture,
    packageName = "RenderTexture",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.ScrollPane = {
    moduleConfig = LuaClass.ModuleConstant.ScrollPane,
    packageName = "ScrollPane",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.Transition = {
    moduleConfig = LuaClass.ModuleConstant.Transition,
    packageName = "Transition",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.TreeView = {
    moduleConfig = LuaClass.ModuleConstant.TreeView,
    packageName = "TreeView",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.TurnCard = {
    moduleConfig = LuaClass.ModuleConstant.TurnCard,
    packageName = "TurnCard",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.TurnPage = {
    moduleConfig = LuaClass.ModuleConstant.TurnPage,
    packageName = "TurnPage",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.TypingEffect = {
    moduleConfig = LuaClass.ModuleConstant.TypingEffect,
    packageName = "TypingEffect",
    componentName = "Main",
    layerType = App.uiManager.LayerType.FixedLayer,
    isCanComeback = true,
    isRepeat = false,
    isAutoClose = false,
    isCache = false,
    isFallScreen = true,
}

UiConstant.VirtualList = {
    moduleConfig = LuaClass.ModuleConstant.VirtualList,
    packageName = "VirtualList",
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
    UiConstant.BundleUsage,
    UiConstant.CoolDown,
    UiConstant.Curve,
    UiConstant.CutScene,
    UiConstant.EmitNumbers,
    UiConstant.Emoji,
    UiConstant.Extension,
    UiConstant.Filter,
    UiConstant.Gesture,
    UiConstant.Guide,
    UiConstant.HeadBar,
    UiConstant.HitTest,
    UiConstant.JoyStick,
    UiConstant.LoopList,
    UiConstant.ModalWaiting,
    UiConstant.Model,
    UiConstant.Particles,
    UiConstant.Perspective,
    UiConstant.PullToRefresh,
    UiConstant.RenderTexture,
    UiConstant.ScrollPane,
    UiConstant.Transition,
    UiConstant.TreeView,
    UiConstant.TurnCard,
    UiConstant.TurnPage,
    UiConstant.TypingEffect,
    UiConstant.VirtualList,
}
return UiConstant