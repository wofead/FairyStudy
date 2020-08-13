-- @Author: jow
-- @Date:   2020/8/5 10:08
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class ScrollPaneView:BaseUi
local ScrollPaneView = class("ScrollPaneView", super)

local module = App.scrollPaneModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
ScrollPaneView.uiConfig = LuaClass.UiConstant.ScrollPane

function ScrollPaneView:init()
    ---@type FairyGUI.GList
    local list = self.ui.list
    self.list = list
    list.itemRenderer = handler(self, self.renderItemList)
    list:SetVirtual()
    list.numItems = 1000
    list.onTouchBegin:Add(handler(self, self.onClickList))
    self.ui.box.onDrop:Add(handler(self, self.onDrop))
    local gesture = LuaClass.GuiLongPressGesture(list)
    gesture.once = true
    gesture.trigger = 1
    gesture.onAction:Add(handler(self, self.onLongPress))
end

---@param obj FairyGUI.GButton
function ScrollPaneView:renderItemList(index, obj)
    obj.title = "Item " .. index
    obj.scrollPane.posX = 0

    --    请注意，RenderListItem是重复调用的，不要使用Add增加侦听！
    obj:GetChild("b0").onClick:Set(handler(self, self.onClickStick))
    obj:GetChild("b1").onClick:Set(handler(self, self.onClickDelete))
end

---@param context FairyGUI.EventContext
function ScrollPaneView:onClickList(context)
    local cnt = self.list.numChildren
    for i = 1, cnt do
        ---@type FairyGUI.GButton
        local item = self.list:GetChildAt(i - 1)
        if item.scrollPane.posX ~= 0 then
            if item:GetChild("b0"):IsAncestorOf(LuaClass.GuiGRoot.inst.touchTarget)
                    or item:GetChild("b1"):IsAncestorOf(LuaClass.GuiGRoot.inst.touchTarget) then
                return
            end
            item.scrollPane:SetPosX(0, true)
            --取消滚动面板可能发生的拉动
            item.scrollPane:CancelDragging()
            self.list.scrollPane:CancelDragging()
            break
        end
    end
end

---@param context FairyGUI.EventContext
function ScrollPaneView:onLongPress(context)
    --逐层往上知道查到点击了那个item
    local obj = LuaClass.GuiGRoot.inst.touchTarget
    local p = obj.parent
    while p do
        if p == self.list then
            break
        end
        p = p.parent
    end

    if not isValid(p) then
        return
    end
    printJow("ScrollPaneView", obj.text)
    LuaClass.GuiDragDropManager.inst:StartDrag(obj, obj.icon, obj.text)
end

---@param context FairyGUI.EventContext
function ScrollPaneView:onDrop(context)
    self.ui.txt.text = "Drop " .. context.data
end

---@param context FairyGUI.EventContext
function ScrollPaneView:onClickStick(context)
    self.ui.txt.text = "Stick " .. context.sender.parent.text
end

---@param context FairyGUI.EventContext
function ScrollPaneView:onClickDelete(context)
    self.ui.txt.text = "Delete " .. context.sender.parent.text
end

function ScrollPaneView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function ScrollPaneView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function ScrollPaneView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
end

function ScrollPaneView:closeView()
    module:closeView()
end

function ScrollPaneView:onExit()
    self:unRegisterEvent()
end

function ScrollPaneView:dispose()
    super.dispose(self)
end

return ScrollPaneView
