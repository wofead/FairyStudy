---Author：  houn
---DATE：    2020/8/13
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseLuaComponent
---@class BookView:BaseLuaComponent
local BookView = class("BookPageView", super)

local Paper = { Soft = 0, Hard = 1 }

local CoverType = { Front = 0, Back = 1 }

local CoverStatus = { Hidden = 0, ShowingFront = 1, ShowingBack = 2 }

local CoverTurningOp = { None = 0, ShowFront = 1, HideFront = 2, ShowBack = 3, HideBack = 4 }

local Corner = { INVALID = 0, TL = 1, BL = 2, TR = 3, BR = 4 }

---@param comp FairyGUI.GComponent
function BookView:ctor(gameObject, comp)
    super.ctor(self, gameObject)
    self.comp = comp

    self.pagesContainer = comp:GetChild("pages")
    ---@type FairyGUI.GComponent
    local obj1 = self.pagesContainer:GetChild("left")
    ---@type FairyGUI.GComponent
    local obj2 = self.pagesContainer:GetChild("right")
    obj1.displayObject.home = self.comp.displayObject.cachedTransform
    obj2.displayObject.home = self.comp.displayObject.cachedTransform
    self.pagesContainer:RemoveChild(obj1)
    self.pagesContainer:RemoveChild(obj2)
    ---@type FairyGUI.GComponent
    self.fontCover = self.comp:GetChild("frontCover")
    self.frontCoverPos = self.fontCover.position

    ---@type FairyGUI.GComponent
    self.backCover = self.comp:GetChild("backCover")
    self.backCoverPos = self.backCover.position

    self.objects = { obj1, obj2 }
    self.objectIndice = { -1, -1, -1, -1 }
    self.objectNewIndice = { 1, 1, 1, 1 }

    self.turningTarget = -1
    self.currentPage = -1

    self.pageWidth = obj1.width
    self.pageHeight = obj1.height
    self.pageResource = obj1.resourceURL

    local mask1 = LuaClass.GuiGGraph()
    self.mask1 = mask1
    mask1.displayObject.home = self.comp.displayObject.cachedTransform
    mask1:SetSize(self.pageWidth, self.pageHeight)

    local mask2 = LuaClass.GuiGGraph()
    self.mask2 = mask2
    mask2.displayObject.home = self.comp.displayObject.cachedTransform
    mask2:SetSize(self.pageWidth, self.pageHeight)

    self:setUpHotspot(self.comp:GetChild("hotspot_tl"), Corner.TL)
    self:setUpHotspot(self.comp:GetChild("hotspot_bl"), Corner.BL)
    self:setUpHotspot(self.comp:GetChild("hotspot_tr"), Corner.TR)
    self:setUpHotspot(self.comp:GetChild("hotspot_br"), Corner.BR)
end

function BookView:setSoftShadowResource(res)
    self.softShadow = LuaClass.GuiUIPackage.CreateObjectFromURL(res)
    self.softShadow.height = math.sqrt(self.pageWidth * self.pageWidth + self.pageHeight * self.pageHeight + 60)
    self.softShadow.displayObject.home = self.comp.displayObject.cachedTransform
    self.softShadow.sortingOrder = 99999
end

function BookView:turnTo(pageIndex)
    LuaClass.GuiGTween.Kill(self.comp, true)

    if self.coverStatus == CoverStatus.ShowingFront then
        self.coverTurningOp = CoverTurningOp.HideFront
        self.draggingCorner = Corner.BR
    elseif self.coverStatus == CoverStatus.ShowingBack then
        self.coverTurningOp = CoverTurningOp.HideBack
        self.draggingCorner = Corner.BL
    end

    local tt1 = self.currentPage
    if self.currentPage % 2 == 0 then
        tt1 = tt1 - 1
    end
    local tt2 = pageIndex
    if pageIndex % 2 == 0 then
        tt2 = tt2 - 1
    end
    if tt1 == tt2 then
        self.currentPage = pageIndex
        self.turningTarget = -1
    else
        self.turningTarget = pageIndex
        if self.turningTarget < self.currentPage then
            self.draggingCorner = Corner.BL
        else
            self.draggingCorner = Corner.BR
        end
    end
    if self.draggingCorner == Corner.INVALID then
        return
    end
    self:startTween()
end

