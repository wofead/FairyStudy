---Author：  houn
---DATE：    2020/7/25
---DES:      

local LuaClass = LuaClass
local super = nil
---@class WindowsB
local WindowsB = class("WindowsB", super)

---@param window FairyGUI.Window
function WindowsB:ctor(window)
    window:SetLuaTable(self)
    self.window = window
end

function WindowsB:OnInit()
    self.window.contentPane = LuaClass.GuiUIPackage.CreateObject("Basics", "WindowB")
    self.window:Center()
end

function WindowsB:DoShowAnimation()
    self.window:SetScale(0.1, 0.1)
    self.window:SetPivot(0.5, 0.5)
    self.window:TweenScale(LuaClass.Vector2(1, 1), 0.3):OnComplete(handler(self, self.OnShown))
end

function WindowsB:DoHideAnimation()
    self.window:TweenScale(LuaClass.Vector2(0.1, 0.1), 0.3):OnComplete(handler(self, self.HideImmediately))
end

function WindowsB:OnShown()
    self.window.contentPane:GetTransition("t1"):Play()
end

function WindowsB:HideImmediately()
    self.window:HideImmediately()
end

function WindowsB:OnHide()
    self.window.contentPane:GetTransition("t1"):Stop()
end

function WindowsB:show()
    self.window:Show()
end

return WindowsB