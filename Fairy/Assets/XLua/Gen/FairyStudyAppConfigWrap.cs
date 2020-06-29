#if USE_UNI_LUA
using LuaAPI = UniLua.Lua;
using RealStatePtr = UniLua.ILuaState;
using LuaCSFunction = UniLua.CSharpFunctionDelegate;
#else
using LuaAPI = XLua.LuaDLL.Lua;
using RealStatePtr = System.IntPtr;
using LuaCSFunction = XLua.LuaDLL.lua_CSFunction;
#endif

using XLua;
using System.Collections.Generic;


namespace XLua.CSObjectWrap
{
    using Utils = XLua.Utils;
    public class FairyStudyAppConfigWrap 
    {
        public static void __Register(RealStatePtr L)
        {
			ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			System.Type type = typeof(FairyStudy.AppConfig);
			Utils.BeginObjectRegister(type, L, translator, 0, 1, 10, 10);
			
			Utils.RegisterFunc(L, Utils.METHOD_IDX, "init", _m_init);
			
			
			Utils.RegisterFunc(L, Utils.GETTER_IDX, "assetBundleExt", _g_get_assetBundleExt);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "assetsPath", _g_get_assetsPath);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "assetsExportPath", _g_get_assetsExportPath);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "assetBundleBuildRelPath", _g_get_assetBundleBuildRelPath);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "scriptPath", _g_get_scriptPath);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "streamingBundlesFolderName", _g_get_streamingBundlesFolderName);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "exeExportPath", _g_get_exeExportPath);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "isLoadAssetBundle", _g_get_isLoadAssetBundle);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "isEditorLoadAsset", _g_get_isEditorLoadAsset);
            Utils.RegisterFunc(L, Utils.GETTER_IDX, "isDebug", _g_get_isDebug);
            
			Utils.RegisterFunc(L, Utils.SETTER_IDX, "assetBundleExt", _s_set_assetBundleExt);
            Utils.RegisterFunc(L, Utils.SETTER_IDX, "assetsPath", _s_set_assetsPath);
            Utils.RegisterFunc(L, Utils.SETTER_IDX, "assetsExportPath", _s_set_assetsExportPath);
            Utils.RegisterFunc(L, Utils.SETTER_IDX, "assetBundleBuildRelPath", _s_set_assetBundleBuildRelPath);
            Utils.RegisterFunc(L, Utils.SETTER_IDX, "scriptPath", _s_set_scriptPath);
            Utils.RegisterFunc(L, Utils.SETTER_IDX, "streamingBundlesFolderName", _s_set_streamingBundlesFolderName);
            Utils.RegisterFunc(L, Utils.SETTER_IDX, "exeExportPath", _s_set_exeExportPath);
            Utils.RegisterFunc(L, Utils.SETTER_IDX, "isLoadAssetBundle", _s_set_isLoadAssetBundle);
            Utils.RegisterFunc(L, Utils.SETTER_IDX, "isEditorLoadAsset", _s_set_isEditorLoadAsset);
            Utils.RegisterFunc(L, Utils.SETTER_IDX, "isDebug", _s_set_isDebug);
            
			
			Utils.EndObjectRegister(type, L, translator, null, null,
			    null, null, null);

		    Utils.BeginClassRegister(type, L, __CreateInstance, 1, 2, 1);
			
			
            
			Utils.RegisterFunc(L, Utils.CLS_GETTER_IDX, "Instance", _g_get_Instance);
            Utils.RegisterFunc(L, Utils.CLS_GETTER_IDX, "_instance", _g_get__instance);
            
			Utils.RegisterFunc(L, Utils.CLS_SETTER_IDX, "_instance", _s_set__instance);
            
			
			Utils.EndClassRegister(type, L, translator);
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int __CreateInstance(RealStatePtr L)
        {
            
			try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
				if(LuaAPI.lua_gettop(L) == 1)
				{
					
					FairyStudy.AppConfig gen_ret = new FairyStudy.AppConfig();
					translator.Push(L, gen_ret);
                    
					return 1;
				}
				
			}
			catch(System.Exception gen_e) {
				return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
			}
            return LuaAPI.luaL_error(L, "invalid arguments to FairyStudy.AppConfig constructor!");
            
        }
        
		
        
		
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _m_init(RealStatePtr L)
        {
		    try {
            
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
            
            
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
            
            
                
                {
                    
                    gen_to_be_invoked.init(  );
                    
                    
                    
                    return 0;
                }
                
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            
        }
        
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_Instance(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			    translator.Push(L, FairyStudy.AppConfig.Instance);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_assetBundleExt(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushstring(L, gen_to_be_invoked.assetBundleExt);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_assetsPath(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushstring(L, gen_to_be_invoked.assetsPath);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_assetsExportPath(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushstring(L, gen_to_be_invoked.assetsExportPath);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_assetBundleBuildRelPath(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushstring(L, gen_to_be_invoked.assetBundleBuildRelPath);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_scriptPath(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushstring(L, gen_to_be_invoked.scriptPath);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_streamingBundlesFolderName(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushstring(L, gen_to_be_invoked.streamingBundlesFolderName);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_exeExportPath(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushstring(L, gen_to_be_invoked.exeExportPath);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_isLoadAssetBundle(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushboolean(L, gen_to_be_invoked.isLoadAssetBundle);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_isEditorLoadAsset(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushboolean(L, gen_to_be_invoked.isEditorLoadAsset);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get_isDebug(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                LuaAPI.lua_pushboolean(L, gen_to_be_invoked.isDebug);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _g_get__instance(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			    translator.Push(L, FairyStudy.AppConfig._instance);
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 1;
        }
        
        
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_assetBundleExt(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.assetBundleExt = LuaAPI.lua_tostring(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_assetsPath(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.assetsPath = LuaAPI.lua_tostring(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_assetsExportPath(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.assetsExportPath = LuaAPI.lua_tostring(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_assetBundleBuildRelPath(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.assetBundleBuildRelPath = LuaAPI.lua_tostring(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_scriptPath(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.scriptPath = LuaAPI.lua_tostring(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_streamingBundlesFolderName(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.streamingBundlesFolderName = LuaAPI.lua_tostring(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_exeExportPath(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.exeExportPath = LuaAPI.lua_tostring(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_isLoadAssetBundle(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.isLoadAssetBundle = LuaAPI.lua_toboolean(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_isEditorLoadAsset(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.isEditorLoadAsset = LuaAPI.lua_toboolean(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set_isDebug(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			
                FairyStudy.AppConfig gen_to_be_invoked = (FairyStudy.AppConfig)translator.FastGetCSObj(L, 1);
                gen_to_be_invoked.isDebug = LuaAPI.lua_toboolean(L, 2);
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
        [MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
        static int _s_set__instance(RealStatePtr L)
        {
		    try {
                ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
			    FairyStudy.AppConfig._instance = (FairyStudy.AppConfig)translator.GetObject(L, 1, typeof(FairyStudy.AppConfig));
            
            } catch(System.Exception gen_e) {
                return LuaAPI.luaL_error(L, "c# exception:" + gen_e);
            }
            return 0;
        }
        
		
		
		
		
    }
}
