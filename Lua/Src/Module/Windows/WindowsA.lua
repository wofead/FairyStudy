---Author：  houn
---DATE：    2020/7/25
---DES:      

local LuaClass = LuaClass
local super = nil
---@class WindowsA
local WindowsA = class("WindowsA", super)

---@param window FairyGUI.Window 
function WindowsA:ctor(window)
    window:SetLuaTable(self)
    self.window = window
end

function WindowsA:OnInit()
    self.window.contentPane = LuaClass.GuiUIPackage.CreateObject("Basics", "WindowA")
    self.window:Center()
end

function WindowsA:OnShown()
    ---@type FairyGUI.GList
    local list = self.window.contentPane:GetChild("n6")
    list:RemoveChildrenToPool()
    for i = 1, 10 do
        local item = list:AddItemFromPool()
        item.title = "" .. i
        item.icon = LuaClass.GuiUIPackage.GetItemURL("Basics", "r4")
    end
end

function WindowsA:show()
    self.window:Show()
end

return WindowsA