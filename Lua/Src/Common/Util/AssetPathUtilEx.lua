---Author：  houn
---DATE：    2020/6/26
---DES:      扩展C#层的资源获取管理类


---@class AssetPathUtilEx
local AssetPathUtilEx = {}

---获取资源的原始URL(富文本加载图片)
---@packageConf pkgCfg table @包参数（名字和位置） --   Login
---@param resName string @文件地址 --   /Res/enterBtn
function AssetPathUtilEx.getNormalizeUrl(packageConf, resName)
    local url = AssetPathUtilEx.getGLoaderURL(packageConf, resName)
    return LuaClass.GuiUIPackage.NormalizeURL(url)
end

---装载器设置url方法
---@param pkgCfg table @包的配置
---@param resName string @资源在包下面的路径
function AssetPathUtilEx.getGLoaderURL(packageConf, resName)
    return string.format("ui://%s//%s", packageConf.moduleName, resName)
end

function AssetPathUtilEx.getPackageUrl(packageConf)
    return string.format("GameAssets/UI/Module/%s/%s", packageConf.moduleName, packageConf.moduleName)
end

return AssetPathUtilEx