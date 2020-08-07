---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class EmitNumbersView:BaseUi
local EmitNumbersView = class("EmitNumbersView", super)

local module = App.emitNumbersModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
EmitNumbersView.uiConfig = LuaClass.UiConstant.EmitNumbers

function EmitNumbersView:init()
    self.hurtFont1 = "ui://EmitNumbers/number1"
    self.hurtFont2 = "ui://EmitNumbers/number2"
    self.criticalSign = "ui://EmitNumbers/critical"
    local layer = LuaClass.GuiGComponent()
    layer:setDisplayerName("Hp")
    LuaClass.GuiGRoot.inst:AddChild(layer)
    ---UI居中适配
    layer.width = LuaClass.GameConfig.CC_DESIGN_RESOLUTION.width
    layer.height = LuaClass.GameConfig.CC_DESIGN_RESOLUTION.height
    layer:Center(true)
    layer.fairyBatching  = true
end

function EmitNumbersView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function EmitNumbersView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function EmitNumbersView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function EmitNumbersView:closeView()
    module:closeView()
end

function EmitNumbersView:onExit()
    self:unRegisterEvent()
end

function EmitNumbersView:dispose()
    super.dispose(self)
end

return EmitNumbersView