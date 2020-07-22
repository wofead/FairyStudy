---Author：  houn
---DATE：    2020/6/26
---DES:      模块常量


---@class ModuleConstant
local ModuleConstant = {
    moduleName = ""
}


ModuleConstant.Main = {
    moduleName = "mainModule",
}
ModuleConstant.Bag = {
    moduleName = "bagModule"
}
ModuleConstant.Basics = {
    moduleName = "basicsModule"

}


--- 模块数据请求
ModuleConstant.Data = {
    ---玩家信息
    ["Main"] = 1,
}

return ModuleConstant