function BookView:turnNext()
    LuaClass.GuiGTween.Kill(self.comp, true)

    if self:isCoverShowing(CoverType.Front) then
        self:turnTo(0)
    elseif self.currentPage == self.pageCount - 1 then
        self:showCover(CoverType.Back, true)
    elseif self.currentPage % 2 == 0 then
        self:turnTo(self.currentPage + 1)
    else
        self:turnTo(self.currentPage + 2)
    end
end

function BookView:turnPrevious()
    LuaClass.GuiGTween.Kill(self.comp, true)

    if self:isCoverShowing(CoverType.Back) then
        self:turnTo(self.pageCount - 1)
    elseif self.currentPage == 0 then
        self:showCover(CoverType.Front, true)
    elseif self.currentPage % 2 == 0 then
        self:turnTo(self.currentPage - 2)
    else
        self:turnTo(self.currentPage - 1)
    end
end

function BookView:showCover(cover, turnEffect)
    LuaClass.GuiGTween.Kill(self.comp, true)
    if not isValid(self.frontCover) then
        return
    end

    if turnEffect then
        if cover == CoverType.Front then
            if self.coverStatus == CoverStatus.ShowingFront then
                return
            end
            self.coverTurningOp = CoverTurningOp.ShowFront
            self.draggingCorner = Corner.BL
            self.currentPage = 0
        else
            if self.coverStatus == CoverStatus.ShowingFront then
                return
            end
            self.coverTurningOp = CoverTurningOp.ShowBack
            self.draggingCorner = Corner.BR
            self.currentPage = self.pageCount - 1
        end
        self:startTween()
    else
        if cover == CoverType.Front then
            self.coverTurningOp = CoverTurningOp.ShowFront
            self.currentPage = 0
        else
            self.coverTurningOp = CoverTurningOp.ShowBack
            self.currentPage = self.pageCount - 1
        end
        self:renderPages()
    end
end

function BookView:isCoverShowing(cover)
    if cover == CoverType.Front then
        if self.coverStatus == CoverStatus.ShowingFront then
            return true
        else
            return false
        end
    else
        if self.coverStatus == CoverStatus.ShowingBack then
            return true
        else
            return false
        end
    end
end

function BookView:startTween()
    self.turningAmount = 0
    self:renderPages()
    local source = self:getCornerPosition(self.draggingCorner, self.coverTurningOp ~= CoverTurningOp.None)
    local target
    if self.draggingCorner == Corner.TL or self.draggingCorner == Corner.BL then
        target = self:getCornerPosition(self.draggingCorner + 2, self.coverTurningOp ~= CoverTurningOp.None)
    else
        target = self:getCornerPosition(self.draggingCorner - 2, self.coverTurningOp ~= CoverTurningOp.None)
    end
    if isValid(self.turningPath) then
        self.turningPath = LuaClass.GuiGPath()
    end
    local mid = LuaClass.Vector2(source.x + (target.x - source.x) / 2, target.y - 50)
    self.turningPath:Create(LuaClass.GPathPoint(source), LuaClass.GPathPoint(mid), LuaClass.GPathPoint(target))
    LuaClass.GuiGTween.To(source, target, 0.5):SetUserData(true):SetTarget(self.comp)
            :SetPath(self.turningPath)
            :OnUpdate(handler(self, self.onTurnUpdate)):OnComplete(handler(self, self.onTurnComplete))
end

function BookView:onTurnUpdate(tweener)
    self.dragPoint = tweener.value.vec2
    self.turningAmount = self.dragPoint.x / (self.coverTurningOp ~= CoverTurningOp.None and self.frontCover.width * 2 or self.pageWidth * 2)
    if (self.draggingCorner == Corner.TR or self.draggingCorner == Corner.BR) then
        self.turningAmount = 1 - self.turningAmount
    end
    self:playTurnEffect()
end

function BookView:onTurnComplete(tweener)
    local suc = tweener.userData
    self.draggingCorner = Corner.INVALID
    if suc or self.turningTarget ~= -1 then
        self.currentPage = self.turningTarget
    end
    if suc or self.coverTurningOp ~= CoverTurningOp.None then
        if self.coverTurningOp == CoverTurningOp.ShowFront then
            self.coverStatus = CoverStatus.ShowingFront
        elseif self.coverTurningOp == CoverTurningOp.ShowBack then
            self.coverStatus = CoverStatus.ShowingBack
        else
            self.coverStatus = CoverStatus.Hidden
        end
    end
    self.coverTurningOp = CoverTurningOp.None
    self.turningTarget = -1

    self:renderPages()
    self.onTurnComplete()
