-- @Author: jow
-- @Date:   2020/8/5 10:11
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class TurnPageView:BaseUi
local TurnPageView = class("TurnPageView", super)

local module = App.turnPageModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
TurnPageView.uiConfig = LuaClass.UiConstant.TurnPage

function TurnPageView:init()
    ---@type BookView
    local book = self.ui.book.displayObject.gameObject:addLuaComponent(LuaClass.BookView, self.ui.book)
    self.book = book

    book:setSoftShadowResource("ui://TurnPage/shadow_soft")
    book.pageRenderer = handler(self, self.renderPage)
    book.pageCount = 20
    book:initPage(0)
    book:showCover(0, false)
    book.onTurnCompleteBook = handler(self, self.onTurnComplete)

    LuaClass.GuiGearBase.disableAllTweenEffect = true
    self.bookPosContr = self.view:GetController("bookPos")
    self.bookPosContr.selectedIndex = 1
    LuaClass.GuiGearBase.disableAllTweenEffect = false

    ---@type FairyGUI.GSlider
    local slider = self.ui.pageSlide
    self.slider = slider
    slider.max = 19
    slider.value = 0
    slider.onGripTouchEnd:Add(
            function()
                self.book:turnTo(slider.value)
            end)
    -----@type BookPageView
    --self.page = self.ui.c1.displayObject.gameObject:addLuaComponent(LuaClass.CardItemView, self.ui.c1)
end

function TurnPageView:onTurnComplete()
    self.slider.value = self.book.currentPage
    if self.book:isCoverShowing(0) then
        self.bookPosContr.selectedIndex = 1
    elseif self.book:isCoverShowing(1) then
        self.bookPosContr.selectedIndex = 2
    else
        self.bookPosContr.selectedIndex = 0
    end
end

---@param page FairyGUI.GComponent
function TurnPageView:renderPage(index, page)
    ---@type BookPageView
    local pageView = page.displayObject.gameObject:getLuaComponent(LuaClass.BookPageView)
    if not pageView then
        pageView = page.displayObject.gameObject:addLuaComponent(LuaClass.BookPageView, page)
    end
    pageView:render(index)
end

function TurnPageView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function TurnPageView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
    registerEventFunc(ui.btnNext, eventType.Click, function()
        self.book:turnNext()
    end)
    registerEventFunc(ui.btnPrev, eventType.Click, function()
        self.book:turnPrevious()
    end)
end

function TurnPageView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function TurnPageView:closeView()
    module:closeView()
end

function TurnPageView:onExit()
    self:unRegisterEvent()
end

function TurnPageView:dispose()
    super.dispose(self)
end

return TurnPageView
