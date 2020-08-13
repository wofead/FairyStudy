-- @Author: jow
-- @Date:   2020/8/11 17:05
-- @Des:    
local LuaClass = LuaClass
local super = nil
---@class MailItemView
local MailItemView = class("MailItemView", super)

---@param btn FairyGUI.GButton
function MailItemView:ctor(go, btn)
    self.btn = btn
    self.timeText = btn:GetChild("timeText")
    self.isRead = btn:GetController("IsRead")
    self.c1 = btn:GetController("c1")
    self.t0 = btn:GetTransition("t0")
end

function MailItemView:setData(data, index)
    self:setFetched(data % 3 == 0)
    self:setRead(data % 2 == 0)
    self:setTime("5 Nov 2015 16:24:33")
    self:setTitle(data .. " Mail title here")
end

function MailItemView:setTime(value)
    self.timeText.text = value
end

function MailItemView:setRead(value)
    self.isRead.selectedIndex = value and 1 or 0
end

function MailItemView:setFetched(value)
    self.isRead.selectedIndex = value and 1 or 0
end

function MailItemView:setTitle(value)
    self.btn.title = value
end

function MailItemView:playEffect(delay)
    self.btn.visible = false
    self.t0:Play(1, delay, nil)
end

return MailItemView
