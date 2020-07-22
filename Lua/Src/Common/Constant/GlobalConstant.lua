---Author：  houn
---DATE：    2020/7/7
---DES:      

local LuaClass = LuaClass
local super = nil
---@class GlobalConstant
local GlobalConstant = class("GlobalConstant", super)

---隐藏对象的层
GlobalConstant.HIDE_LAYER = LuaClass.LayerMask.NameToLayer("HideLayer")
---地图层
GlobalConstant.MAP_LAYER = LuaClass.LayerMask.NameToLayer("Map")
---UI层
GlobalConstant.UI_LAYER = LuaClass.LayerMask.NameToLayer("UI")
---UI层
GlobalConstant.DEFAULT_LAYER = LuaClass.LayerMask.NameToLayer("Default")
---头像获取层
GlobalConstant.AVATAR = LuaClass.LayerMask.NameToLayer("Avatar")


return GlobalConstant