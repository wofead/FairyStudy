---Author：  houn
---DATE：    2020/8/13
---DES:      
local LuaClass = LuaClass
local super = LuaClass.BaseLuaComponent
---@class BookPageView:BaseLuaComponent
local BookPageView = class("BookPageView", super)

---@param comp FairyGUI.GComponent
function BookPageView:ctor(gameObject, comp)
    super.ctor(self, gameObject)
    self.comp = comp
    self.style = comp:GetController("style")
    self.pageNumber = comp:GetChild("pn")
    self.modelWrapper = LuaClass.GuiGoWrapper()
    comp:GetChild("model"):SetNativeObject(modelWrapper)
end

function BookPageView:render(pageIndex)
    self.pageNumber.text = (pageIndex + 1) .. ""

    if pageIndex == 0 then
        self.style.selectedIndex = 0
    elseif pageIndex == 2 then
        if not isValid(self.modelWrapper.wrapTarget) then
            local prefab = LuaClass.Resources.Load("npc")
            local go = LuaClass.Object.Instantiate(prefab)
            go.transform.localPosition = LuaClass.Vector3(0, 0, 1000)
            go.transform.localScale = LuaClass.Vector3(120, 120, 120)
            go.transform.localEulerAngles = LuaClass.Vector3(0, 100, 0)
            self.modelWrapper:setWrapTarget(go, true)
        end
        self.style.selectedIndex = 2
    else
        self.style.selectedIndex = 1
    end
end

return BookPageView