end

function BookView:playTurnEffect()
    if self.coverTurningOp ~= CoverTurningOp.None then
        self:playCoverEffect()
    end

    if self.turningTarget ~= -1 then
        if self.paper == Paper.Hard then
            self:playHardEffect()
        else
            self:playSoftEffect()
        end
    end
end

function BookView:playCoverEffect()
    local amount = LuaClass.Mathf.Clamp01(self.turningAmount)
    local ratio, isLeft
    local turningObj = (self.coverTurningOp == CoverTurningOp.ShowFront or self.coverTurningOp == CoverTurningOp.HideFront) and self.fontCover or self.backCover
    local mesh = self:getHardMesh(turningObj)
    if amount < 0.5 then
        ratio = 1 - amount * 2
        isLeft = self.coverTurningOp == CoverTurningOp.ShowFront or _coverTurningOp == CoverTurningOp.HideBack
    else
        ratio = (amount - 0.5) * 2
        isLeft = self.coverTurningOp == CoverTurningOp.HideFront or _coverTurningOp == CoverTurningOp.ShowBack
    end
    if turningObj == self.frontCover then
        self:setCoverStatus(turningObj, CoverType.Front, not isLeft)
    else
        self:setCoverStatus(turningObj, CoverType.Back, not isLeft)
    end
    mesh.points:Clear()
    mesh.texcoords:Clear()
    if isLeft then
        local topOffset = 1 / 8 * (1 - ratio)
        local xOffset = 1 - ratio
        mesh:Add(LuaClass.Vector2(xOffset, 1 + topOffset))
        mesh:Add(LuaClass.Vector2(xOffset, -topOffset))
        mesh:Add(LuaClass.Vector2(1, 0))
        mesh:Add(LuaClass.Vector2(1, 1))
    else
        local topOffset = 1 / 8 * (1 - ratio)
        mesh:Add(LuaClass.Vector2(0, 1))
        mesh:Add(LuaClass.Vector2(0, 0))
        mesh:Add(LuaClass.Vector2(ratio, -topOffset))
        mesh:Add(LuaClass.Vector2(ratio, 1 + topOffset))
    end
    mesh.texcoords:AddRange(LuaClass.GuiVertexBuffer.NormalizedUV)
end

function BookView:playHardEffect()
    local amount = LuaClass.Mathf.Clamp01(self.turningAmount)
    local ratio, isLeft
    local turningObj
    local mesh
    if amount < 0.5 then
        ratio = 1 - amount * 2
        isLeft = self.turningTarget < self.currentPage
        turningObj = self.objects[2]
        mesh = self:getHardMesh(turningObj)
        self:etHardMesh(self.objects[3]).points:Clear()
    else
        ratio = (amount - 0.5) * 2
        sLeft = self.turningTarget > self.currentPage
        turningObj = self.objects[3]
        mesh = self:getHardMesh(turningObj)
        self:etHardMesh(self.objects[2].points:Clear())
    end
    mesh.points:Clear()
    mesh.texcoords:Clear()
    if isLeft then
        turningObj.x = 0

        local topOffset = 1 / 8 * (1 - ratio)
        local xOffset = 1 - ratio
        mesh:Add(LuaClass.Vector2(xOffset, 1 + topOffset))
        mesh:Add(LuaClass.Vector2(xOffset, -topOffset))
        mesh:Add(LuaClass.Vector2(1, 0))
        mesh:Add(LuaClass.Vector2(1, 1))
    else
        turningObj.x = self.pageWidth

        local topOffset = 1 / 8 * (1 - ratio)
        mesh:Add(LuaClass.Vector2(0, 1))
        mesh:Add(LuaClass.Vector2(0, 0))
        mesh:Add(LuaClass.Vector2(ratio, -topOffset))
        mesh:Add(LuaClass.Vector2(ratio, 1 + topOffset))
    end
    mesh.texcoords:AddRange(LuaClass.GuiVertexBuffer.NormalizedUV)
end

function BookView:flipPoint(pt, w, h)
    if self.draggingCorner == Corner.TL then
        pt.x = w - pt.x
        pt.y = h - pt.y
    elseif self.draggingCorner == Corner.BL then
        pt.x = w - pt.x
    elseif self.draggingCorner == Corner.TR then
        pt.y = h - pt.y
    end
