-- @Author: jow
-- @Date:   2020/8/5 9:59
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class HeadBarView:BaseUi
local HeadBarView = class("HeadBarView", super)

local module = App.headBarModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
HeadBarView.uiConfig = LuaClass.UiConstant.HeadBar

function HeadBarView:init()
    self.npc1 = LuaClass.GameObject.Find("npc1").transform
    ---@type UnityEngine.GameObject
    local headBar1 = LuaClass.GameObject("headBar")
    local panel1 = headBar1:addUIToSelf("HeadBar", "HeadBar")
    headBar1.transform:SetParent(self.npc1, false)
    headBar1.transform.localPosition = LuaClass.Vector3(0, 1, 0)

    panel1.ui:GetChild("name").text = "Long [color=#FFFFFF]Long[/color][img]ui://HeadBar/cool[/img] Name"
    panel1.ui:GetChild("blood").value = 75
    panel1.ui:GetChild("sign").url = "ui://HeadBar/task"

    ---@type UnityEngine.GameObject
    local headBar2 = LuaClass.GameObject("headBar")
    local panel2 = headBar2:addUIToSelf("HeadBar", "HeadBar")
    self.npc2 = LuaClass.GameObject.Find("npc2").transform
    headBar2.transform:SetParent(self.npc2, false)
    headBar2.transform.localPosition = LuaClass.Vector3(0, 1, 0)
    panel2.ui:GetChild("name").text = "Man2"
    panel2.ui:GetChild("blood").value = 25
    panel2.ui:GetChild("sign").url = "ui://HeadBar/fighting"
end

function HeadBarView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function HeadBarView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function HeadBarView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function HeadBarView:closeView()
    module:closeView()
end

function HeadBarView:onExit()
    self:unRegisterEvent()
end

function HeadBarView:dispose()
    super.dispose(self)
end

return HeadBarView
