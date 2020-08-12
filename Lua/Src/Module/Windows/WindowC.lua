-- @Author: jow
-- @Date:   2020/8/12 12:22
-- @Des:
local LuaClass = LuaClass
local super = nil
---@class WindowC
local WindowC = class("WindowsA", super)

---@param window FairyGUI.Window
function WindowC:ctor(window)
    window:SetLuaTable(self)
    self.window = window
end

function WindowC:OnInit()
    self.window.contentPane = LuaClass.GuiUIPackage.CreateObject("ModalWaiting", "TestWin")
    self.window:Center()
    self.window.contentPane:GetChild("n1").onClick:Add(
            function()
                self.window:ShowModalWait()
                self.timer = App.timeManager:add(3000, function()
                end, 3000, function()
                    self.window:CloseModalWait()
                end)
            end)
end

function WindowC:OnShown()

end

function WindowC:show()
    self.window:Show()
end

function WindowC:OnHide()
    if self.timer then
        App.timeManager:remove(self.timer)
    end
end

return WindowC
