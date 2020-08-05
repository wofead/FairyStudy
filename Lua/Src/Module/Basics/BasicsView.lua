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
    uiConfig.popupMenu = "ui://Basics/PopupMenu"
    ---@type FairyGUI.GComponent
    self.viewContainer = self.ui.container
    self.controller = self.view:GetController("c1")
    self.isMainView = true

    ---@type table<string, FairyGUI.GComponent>
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
        self.viewCache[type] = view
    end
    --printJow(type) 带有颜色的日志输出存在问题
    self.viewContainer:RemoveChildren()
    self.viewContainer:AddChild(view)
    self.controller.selectedIndex = 1
    self.isMainView = false
    if type == "Graph" then
        self:playGraph()
    elseif type == "Button" then
        self:playButton()
    elseif type == "Text" then
        self:playText()
    elseif type == "Grid" then
        self:playGrid()
    elseif type == "Transition" then
        self:playTransition()
    elseif type == "Window" then
        self:playWindow()
    elseif type == "Popup" then
        self:playPopup()
    elseif type == "Drag&Drop" then
        self:playDragDrop()
    elseif type == "Depth" then
        self:playDepth()
    elseif type == "ProgressBar" then
        self:playProgressBar()
    end
end

function BasicsView:playGraph()
    local view = self.viewCache["Graph"]
    ---@type FairyGUI.Shape
    local shape
    shape = view:GetChild("pie").shape
    local ellipse = shape.graphics:GetMeshFactoryEM()
    ellipse.startDegree = 30
    ellipse.endDegreee = 300
    shape.graphics:SetMeshDirty()

    shape = view:GetChild("trapezoid").shape
    local trapezoid = shape.graphics:GetMeshFactoryPM()
    trapezoid.usePercentPositions = true
    trapezoid.points:Clear()
    trapezoid.points:Add(LuaClass.Vector2(0, 1))
    trapezoid.points:Add(LuaClass.Vector2(0.3, 0))
    trapezoid.points:Add(LuaClass.Vector2(0.7, 0))
    trapezoid.points:Add(LuaClass.Vector2(1, 1))
    trapezoid.texcoords:Clear();
    trapezoid.texcoords:AddRange(LuaClass.GuiVertexBuffer.NormalizedUV);
    shape.graphics:SetMeshDirty()
    shape.graphics.texture = LuaClass.GuiUIPackage.GetItemAsset("Basics", "change")

    shape = view:GetChild("line").shape
    local line = shape.graphics:GetMeshFactoryLM()
    line.lineWidthCurve = LuaClass.AnimationCurve.Linear(0, 25, 1, 10)
    line.roundEdge = true
    line.path:Create({
        LuaClass.GuiGPathPoint(LuaClass.Vector3(0, 120, 0)),
        LuaClass.GuiGPathPoint(LuaClass.Vector3(20, 120, 0)),
        LuaClass.GuiGPathPoint(LuaClass.Vector3(100, 100, 0)),
        LuaClass.GuiGPathPoint(LuaClass.Vector3(180, 30, 0)),
        LuaClass.GuiGPathPoint(LuaClass.Vector3(100, 0, 0)),
        LuaClass.GuiGPathPoint(LuaClass.Vector3(20, 30, 0)),
        LuaClass.GuiGPathPoint(LuaClass.Vector3(100, 100, 0)),
        LuaClass.GuiGPathPoint(LuaClass.Vector3(180, 120, 0)),
        LuaClass.GuiGPathPoint(LuaClass.Vector3(200, 120, 0)),
    })
    --line.path:Create(
    --        LuaClass.GuiGPathPoint(LuaClass.Vector3(0, 120, 0)),
    --        LuaClass.GuiGPathPoint(LuaClass.Vector3(180, 30, 0)),
    --        LuaClass.GuiGPathPoint(LuaClass.Vector3(180, 120, 0)),
    --        LuaClass.GuiGPathPoint(LuaClass.Vector3(200, 120, 0))
    --)
    shape.graphics:SetMeshDirty()
    LuaClass.GuiGTween.To(0, 1, 5):SetEase(LuaClass.EaseType.Linear):SetTarget(shape.graphics):OnUpdateForce(
            function(t)
                t.target:GetMeshFactoryLM().fillEnd = t.value.x
                t.target:SetMeshDirty()
            end)

    shape = view:GetChild("line2").shape
    local line2 = shape.graphics:GetMeshFactoryLM()
    line2.lineWidth = 3
    line2.roundEdge = true
    line2.path:Create(
            LuaClass.GuiGPathPoint(LuaClass.Vector3(0, 120, 0), LuaClass.GuiGPathPoint.CurveType.Straight),
            LuaClass.GuiGPathPoint(LuaClass.Vector3(80, 90, 0), LuaClass.GuiGPathPoint.CurveType.Straight),
            LuaClass.GuiGPathPoint(LuaClass.Vector3(160, 90, 0), LuaClass.GuiGPathPoint.CurveType.Straight),
            LuaClass.GuiGPathPoint(LuaClass.Vector3(220, 30, 0), LuaClass.GuiGPathPoint.CurveType.Straight)
    )
    shape.graphics:SetMeshDirty()

    local image = view:GetChild("line3")
    local line3 = image.displayObject.graphics:GetMeshFactoryLM()
    line3.lineWidth = 30
    line3.roundEdge = false
    line3.path:Create(
            LuaClass.GuiGPathPoint(LuaClass.Vector3(0, 30, 0)),
            LuaClass.GuiGPathPoint(LuaClass.Vector3(150, -50)),
            LuaClass.GuiGPathPoint(LuaClass.Vector3(200, 30, 0)),
            LuaClass.GuiGPathPoint(LuaClass.Vector3(400, 30, 0))
    )
    image.displayObject.graphics:SetMeshDirty()
