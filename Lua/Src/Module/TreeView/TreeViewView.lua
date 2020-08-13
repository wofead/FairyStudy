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
    ---@type FairyGUI.GTree
    local tree1 = self.ui.tree
    self.tree1 = tree1
    tree1.onClickItem:Add(handler(self, self.onClockNode))
    ---@type FairyGUI.GTree
    local tree2 = self.ui.tree2
    self.tree2 = tree2
    tree2.onClickItem:Add(handler(self, self.onClockNode))
    tree2.treeNodeRender = handler(self, self.renderTreeNode)

    local topNode = LuaClass.GuiGTreeNode(true)
    topNode.data = "I'm a top node"
    tree2.rootNode:AddChild(topNode)
    for i = 1, 5 do
        local node = LuaClass.GuiGTreeNode(false)
        node.data = "Hello " .. i
        topNode:AddChild(node)
    end

    local aFolderNode = LuaClass.GuiGTreeNode(true)
    aFolderNode.data = "A folder node"
    topNode:AddChild(aFolderNode)
    for i = 1, 5 do
        local node = LuaClass.GuiGTreeNode(false)
        node.data = "Good " .. i
        aFolderNode:AddChild(node)
    end

    for i = 1, 3 do
        local node = LuaClass.GuiGTreeNode(false)
        node.data = "World " .. i
        aFolderNode:AddChild(node)
    end

    local anotherTopNode = LuaClass.GuiGTreeNode(false)
    anotherTopNode.data = { "I'm a top node too", "ui://TreeView/heart" }
    tree2.rootNode:AddChild(anotherTopNode)
end

---@param node FairyGUI.GTreeNode
---@param obj FairyGUI.GComponent
function TreeViewView:renderTreeNode(node, obj)
    if node.isFolder then
        obj.text = node.data .. ""
    elseif type(node.data) == "table" then
        obj.icon = node.data[2]
        obj.text = node.data[1]
    else
        obj.icon = "ui://TreeView/file"
        obj.text = node.data
    end
end

function TreeViewView:onClockNode(context)
    local node = context.data.treeNode
    printJow("TreeViewView", node.text)
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
