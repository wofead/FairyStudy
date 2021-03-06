---Author：  houn
---DATE：    2020/6/27
---DES:      拓展类

---@class Extension
local Extension = {}

local function ex(t, ctype)
    local meta = xlua.getmetatable(ctype)
    local mt = {}
    for k, v in pairs(meta) do
        mt[k] = v
    end
    mt.__index = function(o, k)
        if mt[k] then
            return mt[k]
        elseif mt[o] and mt[o][k] then
            return mt[o][k]
        else
            return meta.__index(o, k)
        end
    end
     if ctype == CS.UnityEngine.GameObject then
        mt.__newindex = function(o,k,v)
            if mt[o] == nil then
                mt[o] = {}
                mt[o][k] = v
                o:addLuaComponent()
            else
                mt[o][k] = v
            end
        end
     end
    xlua.setmetatable(ctype, mt)
    return mt
end
setmetatable(Extension, {__call = ex})

return Extension