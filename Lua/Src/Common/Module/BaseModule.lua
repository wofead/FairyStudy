---Author：  houn
---DATE：    2020/7/5
---DES:      模块类的基础类

local LuaClass = LuaClass
local super = nil
---@class BaseModule
local BaseModule = class("BaseModule", super)
function BaseModule:ctor()
    ---@type EventDispatcher
    self.eventDispatcher = LuaClass.EventDispatcher()
    -- 模块内的监听事件的注册
    self:registerModuleEventListener()
    -- 全局监听事件的注册
    self:registerGlobalEventListener()
end

function BaseModule:showView()
    
end

---注册本模块的事件列表
function BaseModule:registerModuleEventListener()
end

---注册全局侦听事件列表
function BaseModule:registerGlobalEventListener()
end

function BaseModule:registerEventListener(eventId, cb, cbOwner)
    self.eventDispatcher:addEventListener(eventId, cb, cbOwner)
end

function BaseModule:disPatcherEvent(eventId, ...)
    self.eventDispatcher:dispatchEvent(eventId, ...)
end

return BaseModule