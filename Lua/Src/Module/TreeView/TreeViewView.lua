-- @Author: jow
-- @Date:   2020/8/5 10:11
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class TreeViewView:BaseUi
local TreeViewView = class("TreeViewView", super)

local module = App.treeViewModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
TreeViewView.uiConfig = LuaClass.UiConstant.TreeView

function TreeViewView:init()
end

function TreeViewView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function TreeViewView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function TreeViewView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function TreeViewView:closeView()
    module:closeView()
end

function TreeViewView:onExit()
    self:unRegisterEvent()
end

function TreeViewView:dispose()
    super.dispose(self)
end

return TreeViewView
