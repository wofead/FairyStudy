---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class FilterView:BaseUi
local FilterView = class("FilterView", super)

local module = App.filterModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
FilterView.uiConfig = LuaClass.UiConstant.Filter

function FilterView:init()
end

function FilterView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function FilterView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function FilterView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function FilterView:closeView()
    module:closeView()
end

function FilterView:onExit()
    self:unRegisterEvent()
end

function FilterView:dispose()
    super.dispose(self)
end

return FilterView