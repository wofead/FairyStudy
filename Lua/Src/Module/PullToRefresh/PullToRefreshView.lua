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
    ---@type FairyGUI.GList
    local list1 = self.ui.list1
    self.list1 = list1
    list1.itemRenderer = handler(self, self.renderListItem1)
    list1:SetVirtual()
    list1.numItems = 1
    list1.scrollPane.onPullDownRelease:Add(handler(self, self.onPullDownToRefresh))
    ---@type FairyGUI.GList
    local list2 = self.ui.list2
    self.list2 = list2
    list2.itemRenderer = handler(self, self.renderListItem2)
    list2:SetVirtual()
    list2.numItems = 1
    list2.scrollPane.onPullUpRelease:Add(handler(self, self.onPullUpToRefresh))
    self.list1Header = self.list1.scrollPane.header
    self.list1Header.onSizeChanged:Add(
            function()
                local contr = self.list1Header:GetController("c1")
                if contr.selectedIndex == 2 or contr.selectedIndex == 3 then
                    return
                end
                if self.list1Header.height > self.list1Header.sourceHeight then
                    contr.selectedIndex = 1
                else
                    contr.selectedIndex = 0
                end
            end)
end

function PullToRefreshView:renderListItem1(index, object)
    object.title = "Item" .. (self.ui.list1.numItems - index - 1)
end

function PullToRefreshView:renderListItem2(index, object)
    object.title = "Item" .. index
end

function PullToRefreshView:onPullDownToRefresh()
    local header = self.list1Header
    if header:GetController("c1").selectedIndex == 1 then
        local contr = header:GetController("c1")
        contr.selectedIndex = 2
        self.list1.scrollPane:LockHeader(header.sourceHeight)
        self.timer1 = App.timeManager:add(2000, function()
        end, 2000, function()
            self.list1.numItems = self.list1.numItems + 5
            contr.selectedIndex = 3
            self.list1.scrollPane:LockHeader(35)
            self.timer11 = App.timeManager:add(2000, function()
            end, 2000, function()
                contr.selectedIndex = 0
                self.list1.scrollPane:LockHeader(0)
            end)
        end)
    end
end

function PullToRefreshView:onPullUpToRefresh()
    local footer = self.list2.scrollPane.footer
    footer:GetController("c1").selectedIndex = 1
    self.list2.scrollPane:LockFooter(footer.sourceHeight)
    self.timer2 = App.timeManager:add(2000, function()
    end, 2000, function()
        self.list2.numItems = self.list2.numItems + 5
        footer:GetController("c1").selectedIndex = 0
        self.list2.scrollPane:LockFooter(0)
    end)
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