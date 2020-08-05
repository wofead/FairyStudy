---Author：  houn
---DATE：    2020/8/4
---DES:      bagwindow

local LuaClass = LuaClass
local super = nil
---@class BagWindow
local BagWindow = class("BagWindow", super)

---@param window FairyGUI.Window
function BagWindow:ctor(window)
    window:SetLuaTable(self)
    self.window = window
end

function BagWindow:OnInit()
    self.window.contentPane = LuaClass.GuiUIPackage.CreateObject("Bag", "BagWin")
    self.window:Center()
    self.window.modal = true
    ---@type FairyGUI.GList
    local list = self.window.contentPane:GetChild("list")
    list.onClickItem:Add(handler(self, self.clickItem))
    list.itemRenderer = handler(self, self.itemRenderer)
    list.numItems = 45
    self.list = list
    local pageItemCount = list.columnCount * list.lineCount
    printJow("BagWindow",pageItemCount)
    ---@type FairyGUI.GList
    local dotList = self.window.contentPane:GetChild("n25")
    dotList.onClickItem:Add(handler(self, self.clickDot))
    ---@type FairyGUI.Controller
    local controller = self.window.contentPane:GetController("page")
    controller:AddPage("2")
    controller:AddPage("3")
    self.controller = controller
    dotList.numItems = controller.pageCount
    self.dotList = dotList
    self.controller:SetSelectedIndex(0)
end

function BagWindow:OnShown()

end

function BagWindow:show()
    self.window:Show()
end

function BagWindow:itemRenderer(index, object)
    object:GetChild("icon").url = LuaClass.GuiUIPackage.GetItemURL("Bag", "i" .. math.random(0, 9))
    object.title = math.random(0, 100) .. ""
end

function BagWindow:clickItem(context)
    local item = context.data
    self.window.contentPane:GetChild("n11").url = item:GetChild("icon").url
    self.window.contentPane:GetChild("n13").text = item.title
end

function BagWindow:clickDot(context)
    ---@type FairyGUI.GButton
    local item = context.data
    local index = self.dotList:GetChildIndex(item)
    self.controller:SetSelectedIndex(index)
end

return BagWindow