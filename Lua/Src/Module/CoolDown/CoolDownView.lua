---Author：  houn
---DATE：    2020/8/5
---DES:

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class CoolDownView:BaseUi
local CoolDownView = class("CoolDownView", super)

local module = App.coolDownModule

local eventDispatcher = module.eventDispatcher

CoolDownView.uiConfig = LuaClass.UiConstant.CoolDown

function CoolDownView:init()
    local ui = self.ui
    --ui://y768eypfplan19
    --printJow("CoolDownView", LuaClass.GuiUIPackage.GetItemURL("Cooldown", "k0"), LuaClass.GuiUIPackage.GetItemURL("Cooldown", "k1"))
    ui.b0:GetChild("icon").url = LuaClass.GuiUIPackage.GetItemURL("Cooldown", "k0")
    ui.b1:GetChild("icon").url = LuaClass.GuiUIPackage.GetItemURL("Cooldown", "k1")
    self.mask1 = ui.b0:GetChild("mask")
    self.mask2 = ui.b1:GetChild("mask")
end

function CoolDownView:onEnter()
    self.time = App.timeManager:add(20, handler(self, self.update), -1)
    self.time1 = 5000
    self.time2 = 10000
    super.onEnter(self)
    self:registerEvent()
end

function CoolDownView:update()
    local ui = self.ui
    self.time1 = self.time1 - 20
    if self.time1 < 0 then
        self.time1 = 5000
    end
    self.mask1.fillAmount = 1 - (5 - self.time1 / 1000) / 5
    self.time2 = self.time2 - 20
    if self.time2 < 0 then
        self.time2 = 10000
    end
    ui.b1.text = "" .. math.ceil(self.time2 / 1000)
    self.mask2.fillAmount = 1 - (10000 - self.time2 / 1000) / 10000
end

function CoolDownView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function CoolDownView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function CoolDownView:closeView()
    if self.time then
        App.timeManager:remove(self.time)
    end
    module:closeView()
end

function CoolDownView:onExit()
    self:unRegisterEvent()
end

function CoolDownView:dispose()
    super.dispose(self)
end

return CoolDownView