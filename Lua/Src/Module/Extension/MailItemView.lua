-- @Author: jow
-- @Date:   2020/8/11 17:05
-- @Des:    
local LuaClass = LuaClass
local super = nil
---@class MailItemView
local MailItemView = class("MailItemView", super)

function MailItemView:ctor(view)
    self.view = view
end

function MailItemView:mailTest()
    return 1,2,3
end

return MailItemView
