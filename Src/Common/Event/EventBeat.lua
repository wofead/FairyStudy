---Author：  houn
---DATE：    2020/6/26
---DES:      用来管理C#层传来的各种更新的事件
-- 主要用来处理，在事件处理流程中可能增删事件，所以触发时需先统合为一列表再执行

local LuaClass = LuaClass
local super = nil
---@class EventBeat
local EventBeat = class("EventBeat", super)

function EventBeat:ctor(name)
    self.name = name
    self.list = {}
    self.addList = {}
    self.removeDict = {}
    self.lock = false
end

function EventBeat:update(...)
    if self.lock then
        return
    end
    self.lock = true

    for _, fun in ipairs(self.list) do
        if not self.removeDict[fun] then
            fun(...)
        end
    end

    for _, fun in pairs(self.removeDict) do
        table.removeByValue(self.list, fun, false)
    end

    for _, fun in ipairs(self.addList) do
        if table.indexof(self.list, fun) == -1 then
            table.insert(self.list, fun)
        end
    end
    table.clear(self.removeDict)
    table.clear(self.addList)
    self.lock = false
end

function EventBeat:add(fun)
    if not fun then
        return
    end
    if self.lock then
        table.insert(self.addList, fun)
    else
        table.insert(self.list, fun)
    end
end

function EventBeat:remove(fun)
    if not fun then
        return
    end
    if self.lock then
        self.removeDict[fun] = true
    else
        table.removeByValue(self.list, fun, false)
    end
end

function EventBeat:removeAll()
    for _, fun in ipairs(self.list) do
        if fun then
            self:remove(fun)
        end
    end
    table.clear(self.addList)
end

---@return number
function EventBeat:length()
    return #self.list + #self.addList
end

return EventBeat