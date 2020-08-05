-- @Author: jow
-- @Date:   2020/8/5 10:06
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class PullToRefreshView:BaseUi
local PullToRefreshView = class("PullToRefreshView", super)

local module = App.pullToRefreshModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
PullToRefreshView.uiConfig = LuaClass.UiConstant.PullToRefresh

function PullToRefreshView:init()
end

function PullToRefreshView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function PullToRefreshView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function PullToRefreshView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function PullToRefreshView:closeView()
    module:closeView()
end

function PullToRefreshView:onExit()
    self:unRegisterEvent()
end

function PullToRefreshView:dispose()
    super.dispose(self)
end

return PullToRefreshView
