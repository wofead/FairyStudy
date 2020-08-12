-- @Author: jow
-- @Date:   2020/8/5 10:02
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class LoopListView:BaseUi
local LoopListView = class("LoopListView", super)

local module = App.loopListModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
LoopListView.uiConfig = LuaClass.UiConstant.LoopList

function LoopListView:init()
    ---@type FairyGUI.GList
    local list = self.ui.list
    list:SetVirtualAndLoop()

    list.itemRenderer = handler(self, self.renderListItem)
    list.numItems = 5
    list.scrollPane.onScroll:Add(handler(self, self.doSpecialEffect))
    self.list = list

end

function LoopListView:doSpecialEffect()
    local midX = self.list.scrollPane.posX + self.list.viewWidth / 2
    local cnt = self.list.numChildren
    for i = 1, cnt do
        local obj = self.list:GetChildAt(i - 1)
        local dist = math.abs(midX - obj.x - obj.width / 2)
        if dist > obj.width then
            obj:SetScale(1, 1)
        else
            local ss = 1 + (1 - dist / obj.width) * 0.24
            obj:SetScale(ss, ss)
        end
    end
    self.ui.n3.text = "" .. ((self.list:GetFirstChildInView() + 1) % self.list.numItems)
end

function LoopListView:renderListItem(index, obj)
    obj:SetPivot(0.5, 0.5)
    obj.icon = LuaClass.GuiUIPackage.GetItemURL("LoopList", "n" .. (index + 1))
end

function LoopListView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function LoopListView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function LoopListView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function LoopListView:closeView()
    module:closeView()
end

function LoopListView:onExit()
    self:unRegisterEvent()
end

function LoopListView:dispose()
    super.dispose(self)
end

return LoopListView
