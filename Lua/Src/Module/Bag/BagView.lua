---Author：  houn
---DATE：    2020/7/19
---DES:      背包界面

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class BagView:BaseUi
local BagView = class("BagView", super)
local module = App.bagModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
BagView.uiConfig = LuaClass.UiConstant.Bag

function BagView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function BagView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
end

function BagView:unRegisterEvent()

end

function BagView:onExit()
    self:unRegisterEvent()
end

function BagView:dispose()
    super.dispose(self)
end
return BagView