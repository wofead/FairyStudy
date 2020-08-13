-- @Author: jow
-- @Date:   2020/8/5 10:11
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class TurnCardView:BaseUi
local TurnCardView = class("TurnCardView", super)

local module = App.turnCardModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
TurnCardView.uiConfig = LuaClass.UiConstant.TurnCard

function TurnCardView:init()
    ---@type CardItemView
    self.c0 = self.ui.c0.displayObject.gameObject:addLuaComponent(LuaClass.CardItemView, self.ui.c0)
    ---@type CardItemView
    self.c1 = self.ui.c1.displayObject.gameObject:addLuaComponent(LuaClass.CardItemView, self.ui.c1)
    self.c1:setPerspective()
end

function TurnCardView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function TurnCardView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
    registerEventFunc(ui.c0, eventType.Click, handler(self, self.onClickCard))
    registerEventFunc(ui.c1, eventType.Click, handler(self, self.onClickCard))
end

function TurnCardView:onClickCard(context)
    local obj = context.sender.displayObject.gameObject
    ---@type CardItemView
    local cardItemView = obj:getLuaComponent(LuaClass.CardItemView)
    cardItemView:turn()
end

function TurnCardView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function TurnCardView:closeView()
    module:closeView()
end

function TurnCardView:onExit()
    self:unRegisterEvent()
end

function TurnCardView:dispose()
    super.dispose(self)
end

return TurnCardView
