---Author：  houn
---DATE：    2020/8/12
---DES:      

local LuaClass = LuaClass
local super = nil
---@class WindowD
local WindowD = class("WindowD", super)

---@param window FairyGUI.Window
function WindowD:ctor(window)
    window:SetLuaTable(self)
    self.window = window
end

function WindowD:OnInit()
    self.window.contentPane = LuaClass.GuiUIPackage.CreateObject("RenderTexture", "TestWin")
    self.window:Center()
    ---@type RenderImage
    local renderImage = LuaClass.RenderImage(self.window.contentPane:GetChild("holder"))
    self.renderImage = renderImage
    renderImage:setBackGround(self.window.contentPane:GetChild("frame"):GetChild("n0"), self.window.contentPane:GetChild("n20"))
    --local renderImage = LuaClass.RenderImage(self.window.contentPane:GetChild("frame"):GetChild("n0"))
    self.window.contentPane:GetChild("btnLeft").onTouchBegin:Add(handler(self, self.onClickLeft))
    self.window.contentPane:GetChild("btnRight").onTouchBegin:Add(handler(self, self.onClickRight))
end

function WindowD:onClickLeft()
    self.renderImage:startRotate(-2)
    LuaClass.GuiStage.inst.onTouchEnd:Add(handler(self, self.onTouchEnd))
end

function WindowD:onClickRight()
    self.renderImage:startRotate(2)
    LuaClass.GuiStage.inst.onTouchEnd:Add(handler(self, self.onTouchEnd))
end

function WindowD:onTouchEnd()
    self.renderImage:stopRotate()
    LuaClass.GuiStage.inst.onTouchEnd:Remove(handler(self, self.onTouchEnd))
end

function WindowD:OnShown()
    self.renderImage:loadModel("Cube")
    self.renderImage.modelRoot.localPosition = LuaClass.Vector3(0, -1, 5)
    self.renderImage.modelRoot.localScale = LuaClass.Vector3(1, 1, 1)
    self.renderImage.modelRoot.localRotation = LuaClass.Quaternion.Euler(0, 120, 1)
end

function WindowD:show()
    self.window:Show()
end

return WindowD