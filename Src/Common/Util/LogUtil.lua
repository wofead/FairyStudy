---Author：  houn
---DATE：    2020/6/26
---DES:      日志类

---@class LogUtil
local LogUtil = {}

local LogColor = {
    RED = "red",
    BLUE = "blue",
    YELLOW = "yellow",
    PURPLE = "purple",
    ORANGE = "orange",
    GREY = "grey",
    WHITE = "white",
    GREEN = "green"
}

local LogConfig = {
    SHOW_ALL = 1, --显示所有人日志
    NONE = 2, --不显示日志
    PERSONAL = 3 --显示个人日志
}

LogUtil.users = {
    printJow = {
        author = "jow",
        color = LogColor.PURPLE,
        isOpen = true
    }
}

--清空日志
local clear = {}

LogUtil.config = LogConfig.PERSONAL

local _print = print

print = function(...)
    if LogUtil.config == LogConfig.NONE then
        return
    else
        _print("", ...)
    end
end


local function __serialize(t, only_field)
    if type(t) == "string" then
        return t
    end
    local mark = {}
    local assign = {}

    local function tb(len)
        local ret = ""
        while len > 1 do
            ret = table.concat({ ret, "     " })
            len = len - 1
        end
        if len >= 1 then
            ret = table.concat({ ret, "|---" })
        end
        return ret
    end

    local function table2str(t, parent, deep)
        deep = deep or 0
        mark[t] = parent
        local ret = {}
        -- table.foreach(t, function(f, v)
        for f, v in pairs(t) do
            local k = type(f) == "number" and table.concat({ "[", f, "]" }) or tostring(f)
            local dotkey = table.concat({ parent, (type(f) == "number" and k or table.concat({ ".", k })) })
            local t = type(v)
            if t == "userdata" or t == "function" or t == "thread" or t == "proto" or t == "upval" then
                if not only_field then
                    table.insert(ret, string.format("%s=%q", k, tostring(v)))
                end
            elseif t == "table" then
                if mark[v] then
                    table.insert(assign, table.concat({ dotkey, "=", mark[v] }))
                else
                    table.insert(ret, string.format("%s=%s", k, table2str(v, dotkey, deep + 1)))
                end
            elseif t == "string" then
                table.insert(ret, string.format("%s=%q", k, v))
            elseif t == "number" then
                if v == math.huge then
                    table.insert(ret, string.format("%s=%s", k, "math.huge"))
                elseif v == -math.huge then
                    table.insert(ret, string.format("%s=%s", k, "-math.huge"))
                else
                    table.insert(ret, string.format("%s=%s", k, tostring(v)))
                end
            else
                table.insert(ret, string.format("%s=%s", k, tostring(v)))
            end
        end
        -- end)
        return table.concat({ "{\n", tb(deep + 1), table.concat(ret, table.concat({ ",\n", tb(deep + 1) })), "\n", tb(deep), "}" })
    end

    if type(t) == "table" then
        return string.format("%s%s", table2str(t, "_"), table.concat(assign, " "))
    else
        return tostring(t)
    end
end

local function _getLog(str, ...)
    str = tostring(str)
    local prams = { ... }
    if prams then
        for k, v in pairs(prams) do
            local index = k - 1
            str = string.gsub(str, table.concat({ "{", index, "}" }), tostring(v))
        end
    end
    local luastr = str or ""
    for key, value in ipairs { ... } do
        if type(value) == "string" or type(value) == "number" then
            luastr = table.concat({ luastr, value, "\t" })
        elseif type(value) == "table" then
            luastr = table.concat({ luastr, __serialize(value) })
        else
            if value then
                luastr = table.concat({ luastr, "true", "\t" })
            else
                luastr = table.concat({ luastr, "false", "\t" })
            end
        end
    end
    return luastr
end

local function getStr(...)
    local params = {}
    return _getLog(__serialize(params))
end

local function _PersonalPrint(info, ...)
    if LogUtil.config == LogConfig.NONE then
        return
    end
    if LogUtil.config == LogConfig.PERSONAL and not info.isOpen then
        return
    end
    local result = '[' .. os.date() .. ']' .. getStr(...)
    local msg = result
    msg = "\n" ..msg
    _print(info.color, msg)
end


for k, v in pairs(LogUtil.users) do
    _G[k] = function(...)
        if v.isOpen then
            if not clear[v.author] then
                clear[v.author] = true
                local path = ""
                os.remove(path)
            end
        end
        _PersonalPrint(v, ...)
    end
end


return LogUtil