end

function BasicsView:playButton()
    local view = self.viewCache["Button"]
    view:GetChild("n34").onClick:Add(function()
        printJow("BasicsView", "Button Click")
    end)
end

function BasicsView:playText()
    local view = self.viewCache["Text"]
    view:GetChild("n12").onClickLink:Add(function(context)
        local t = context.sender
        t.text = "[img]ui://Basics/pet[/img][color=#FF0000]You click the link[/color]：" .. context.data
    end)

    view:GetChild("n25").onClick:Add(function()
        view:GetChild("n24").text = view:GetChild("n22").text
    end)
end

function BasicsView:playGrid()
    local view = self.viewCache["Grid"]
    ---@type FairyGUI.GList
    local list1 = view:GetChild("list1")
    list1:RemoveChildrenToPool()
    local names = {}
    for i = 1, 10 do
        table.insert(names, "name" .. i)
    end
    local color = { LuaClass.Color.yellow, LuaClass.Color.red, LuaClass.Color.gray, LuaClass.Color.green }
    for i, v in ipairs(names) do
        ---@type FairyGUI.GButton
        local item = list1:AddItemFromPool()
        item:GetChild("t0").text = i .. ''
        item:GetChild("t1").text = v
        item:GetChild("t2").color = color[math.random(1, 4)]
        item:GetChild("star").value = math.random(1, 100)
    end

    local list2 = view:GetChild("list2")
    list2:RemoveChildrenToPool()
    for i, v in ipairs(names) do
        ---@type FairyGUI.GButton
        local item = list2:AddItemFromPool()
        item:GetChild("cb").selected = false
        item:GetChild("t1").text = v
        item:GetChild("mc").playing = (i % 2) == 0
        item:GetChild("t3").text = math.random(1, 10000) .. ''
    end
end

function BasicsView:playTransition()
    local view = self.viewCache["Transition"]
    ---@type FairyGUI.GComponent
    local n2 = view:GetChild("n2")
    local n3 = view:GetChild("n3")
    n2:GetTransition("to"):Play(math.maxinteger, 0, nil)
    n3:GetTransition("peng"):Play(math.maxinteger, 0, nil)
    view:GetChild("n3").onClick:Add(function()
        self:showWindowB(view)
    end)
    view.onAddedToStage:Add(function()
        n2:GetTransition("to"):Stop()
        n3:GetTransition("peng"):Stop()
    end)
end

function BasicsView:playWindow()
    local view = self.viewCache["Window"]
    view:GetChild("n0").onClick:Add(function()
        self:showWindowA(view)
    end)
    view:GetChild("n1").onClick:Add(function()
        self:showWindowB(view)
    end)
end

