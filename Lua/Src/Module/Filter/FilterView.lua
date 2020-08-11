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
    ---@type FairyGUI.BlurFilter
    local blurFilter = LuaClass.GuiBlurFilter()
    blurFilter.blurSize = 1
    local ui = self.ui
    ui.n21.filter = blurFilter
    ui.s0.value = 150
    ui.s1.value = 150
    ui.s2.value = 150
    ui.s3.value = 150
    ui.s4.value = 50
end

function FilterView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function FilterView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    registerEventFunc(ui.s0, eventType.Changed, handler(self, self.onSliderChanged))
    registerEventFunc(ui.s1, eventType.Changed, handler(self, self.onSliderChanged))
    registerEventFunc(ui.s2, eventType.Changed, handler(self, self.onSliderChanged))
    registerEventFunc(ui.s3, eventType.Changed, handler(self, self.onSliderChanged))
    registerEventFunc(ui.s4, eventType.Changed, handler(self, self.onSliderChanged))
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

---@param context FairyGUI.EventContext
function FilterView:onSliderChanged(context)
    local n0 = self.ui.n0
    local n13 = self.ui.n13
    for i = 1, 2 do
        ---@type FairyGUI.ColorFilter
        local filter
        if i == 1 then
            filter = n0.filter
        else
            filter = n13.filter
        end
        filter:Reset()
        filter:AdjustBrightness((self.ui.s0.value - 100) / 100)
        filter:AdjustContrast((self.ui.s1.value - 100) / 100)
        filter:AdjustSaturation((self.ui.s2.value - 100) / 100)
        filter:AdjustHue((self.ui.s3.value - 100) / 100)
    end

    local n21 = self.ui.n21
    n21.filter.blurSize = self.ui.s4.value / 100
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