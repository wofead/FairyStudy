---Author：  houn
---DATE：    2020/6/26
---DES:      时间管理器

local LuaClass = LuaClass
local super = nil
---@class TimerManager
local TimerManager = class("TimerManager", super)

function TimerManager:ctor()
    --self.singleCoroutine = coroutine.create(handler(self, self.update))
    App:addEnterFrameHandler(handler(self, self.update))
    self.timeFuncCache = {}
    self.timeIndex = 0
end

function TimerManager:time(dt)

end

function TimerManager:update(dt)
    dt = dt * 1000
    for i, v in pairs(self.timeFuncCache) do
        if v[3] ~= -1 and v[5] >= v[3] then
            v[4]()
            self.timeFuncCache[i] = nil
        elseif v[5] >= v[6] * v[1] then
            v[6] = v[6] +1
            v[2](dt)
        end
        v[5] = v[5] + dt
    end
end

---@param internal number@毫秒
function TimerManager:add(internal, func, endTime, endFunc)
    self.timeIndex = self.timeIndex + 1
    self.timeFuncCache[self.timeIndex] = { internal, func, endTime, endFunc, 0, 0 }
    return self.timeIndex
end

function TimerManager:remove(timeIndex)
    self.timeFuncCache[timeIndex] = nil
end


return TimerManager