function BasicsView:playPopup()
    if not self.pm then
        ---@type FairyGUI.PopupMenu
        local pm = LuaClass.GuiPopupMenu()
        pm:AddItemForce("Item 1", handler(self, self.clickMenu))
        pm:AddItemForce("Item 2", handler(self, self.clickMenu))
        pm:AddItemForce("Item 3", handler(self, self.clickMenu))
        pm:AddItemForce("Item 4", handler(self, self.clickMenu))
        self.pm = pm
    end
    if not self.popUpCom then
        self.popUpCom = LuaClass.GuiUIPackage.CreateObject("Basics", "Component12")
        self.popUpCom:Center()
    end
    local view = self.viewCache["Popup"]
    view:GetChild("n0").onClick:Add(function(content)
        self.pm:Show(content.sender, LuaClass.GuiPopupDirection.Down)
    end)
    view:GetChild("n1").onClick:Add(function()
        LuaClass.GuiGRoot.inst:ShowPopup(self.popUpCom)
    end)
    view.onRightClick:Add(
            function()
                self.pm:Show()
            end)
end

---@param context FairyGUI.EventContext
function BasicsView:clickMenu(context)
    -- 这里存在bug，应该是callback1，而不是callback0
    local item = context.data
    printJow("BasicsView", item.text)
end

function BasicsView:playDragDrop()
    local view = self.viewCache["Drag&Drop"]
    view:GetChild("a").draggable = true
    local b = view:GetChild("b")
    b.draggable = true
    b.onDragStart:Add(
            function(context)
                context:PreventDefault()
                LuaClass.GuiDragDropManager.inst:StartDrag(b, b.icon, b.icon, context.data)
            end)
    ---@type FairyGUI.GButton
    local c = view:GetChild("c")
    c.icon = nil
    c.onDrop:Add(
            function(context)
                c.icon = context.data
            end
    )
    local bounds = view:GetChild("n7")
    local rect = bounds:TransformRect(LuaClass.Rect(0, 0, bounds.width, bounds.height), LuaClass.GuiGRoot.inst)
    rect.x = rect.x - view.parent.x

    local d = view:GetChild("d")
    d.draggable = true
    d.dragBounds = rect
end

function BasicsView:playDepth()
    local view = self.viewCache["Depth"]
    local testContainer = view:GetChild("n22")
    local fixedObj = testContainer:GetChild("n0")
    fixedObj.sortingOrder = 100
    fixedObj.draggable = true
    local numChildren = testContainer.numChildren
    for i = 1, numChildren do
        local child = testContainer:GetChildAt(i - 1)
        if child ~= fixedObj then
            testContainer:RemoveChildAt(i - 1)
            numChildren = numChildren - 1
        else
            i = i + 1
        end
    end
    self.startPos = LuaClass.Vector2(fixedObj.x, fixedObj.y)
    view:GetChild("btn0").onClick:Add(function()
        local graph = LuaClass.GuiGGraph()
        self.startPos.x = self.startPos.x + 10
        self.startPos.y = self.startPos.y + 10
        graph.xy = self.startPos
        graph:DrawRect(150, 150, 1, LuaClass.Color.black, LuaClass.Color.red)
        view:GetChild("n22"):AddChild(graph)
    end)

    view:GetChild("btn1").onClick:Add(function()
        local graph = LuaClass.GuiGGraph()
        self.startPos.x = self.startPos.x + 10
        self.startPos.y = self.startPos.y + 10
        graph.xy = self.startPos
        graph:DrawRect(150, 150, 1, LuaClass.Color.black, LuaClass.Color.green)
        graph.sortingOrder = 200
        view:GetChild("n22"):AddChild(graph)
    end)
end

function BasicsView:playProgressBar()
    local view = self.viewCache["ProgressBar"]
    self.time = App.timeManager:add(100, function()
        local num = view.numChildren
        for i = 1, num do
            local item = view:GetChildAt(i - 1)
            item.value = item.value + 1
            if item.value > item.max then
                item.value = 0
            end
        end
    end, 1000, function()
        printJow("BasicsView", "Progress end")
    end)
end

---@param parent FairyGUI.GComponent
function BasicsView:showWindowA(parent)
    ---@type WindowsA
    local window
    if not self.viewCache["windowA"] then
        local view = LuaClass.GuiWindow()
        window = LuaClass.WindowsA(view)
    else
        window = self.viewCache["windowA"]
    end
    window:show()
end

function BasicsView:showWindowB()
    ---@type WindowsB
    local window
    if not self.viewCache["windowA"] then
        local view = LuaClass.GuiWindow()
        ---@type FairyGUI.GComponent
        window = LuaClass.WindowsB(view)
    else
        window = self.viewCache["windowB"]
    end
    window:show()
end

function BasicsView:closeView()
    if self.time then
        App.timeManager:remove(self.time)
    end
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