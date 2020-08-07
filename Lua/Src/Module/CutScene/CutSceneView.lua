---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class CutSceneView:BaseUi
local CutSceneView = class("CutSceneView", super)

local module = App.cutSceneModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
CutSceneView.uiConfig = LuaClass.UiConstant.CutScene

function CutSceneView:init()
    self.cutView = LuaClass.GuiUIPackage.CreateObject(self.uiConfig.packageName, "CutScene")
    self.cutView:SetSize(LuaClass.GuiGRoot.inst.width, LuaClass.GuiGRoot.inst.height)
    self.cutView:AddRelation(LuaClass.GuiGRoot.inst, LuaClass.GuiRelationType.Size)
    self.progressBar = self.cutView:GetChild("pb")
end

function CutSceneView:loadScene(sceneName)
    self.cutView.visible = true
    LuaClass.GuiGRoot.inst:AddChild(self.cutView)
    self.progressBar.value = 0
    local op = LuaClass.SceneManager.LoadSceneAsync(sceneName)
    self.time = App.timeManager:add(20, function()
        self.progressBar.value = self.progressBar.value + 1
        if op.isDone and self.progressBar.value >= 99 then
            self.cutView.visible = false
            App.timeManager:remove(self.time)
        end
    end, -1)
end

function CutSceneView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function CutSceneView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
    registerEventFunc(ui.n0, eventType.Click, function ()
        self:loadScene("scene1")
    end)
    registerEventFunc(ui.n1, eventType.Click, function ()
        self:loadScene("scene2")
    end)
end

function CutSceneView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function CutSceneView:closeView()
    if self.time then
        App.timeManager:remove(self.time)
    end
    module:closeView()
end

function CutSceneView:onExit()
    self:unRegisterEvent()
end

function CutSceneView:dispose()
    super.dispose(self)
end

return CutSceneView