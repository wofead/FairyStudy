using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace FairyStudy
{

    public class AppConfig
    {
        // 资源包后缀
        public string assetBundleExt = ".bytes";
        // 资源路径(Assets/)
        public string assetsPath = "GameAssets";
        /** 资源包输出路径*/
        public string assetsExportPath = "../";
        //AB包导出的先对目录
        public string assetBundleBuildRelPath = "/Bundles";
        // 脚本目录（AssetsExportPath/)
        public string scriptPath = "Lua";
        //AB包在streamAssets的目录
        public string streamingBundlesFolderName = "Bundles";
        //程序运行包体文件生成目录
        public string exeExportPath = "Bin1";
        //是否是加载AB包资源
        public bool isLoadAssetBundle = true;
        //是否是加载编辑器资源
        public bool isEditorLoadAsset = true;
        //是否是调试模式
        public bool isDebug = false;
        public static AppConfig _instance;
        public static AppConfig Instance
        {
            get
            {
                if (AppConfig._instance == null)
                {
                    AppConfig._instance = new AppConfig();
                    AppConfig._instance.init();
                }
                return AppConfig._instance;
            }
        }

        public void init()
        {
            // 资源包后缀
            assetBundleExt = ".drm";
            // 资源路径(Assets/)
            assetsPath = "GameAssets";
            /** 资源包输出路径*/
            assetsExportPath = "../";
            //AB包导出的先对目录
            assetBundleBuildRelPath = assetsExportPath + "/Res";
            // 脚本目录（AssetsExportPath/)
            scriptPath = "Src";
            //AB包在streamAssets的目录
            streamingBundlesFolderName = "Res";
            //是否是加载AB包资源
            isLoadAssetBundle = true;
            //是否是加载编辑器资源
            isEditorLoadAsset = true;
            //运行文件导出目录
            exeExportPath = assetsExportPath + "/../BinDev";
        }
    }
}
