---Author：  houn
---DATE：    2020/6/26
---DES:      事件派发管理函数

local LuaClass = LuaClass
local super = nil
---@class EventDispatcher
local EventDispatcher = class("EventDispatcher", super)

function EventDispatcher:ctor(isDebug)
    self._isDebug = isDebug
    ---@type table<string, EventBeat>
    self._eventListenerDic = {}
end

function EventDispatcher:addEventListener(eventId, cb, cbOwner)
    if self._isDebug then
        print("addEventListener---------", eventId)
    end

    if cbOwner ~= nil then
        cb = handler(cbOwner, cb)
    end

    if self._eventListenerDic[eventId] == nil then
        self._eventListenerDic[eventId] = LuaClass.EventBeat(eventId .. "")
    end

    local eventBeat = self._eventListenerDic[eventId]
    eventBeat:add(cb)
    return self
end

function EventDispatcher:removeEventListener(eventId, cb, cdOwner)
    if cbOwner ~= nil then
        cb = handler(cdOwner, cb)
    end
    local eventBeat = self._eventListenerDic[eventId]
    if eventBeat then
        eventBeat:remove(cb)
    end
end

function EventDispatcher:removeAllEventListener()
    for key, value in pairs(self._eventListenerDic) do
        value:removeAll()
    end
end

function EventDispatcher:dispatchEvent(eventId, ...)
    if not self._eventListenerDic[eventId] then
        return
    end
    local eventBeat = self._eventListenerDic[eventId]
    eventBeat:update(...)
end

function EventDispatcher:hasListener(eventId)
    if self._eventListenerDic and self._eventListenerDic[eventId] and #self._eventListenerDic[eventId]:length() > 0 then
        return true
    end
    return false
end

return EventDispatcher