end


--todo PlaySoftEffect

--todo RenderCovers

function BookView:setUpHotspot(obj, corner)
    if not isValid(obj) then
        return
    end
    obj.data = corner
    obj.onTouchBegin:Add(handler(self, self.touchBegin))
    obj.onTouchMove:Add(handler(self, self.touchMove))
    obj.onTouchEnd:Add(handler(self, self.touchEnd))
end

function BookView:setPageHard(obj, front)
    obj.touchable = false
    obj.displayObject.cacheAsBitmap = true
    if isValid(obj.mask) then
        obj.mask:RemoveFromParent()
        obj.mask = nil
    end

    local mesh = obj.displayObject.paintingGraphics:GetMeshFactoryPM()
    mesh.usePercentPositions = true
    mesh.points:Clear()
    mesh.texcoords:Clear()
    obj.displayObject.paintingGraphics:SetMeshDirty()

    if front then
        mesh.points:AddRange(LuaClass.GuiVertexBuffer.NormalizedPosition)
        mesh.texcoords:AddRange(LuaClass.GuiVertexBuffer.NormalizedUV)
    end
end

function BookView:setPageSoft(obj, front)
    obj.touchable = false
    obj.displayObject.cacheAsBitmap = true
    local mask = front and self.mask1.displayObject or self.mask2.displayObject
    obj.mask = mask

    local mesh = obj.displayObject.paintingGraphics:GetMeshFactoryPM()
    mesh.usePercentPositions = false
    mesh.points:Clear()
    mesh.texcoords:Clear()
    obj.displayObject.paintingGraphics:SetMeshDirty()

    if front then
        mesh.Add(LuaClass.Vector2(0, self.pageHeight))
        mesh.Add(LuaClass.Vector2.zero)
        mesh.Add(LuaClass.Vector2(self.pageWidth, 0))
        mesh.Add(LuaClass.Vector2(self.pageWidth, self.pageHeight))
    elseif isValid(self.softShadow) then
        obj:AddChild(self.softShadow)
    end
end

function BookView:setPageNormal(obj, left)
    obj.displayObject.cacheAsBitmap = false
    obj.touchable = true
    obj:SetPivot(0, 0, true)
    if left then
        obj:SetXY(0, 0)
    else
        obj:SetXY(self.pageWidth, 0)
    end
    obj.rotation = 0
    if isValid(obj.mask) then
        obj.mask:RemoveFromParent()
        obj.mask = nil
    end
end

---@param obj FairyGUI.GComponent
function BookView:setCoverStatus(obj, coverType, show)
    local c = obj:GetController("side")
    if show then
        if c.selectedIndex ~= 0 then
            obj.position = coverType == CoverType.Front and self.backCoverPos or self.frontCoverPos
            obj.parent:SetChildIndexBefore(obj, obj.parent:GetChildIndex(self.pagesContainer) + 1)
            c.selectedIndex = 0

            if obj.displayObject.cacheAsBitmap then
                obj.displayObject.cacheAsBitmap = true
            end
        end
    else
        if c.selectedIndex ~= 1 then
            obj.position = coverType == CoverType.Front and self.frontCoverPos or self.backCoverPos
            obj.parent:SetChildIndexBefore(obj, obj.parent:GetChildIndex(self.pagesContainer))
            c.selectedIndex = 1

            if obj.displayObject.cacheAsBitmap then
                obj.displayObject.cacheAsBitmap = true
            end
        end
    end
end

function BookView:setCoverNormal(obj, coverType)
    obj.position = coverType == CoverType.Front and self.frontCoverPos or self.backCoverPos
    obj.displayObject.cacheAsBitmap = false
    obj.touchable = true
    obj.parent:SetChildIndexBefore(obj, obj.parent:GetChildIndex(self.pagesContainer))
    obj:GetController("side").selectedIndex = 1
end

function BookView:getHardMesh(obj)
    obj.displayObject.paintingGraphics:SetMeshDirty()
    return obj.displayObject.paintingGraphics:GetMeshFactoryPM()
end

function BookView:getSoftMesh(obj)
    obj.displayObject.graphics:SetMeshDirty()
    return obj.displayObject.graphics:GetMeshFactoryPM()
end

