---Author：  houn
---DATE：    2020/7/15
---DES:      主界面

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class MainView:BaseUi
local MainView = class("MainView", super)

local module = App.mainModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
MainView.uiConfig = LuaClass.UiConstant.Main

function MainView:onEnter()
    super.onEnter(self)
    self:registerEvent()
    self:init()
end

function MainView:init()
    ---@type FairyGUI.GList
    local list = self.ui.list
    list.itemRenderer = handler(self, self.renderListItem)
    list.numItems = #LuaClass.UiConstant.List
    list.onClickItem:Add(handler(self, self.onClickItem))
end

---@param index number
---@param obj FairyGUI.GButton
function MainView:renderListItem(index, obj)
    ---@type UiConstant
    local data = LuaClass.UiConstant.List[index + 1]
    obj.title = data.packageName
end

---@param context FairyGUI.EventContext
function MainView:onClickItem(context)
    local btn = context.data
    ---@type FairyGUI.GList
    local list = self.ui.list
    local index = list:GetChildIndex(btn)
    ---@type UiConstant
    local data = LuaClass.UiConstant.List[index + 1]
    ---@type BaseModule
    local module = App[data.moduleConfig.moduleName]
    module:showView()
end
function MainView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
end

function MainView:onButton(context)

end

function MainView:unRegisterEvent()

end

function MainView:onExit()
    self:unRegisterEvent()
end

function MainView:dispose()
    super.dispose(self)
end

return MainView