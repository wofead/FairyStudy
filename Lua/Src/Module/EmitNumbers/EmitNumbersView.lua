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
    local layer = LuaClass.GuiGComponent()
    self.view:AddChild(layer)
    layer.name = "Hp"
    ---UI居中适配
    layer.width = LuaClass.GameConfig.CC_DESIGN_RESOLUTION.width
    layer.height = LuaClass.GameConfig.CC_DESIGN_RESOLUTION.height
    layer:Center(true)
    layer.fairyBatching = true
    self.layer = layer
end

function EmitNumbersView:initScene()
    self.npc1 = LuaClass.GameObject.Find("npc1").transform
    self.npc2 = LuaClass.GameObject.Find("npc2").transform
    self.timerEmit = App.timeManager:add(300, function()
        ---@type EmitComponent
        local emitComponent1 = App.poolManager:popComponent(LuaClass.EmitComponent)
        self.layer:AddChild(emitComponent1.component)
        emitComponent1.component.visible = true
        emitComponent1:onHpChange(self.npc1, 0, math.random(100, 100000), math.random(1, 10) == 5)
        ---@type EmitComponent
        local emitComponent2 = App.poolManager:popComponent(LuaClass.EmitComponent)
        self.layer:AddChild(emitComponent2.component)
        emitComponent2.component.visible = true
        emitComponent2:onHpChange(self.npc2, 1, math.random(100, 100000), math.random(1, 10) == 5)
    end, -1)
end

function EmitNumbersView:onEnter()
    super.onEnter(self)
    local op = LuaClass.SceneManager.LoadSceneAsync("scene3")
    self.timer = App.timeManager:add(20, function()
        if op.isDone then
            self:initScene()
            App.timeManager:remove(self.timer)
        end
    end, -1)
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
    local op = LuaClass.SceneManager.LoadSceneAsync("SampleScene")
    self.timer = App.timeManager:add(20, function()
        if op.isDone then
            App.timeManager:remove(self.timer)
            module:closeView()
        end
    end, -1)
end

function EmitNumbersView:onExit()
    self:unRegisterEvent()
end

function EmitNumbersView:dispose()
    super.dispose(self)
end

return EmitNumbersView