---Author：  houn
---DATE：    2020/6/26
---DES:      设置c#层的路径目录管理
local function setGlobalConfig()
    -- // 资源路径(Assets/)
    local config = CS.FairyStudy.AppConfig.Instance
    config.assetsPath = "GameAssets"
    -- /** 资源包输出路径*/
    config.assetsExportPath = "../Game"
    -- //AB包导出的先对目录
    config.assetBundleBuildRelPath = config.assetsExportPath.."/Res"
    -- // 脚本目录（AssetsExportPath/)
    config.scriptPath = "../Lua/Src"
    -- //AB包在streamAssets的目录
    config.streamingBundlesFolderName = "Res"
    -- //是否是加载AB包资源
    config.isLoadAssetBundle = true
    -- //是否是加载编辑器资源
    config.isEditorLoadAsset = true
    -- //运行文件导出目录
    config.exeExportPath = config.assetsExportPath.."../BinDev"
end

setGlobalConfig()