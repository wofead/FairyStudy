-- @Author: jow
-- @Date:   2020/8/5 10:07
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class RenderTextureView:BaseUi
local RenderTextureView = class("RenderTextureView", super)

local module = App.renderTextureModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
RenderTextureView.uiConfig = LuaClass.UiConstant.RenderTexture

function RenderTextureView:init()
end

function RenderTextureView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function RenderTextureView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function RenderTextureView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function RenderTextureView:closeView()
    module:closeView()
end

function RenderTextureView:onExit()
    self:unRegisterEvent()
end

function RenderTextureView:dispose()
    super.dispose(self)
end

return RenderTextureView
