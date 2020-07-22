---Author：  houn
---DATE：    2020/7/15
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class BasicsView:BaseUi
local BasicsView = class("BasicsView", super)


local module = App.basicsModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
BasicsView.uiConfig = LuaClass.UiConstant.Basics

function BasicsView:init()
    local uiConfig = LuaClass.GuiUIConfig
    uiConfig.defaultFont = "Microsoft YaHei";

    uiConfig.buttonSound = LuaClass.GuiUIPackage.GetItemAsset("Basics", "click")
    ---@type FairyGUI.GComponent
    self.viewContainer = self.ui.container
    self.controller = self.view:GetController("c1")
    self.isMainView = true

    self.viewCache = {}
end

function BasicsView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function BasicsView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    registerEventFunc(ui.btn_Back, eventType.Click, handler(self, self.closeView))
    local num = self.view.numChildren
    for i = 1, num do
        ---@type FairyGUI.GButton
        local obj = self.view:GetChildAt(i - 1)
        if isValid(obj.group) and obj.group.name == "btns" then
            obj.onClick:Add(handler(self, self.onBtnClick))
        end
    end
end

---@param context FairyGUI.EventContext
function BasicsView:onBtnClick(context)
    local type = string.sub(context.sender.name, 5)
    local view
    if self.viewCache[type] then
        view = self.viewCache[type]
    else
        view = LuaClass.GuiUIPackage.CreateObject(self.uiConfig.packageName, "Demo_" .. type)
    end
    --printJow(type) 带有颜色的日志输出存在问题
    self.viewContainer:RemoveChildren()
    self.viewContainer:AddChild(view)
    self.controller.selectedIndex = 1
    self.isMainView = false
    print(type)


end

function BasicsView:closeView()
    if self.isMainView then
        module:closeView()
    else
        self.controller.selectedIndex = 0
        self.isMainView = true
    end
end

function BasicsView:unRegisterEvent()

end

function BasicsView:onExit()
    self:unRegisterEvent()
end

function BasicsView:dispose()
    super.dispose(self)
end

return BasicsView