---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by houn.
--- DateTime: 2020/6/22 20:25
--- 游戏主应用类

local super = nil
---@class App
local App = class("App", super)

function App:init()
    ---@type EventBeat
    self.updateBeat = LuaClass.EventBeat("UpdateBeat")
    ---@type EventBeat
    self.fixedUpdateBeat = LuaClass.EventBeat("FixedUpdateBeat")
    ---@type EventBeat
    self.lateUpdateBeat = LuaClass.EventBeat("LateUpdateBeat")

    self.autoReleaseObjects = {}

    self.mainCamera = LuaClass.GameObject.Find("Main Camera"):GetComponent(typeof(LuaClass.Camera))

    self:initManager()

    self:initModule()

    self:gameStart()
end

function App:autoRelease(gameObject)
    self.autoReleaseObjects[gameObject] = gameObject
end

function App:cancelAutoRelease(gameObject)
    self.autoReleaseObjects[gameObject] = nil
end

function App:update(deltaTime)
    self.updateBeat:update(deltaTime)
    for go, _ in ipairs(self.autoReleaseObjects) do
        self.autoReleaseObjects[go] = nil
        if isValid(go) then
            LuaClass.Object.Destroy(go)
        end
    end
    --每一帧清理需要自动释放的表
    table.recoveryTable()
end

function App:fixedUpdate(fixedDeltaTime)
    self.fixedUpdateBeat:update(fixedDeltaTime)
end

function App:lateUpdate()
    self.lateUpdateBeat:update()
end

function App:addEnterFrameHandler(enterFrameHandler)
    self.updateBeat:add(enterFrameHandler)
end

function App:removeEnterFrameHandler(enterFrameHandler)
    self.updateBeat:remove(enterFrameHandler)
end

function App:initManager()
    ---@type EventDispatcher
    self.globalEventDispatcher = LuaClass.EventDispatcher()
    ---@type UiManager
    self.uiManager = LuaClass.UiManager()
    ---@type KeyManager
    self.keyManager = LuaClass.KeyManager()
    ---@type TimerManager
    self.timeManager = LuaClass.TimerManager()
    ---@type PoolManager
    self.poolManager = LuaClass.PoolManager()
end

function App:initModule()
    ---@type MainModule
    self.mainModule = LuaClass.MainModule()
    ---@type BasicsModule
    self.basicsModule = LuaClass.BasicsModule()
    ---@type BagModule
    self.bagModule = LuaClass.BagModule()
    ---@type BundleUsageModule
    self.bundleUsageModule = LuaClass.BundleUsageModule()
    ---@type CoolDownModule
    self.coolDownModule = LuaClass.CoolDownModule()
    ---@type CurveModule
    self.curveModule = LuaClass.CurveModule()
    ---@type CutSceneModule
    self.cutSceneModule = LuaClass.CutSceneModule()
    ---@type EmitNumbersModule
    self.emitNumbersModule = LuaClass.EmitNumbersModule()
    ---@type EmojiModule
    self.emojiModule = LuaClass.EmojiModule()
    ---@type ExtensionModule
    self.extensionModule = LuaClass.ExtensionModule()
    ---@type FilterModule
    self.filterModule = LuaClass.FilterModule()
    ---@type GestureModule
    self.gestureModule = LuaClass.GestureModule()
    ---@type GuideModule
    self.guideModule = LuaClass.GuideModule()
    ---@type HeadBarModule
    self.headBarModule = LuaClass.HeadBarModule()
    ---@type HitTestModule
    self.hitTestModule = LuaClass.HitTestModule()
    ---@type JoyStickModule
    self.joyStickModule = LuaClass.JoyStickModule()
    ---@type LoopListModule
    self.loopListModule = LuaClass.LoopListModule()
    ---@type ModalWaitingModule
    self.modalWaitingModule = LuaClass.ModalWaitingModule()
    ---@type ModelModule
    self.modelModule = LuaClass.ModelModule()
    ---@type ParticlesModule
    self.particlesModule = LuaClass.ParticlesModule()
    ---@type PerspectiveModule
    self.perspectiveModule = LuaClass.PerspectiveModule()
    ---@type PullToRefreshModule
    self.pullToRefreshModule = LuaClass.PullToRefreshModule()
    ---@type RenderTextureModule
    self.renderTextureModule = LuaClass.RenderTextureModule()
    ---@type ScrollPaneModule
    self.scrollPaneModule = LuaClass.ScrollPaneModule()
    ---@type TransitionModule
    self.transitionModule = LuaClass.TransitionModule()
    ---@type TreeViewModule
    self.treeViewModule = LuaClass.TreeViewModule()
    ---@type TurnCardModule
    self.turnCardModule = LuaClass.TurnCardModule()
    ---@type TurnPageModule
    self.turnPageModule = LuaClass.TurnPageModule()
    ---@type TypingEffectModule
    self.typingEffectModule = LuaClass.TypingEffectModule()
    ---@type VirtualListModule
    self.virtualListModule = LuaClass.VirtualListModule()
end

function App:gameStart()
    ---@type GameStart
    local gameStart = LuaClass.GameStart:NewGameObject()
end

function App:quit()
    self._isQuitting = true
    print("退出游戏")
end

function App:isQuitting()
    return self._isQuitting
end

function App:restart()
    print("重新启动游戏")
end

return App