function BookView:updateDragPosition(pos)
    if self.coverTurningOp ~= CoverTurningOp.None then
        self.dragPoint = self.comp:GlobalToLocal(pos) - self.frontCoverPos
        self.turningAmount = self.dragPoint.x / (2 * self.frontCover.width)
    else
        self.dragPoint = self.pagesContainer:GlobalToLocal(pos) - self.frontCoverPos
        self.turningAmount = self.dragPoint.x / (2 * self.frontCover.width)
    end
    if self.draggingCorner == Corner.TR or self.draggingCorner == Corner.BR then
        self.turningAmount = 1 - self.turningAmount
    end
end

function BookView:getCornerPosition(corner, isCover)
    local w = isCover and self.fontCover.width or self.pageWidth
    local h = isCover and self.fontCover.height or self.pageHeight
    local pt
    if corner == Corner.BL then
        pt = LuaClass.Vector2(0, h)
    elseif corner == Corner.BL then
        pt = LuaClass.Vector2(w * 2, 0)
    elseif corner == Corner.BL then
        pt = LuaClass.Vector2(w * 2, h)
    else
        pt = LuaClass.Vector2.zero
    end
end

function BookView:touchBegin(context)
    LuaClass.GuiGTween.Kill(self.comp)
    self.draggingCorner = context.sender.data

    if self.draggingCorner == Corner.TL or self.draggingCorner == Corner.BL then
        if self.coverStatus == CoverStatus.ShowingBack then
            self.coverTurningOp = CoverTurningOp.HideBack
        elseif self.objectNewIndice[1] ~= -1 then
            if isValid(self.frontCover) and self.coverStatus ~= CoverStatus.ShowingFront then
                self.coverTurningOp = CoverTurningOp.ShowFront
            else
                self.draggingCorner = Corner.INVALID
            end
        else
            self.turningTarget = self.objectNewIndice[1] - 2
            if self.turningTarget < 0 then
                self.turningTarget = 0
            end
        end
    else
        if self.coverStatus == CoverStatus.ShowingFront then
            self.coverTurningOp = CoverTurningOp.HideFront
        elseif self.objectNewIndice[1] ~= -1 then
            if isValid(self.backCover) and self.coverStatus ~= CoverStatus.ShowingBack then
                self.coverTurningOp = CoverTurningOp.ShowBack
            else
                self.draggingCorner = Corner.INVALID
            end
        else
            self.turningTarget = self.objectNewIndice[1] + 1
        end
    end

    if self.draggingCorner ~= Corner.INVALID then
        self.touchDownTime = LuaClass.Time.unscaledTime
        self:updateDragPosition(context.inputEvent.position)
        self:renderPages()
        self:playTurnEffect()
        context:CaptureTouch()
    end
end

function BookView:touchMove(context)
    if self.draggingCorner ~= Corner.INVALID then
        self:updateDragPosition(context.inputEvent.position)
        self:playTurnEffect()
    end
end

function BookView:touchEnd()
    if self.draggingCorner ~= Corner.INVALID then
        local suc = self.turningAmount > 0.4 or LuaClass.Time.unscaledTime - self.touchDownTime < 0.35
        local target
        if suc then
            if self.draggingCorner == Corner.TL or self.draggingCorner == Corner.BL then
                target = self:getCornerPosition(self.draggingCorner + 2, self.coverTurningOp ~= CoverTurningOp.None)
            else
                target = self:getCornerPosition(self.draggingCorner - 2, self.coverTurningOp ~= CoverTurningOp.None)
            end
        else
            target = self:getCornerPosition(self.draggingCorner, self.coverTurningOp ~= CoverTurningOp.None)
        end

        local duration = LuaClass.Mathf.Max(0.25,math.abs(target.x - self.dragPoint.x) / (self.pageWidth * 2) * 0.5)

        LuaClass.GuiGTween.To(self.dragPoint, target, duration):SetTarget(self.comp):SetUserData(suc):OnUpdate(handler(self, self.onTurnUpdate)):OnComplete(handler(self, self.onTurnComplete))
    end
end

function BookView:dispose()
    for i, v in ipairs(self.objects) do
        if isValid(v) then
            v:Dispose()
        end
    end

    self.mask1:Dispose()
    self.mask2:Dispose()
    if isValid(self.softShadow) then
        self.softShadow:Dispose()
    end
end

return BookView