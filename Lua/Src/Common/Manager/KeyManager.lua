---Author：  houn
---DATE：    2020/6/26
---DES:      快捷键管理类

local LuaClass = LuaClass
local super = nil
---@class KeyManager
local KeyManager = class("KeyManager", super)

function KeyManager:ctor()
    self:init()
end

function KeyManager:init()
    ---@type table<number,EventBeat>
    self.pressBeatList = {}
    ---@type table<number,EventBeat>
    self.releaseBeatList = {}
    self:defaultKeyList()
    App:addEnterFrameHandler(handler(self, self.update))
end

function KeyManager:update(dt)
    for key, eventBeat in pairs(self.pressBeatList) do
        if LuaClass.Input.GetKeyDown(key) then
            eventBeat:update(dt)
        end
    end

    for key, eventBeat in pairs(self.releaseBeatList) do
        if LuaClass.Input.GetKeyUp(key) then
            eventBeat:update(dt)
        end
    end
end

function KeyManager:registerPressHandler(code, codeString, handler)
    local eventBeat = self.pressBeatList[code]
    if not isValid(eventBeat) then
        eventBeat = LuaClass.EventBeat("KeyPress" .. codeString)
        self.pressBeatList[code] = eventBeat
    end
    eventBeat:add(handler)
end

function KeyManager:registerReleaseHandler(code, codeString, handler)
    local eventBeat = self.releaseBeatList[code]
    if not isValid(eventBeat) then
        eventBeat = LuaClass.EventBeat("KeyRelease" .. codeString)
        self.releaseBeatList[code] = eventBeat
    end
    eventBeat:add(handler)
end

function KeyManager:unregisterPressHandler(code, handler)
    local eventBeat = self.pressBeatList[code]
    if isValid(eventBeat) then
        eventBeat:remove(handler)
    end
end

function KeyManager:unregisterReleaseHandler(code, handler)
    local eventBeat = self.releaseBeatList[code]
    if isValid(eventBeat) then
        eventBeat:remove(handler)
    end
end

function KeyManager:defaultKeyList()
    self:registerPressHandler(LuaClass.KeyCode.F5, "F5", function()
        --清理内存中的文件
        LuaClass.clearLua("Debug")
        --require的会执行里面的代码
        local a = LuaClass.Debug
    end)
    self:registerPressHandler(LuaClass.KeyCode.F6, "F6", function()
        App:restart()
    end)
end

return KeyManager