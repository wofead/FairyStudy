-- @Author: jow
-- @Date:   2020/8/13 17:33
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseLuaComponent
---@class UiList:BaseLuaComponent
local UiList = class("UiList", super)

---@param guiList FairyGUI.GList
---@param itemComponent BaseLuaComponent
---@return UiList
function UiList.AddToGuiList(guiList, itemComponent)
    local list = guiList.displayObject.gameObject:addLuaComponent(UiList, guiList, itemComponent)
    return list
end

---@param gameObject UnityEngine.GameObject 
function UiList:ctor(gameObject, guiList, itemComponent)
    super.ctor(self, gameObject)
    self:init(guiList, itemComponent)
end

---@param guiList FairyGUI.GList
---@param itemComponent BaseLuaComponent
function UiList:init(guiList, itemComponent)
    self.guiList = guiList
    self.itemComponent = itemComponent

    self.guiList.itemRenderer = handler(self, self.itemRenderer)
end

---@param index number @从0开始， 真实的index
---@param obj FairyGUI.GComponent
function UiList:itemRenderer(index, obj)
    local item = obj.displayObject.gameObject:getLuaComponent(self.itemComponent)
    if not item then
        item = obj.displayObject.gameObject:addLuaComponent(self.itemComponent, obj)
    end
    item:setData(self.dataList[index+1], index)
end

function UiList:setDataSource(list)
    self.dataList = list
    self.guiList.numItems = #list
    return self
end

return UiList
