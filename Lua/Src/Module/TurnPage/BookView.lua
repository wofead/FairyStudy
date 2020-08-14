---Author：  houn
---DATE：    2020/8/13
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseLuaComponent
---@class BookView:BaseLuaComponent
local BookView = class("BookView", super)

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
    self.frontCover = self.comp:GetChild("frontCover")
    self.frontCoverPos = LuaClass.Vector2(self.frontCover.position.x, self.frontCover.position.y)

    ---@type FairyGUI.GComponent
    self.backCover = self.comp:GetChild("backCover")
    self.backCoverPos = LuaClass.Vector2(self.backCover.position.x, self.backCover.position.y)

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

function BookView:initPage(value)
    if self.currentPage ~= value then
        LuaClass.GuiGTween.Kill(self.comp, true)
        self.currentPage = value
        self.coverStatus = CoverStatus.Hidden

        self:renderPages()
    end
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
            self.coverStatus = CoverStatus.ShowingFront
            self.currentPage = 0
        else
            self.coverStatus = CoverStatus.ShowingBack
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
    local test = LuaClass.GuiGPathPoint(LuaClass.Vector3(source.x, source.y, 0))
    --LuaClass.Vector3(source.x, source.y, 0)
    --LuaClass.Vector3(mid.x, mid.y, 0)
    --LuaClass.Vector3(target.x, target.y, 0)
    self.turningPath:Create({LuaClass.GuiGPathPoint(LuaClass.Vector3(source.x, source.y, 0)), LuaClass.GuiGPathPoint(LuaClass.Vector3(mid.x, mid.y, 0)), LuaClass.GuiGPathPoint(LuaClass.Vector3(target.x, target.y, 0))})
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
    self.onTurnCompleteBook()
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
    local turningObj = (self.coverTurningOp == CoverTurningOp.ShowFront or self.coverTurningOp == CoverTurningOp.HideFront) and self.frontCover or self.backCover
    local mesh = self:getHardMesh(turningObj)
    if amount < 0.5 then
        ratio = 1 - amount * 2
        isLeft = self.coverTurningOp == CoverTurningOp.ShowFront or self.coverTurningOp == CoverTurningOp.HideBack
    else
        ratio = (amount - 0.5) * 2
        isLeft = self.coverTurningOp == CoverTurningOp.HideFront or self.coverTurningOp == CoverTurningOp.ShowBack
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
        turningObj = self.objects[3]
        mesh = self:getHardMesh(turningObj)
        self:etHardMesh(self.objects[4]).points:Clear()
    else
        ratio = (amount - 0.5) * 2
        sLeft = self.turningTarget > self.currentPage
        turningObj = self.objects[4]
        mesh = self:getHardMesh(turningObj)
        self:etHardMesh(self.objects[3].points:Clear())
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

function BookView:playSoftEffect()
    local turningObj1 = self.objects[3]
    local turningObj2 = self.objects[4]
    local mesh1 = self:getSoftMesh(turningObj1)
    local mesh2 = self:getSoftMesh(turningObj2)
    --
    --*               a
    --*              /  \
    --* f(0,0)------/    b--g(w,0)
    --* |          /     /  |
    --* |         /     /   |
    --* |        c     /    |
    --* |         \   /     |
    --* |          \ /      |
    --* e(0,h)-----d--------h(w,h)
    --
    local pa, pb, pc, pd, pe, pf, pg, ph, k, angle
    local threePoints = false
    pc = self.dragPoint
    pe = LuaClass.Vector2(0, self.pageHeight)
    pf = LuaClass.Vector2.zero
    pg = LuaClass.Vector2(self.pageWidth, 0)
    ph = LuaClass.Vector2(self.pageWidth, self.pageHeight)

    self:flipPoint(pc, self.pageWidth * 2, self.pageHeight)

    pc.x = pc.x - self.pageWidth
    if pc.x > self.pageWidth then
        return
    end

    k = (ph.y - pc.y) / (ph.x - pc.x)
    local k2 = 1 + k * k
    local min = ph.x - self.pageWidth * 2 / k2
    if pc.x < min then
        pc.x = min
        if pc.x >= self.pageWidth then
            return
        end
        pc.y = ph.y - k * (ph.x - pc.x)
    end

    min = ph.x - (self.pageWidth + self.pageHeight * k) * 2 / k2
    if pc.x < min then
        pc.x = min
        if pc.x >= self.pageWidth then
            return
        end
        pc.y = ph.y - k * (ph.x - pc.x)
    end

    angle = LuaClass.Mathf.Atan(k) * LuaClass.Mathf.Rad2Deg
    pd = LuaClass.Vector2(self.pageWidth - k2 * (ph.x - pc.x) / 2, self.pageHeight)
    pb = LuaClass.Vector2(pd.x + self.pageHeight * k, 0)
    pa = LuaClass.Vector2()

    if pb.x > self.pageWidth then
        pb.x = self.pageWidth
        pa = LuaClass.Vector2(self.pageWidth, self.pageHeight - (self.pageWidth - pd.x) / k)
        threePoints = true
    end
    self:flipPoint(pa, self.pageWidth, self.pageHeight)
    self:flipPoint(pb, self.pageWidth, self.pageHeight)
    self:flipPoint(pc, self.pageWidth, self.pageHeight)
    self:flipPoint(pd, self.pageWidth, self.pageHeight)
    if self.draggingCorner == Corner.BL or self.draggingCorner == Corner == Corner.TL then
        angle = -angle
    end

    if self.draggingCorner == Corner.BR then
        turningObj1:SetPivot(0, 0, true)
        turningObj1.position = LuaClass.Vector2(self.pageWidth, 0)

        turningObj2:SetPivot(0, 1, true)
        turningObj2.position = LuaClass.Vector2(self.pageWidth + pc.x, pc.y)
        turningObj2.rotation = 2 * angle

        if isValid(self.softShadow) then
            self.softShadow:SetPivot(1, (self.softShadow.height - 30) / self.softShadow.height, true)
            self.softShadow.position = LuaClass.Vector2(LuaClass.Vector2.Distance(pc, pd), self.pageHeight)
            self.softShadow.rotation = -angle
            if self.softShadow.x > self.pageWidth - 20 then
                self.softShadow.alpha = (self.pageWidth - self.softShadow.x) / 20
            else
                self.softShadow.alpha = 1

            end
        end

        mesh1.points:Clear()
        mesh1:Add(pe)
        mesh1:Add(pf)
        mesh1:Add(pb)
        if threePoints then
            mesh1:Add(pa)
        end
        mesh1:Add(pd)

        mesh2.points:Clear()
        mesh2:Add(LuaClass.Vector2(LuaClass.Vector2.Distance(pc, pd), self.pageHeight))
        mesh2:Add(LuaClass.Vector2(0, self.pageHeight))
        if threePoints then
            mesh2:Add(LuaClass.Vector2(0, self.pageHeight - LuaClass.Vector2.Distance(pc, pa)))
        else
            mesh2:Add(LuaClass.Vector2(0, 0))
            mesh2:Add(LuaClass.Vector2(LuaClass.Vector2.Distance(pg, pb), 0))
        end
    elseif self.draggingCorner == Corner.TR then
        turningObj1:SetPivot(0, 0, true)
        turningObj1.position = LuaClass.Vector2(self.pageWidth, 0)

        turningObj2:SetPivot(0, 0, true)
        turningObj2.position = LuaClass.Vector2(self.pageWidth + pc.x, pc.y)
        turningObj2.rotation = -2 * angle

        if isValid(self.softShadow) then
            self.softShadow:SetPivot(1, 30 / self.softShadow.height, true)
            self.softShadow.position = LuaClass.Vector2(LuaClass.Vector2.Distance(pc, pd), 0)
            self.softShadow.rotation = angle
            if self.softShadow.x > self.pageWidth - 20 then
                self.softShadow.alpha = (self.pageWidth - self.softShadow.x) / 20
            else
                self.softShadow.alpha = 1

            end
        end

        mesh1.points:Clear()
        mesh1:Add(pe)
        mesh1:Add(pf)
        mesh1:Add(pd)
        if threePoints then
            mesh1:Add(pa)
        end
        mesh1:Add(pb)

        mesh2.points:Clear()
        if threePoints then
            mesh2:Add(LuaClass.Vector2(0, LuaClass.Vector2.Distance(pc, pa)))
        else
            mesh2:Add(LuaClass.Vector2(LuaClass.Vector2.Distance(pb, ph), self.pageHeight))
            mesh2:Add(LuaClass.Vector2(0, self.pageHeight))
        end
        mesh2.Add(LuaClass.Vector2(0, 0))
        mesh2.Add(LuaClass.Vector2(LuaClass.Vector2.Distance(pc, pd), 0))
    elseif self.draggingCorner == Corner.BL then
        turningObj1:SetPivot(0, 0, true)
        turningObj1.position = LuaClass.Vector2.zero

        turningObj2:SetPivot(1, 1, true)
        turningObj2.position = pc
        turningObj2.rotation = 2 * angle

        if isValid(self.softShadow) then
            self.softShadow:SetPivot(1, 30 / self.softShadow.height, true)
            self.softShadow.position = LuaClass.Vector2(self.pageWidth - LuaClass.Vector2.Distance(pc, pd), self.pageHeight)
            self.softShadow.rotation = 180 - angle
            if self.softShadow.x < 20 then
                self.softShadow.alpha = (self.softShadow.x - 20) / 20
            else
                self.softShadow.alpha = 1

            end
        end

        mesh1.points:Clear()
        mesh1:Add(pb)
        mesh1:Add(pg)
        mesh1:Add(ph)
        mesh1:Add(pd)
        if threePoints then
            mesh1:Add(pa)
        end

        mesh2.points:Clear()
        if threePoints then
            mesh2:Add(LuaClass.Vector2(self.pageWidth, self.pageHeight - LuaClass.Vector2.Distance(pc, pa)))
        else
            mesh2:Add(LuaClass.Vector2(self.pageWidth - LuaClass.Vector2.Distance(pf, pb), 0))
            mesh2:Add(LuaClass.Vector2(self.pageWidth, 0))
        end
        mesh2.Add(LuaClass.Vector2(self.pageWidth, self.pageHeight))
        mesh2.Add(LuaClass.Vector2(self.pageWidth - LuaClass.Vector2.Distance(pc, pd), self.pageHeight))
    elseif self.draggingCorner == Corner.TL then
        turningObj1:SetPivot(0, 0, true)
        turningObj1.position = LuaClass.Vector2.zero

        turningObj2:SetPivot(1, 0, true)
        turningObj2.position = pc
        turningObj2.rotation = -2 * angle

        if isValid(self.softShadow) then
            self.softShadow:SetPivot(1, (self.softShadow.height - 30) / self.softShadow.height, true)
            self.softShadow.position = LuaClass.Vector2(self.pageWidth - LuaClass.Vector2.Distance(pc, pd), 0)
            self.softShadow.rotation = 180 + angle
            if self.softShadow.x < 20 then
                self.softShadow.alpha = (self.softShadow.x - 20) / 20
            else
                self.softShadow.alpha = 1

            end
        end

        mesh1.points:Clear()
        mesh1:Add(pd)
        mesh1:Add(pg)
        mesh1:Add(ph)
        mesh1:Add(pb)
        if threePoints then
            mesh1:Add(pa)
        end

        mesh2.points:Clear()
        mesh2:Add(LuaClass.Vector2(self.pageHeight - LuaClass.Vector2.Distance(pc, pd), 0))
        mesh2:Add(LuaClass.Vector2(self.pageWidth, 0))
        if threePoints then
            mesh2:Add(LuaClass.Vector2(self.pageWidth, LuaClass.Vector2.Distance(pc, pa)))
        else
            mesh2:Add(LuaClass.Vector2(self.pageWidth, self.pageHeight))
            mesh2:Add(LuaClass.Vector2(self.pageWidth - LuaClass.Vector2.Distance(pe, pb), self.pageHeight))
        end
    end
end

function BookView:renderPages()
    self:renderCovers()
    if self.softShadow then
        self.softShadow:RemoveFromParent()
    end

    local curPage = self.currentPage
    if curPage % 2 == 0 then
        curPage = curPage - 1
    end
    local leftPage, rightPage, turningPageBack, turningPageFront
    leftPage = curPage
    rightPage = leftPage < self.pageCount - 1 and (leftPage + 1) or -1
    if self.turningTarget ~= -1 then
        local tt = self.turningTarget
        if tt % 2 == 0 then
            tt = tt - 1
        end
        if tt == curPage then
            self.currentPage = self.turningTarget
            turningPageBack = -1
            turningPageFront = -1
        elseif tt > leftPage then
            turningPageBack = rightPage
            turningPageFront = tt
            rightPage = tt < self.pageCount - 1 and (tt + 1) or -1
        else
            turningPageBack = tt > 0 and (tt + 1) or 0
            turningPageFront = leftPage
            rightPage = tt > 0 and tt or -1
        end
    else
        turningPageBack = -1
        turningPageFront = -1
    end

    self.objectNewIndice[1] = leftPage
    self.objectNewIndice[2] = rightPage
    self.objectNewIndice[3] = turningPageBack
    self.objectNewIndice[4] = turningPageFront
    local objectNewIndice = self.objectNewIndice
    printJow("BookView")
    for i = 1, 4 do
        local pageIndex = self.objectNewIndice[i]
        if pageIndex ~= -1 then
            for j = 1, 4 do
                local pageIndex2 = self.objectIndice[j]
                if pageIndex2 == pageIndex then
                    if j ~= i then
                        self.objectIndice[j] = self.objectIndice[i]
                        self.objectIndice[i] = pageIndex

                        local tmp = self.objects[j]
                        self.objects[j] = self.objects[i]
                        self.objects[i] = tmp
                    end
                    break
                end
            end
        end
    end

    for i = 1, 4 do
        local obj = self.objects[i]
        local oldIndex = self.objectIndice[i]
        local index = self.objectNewIndice[i]
        self.objectIndice[i] = index
        if index == -1 then
            if isValid(obj) then
                obj:RemoveFromParent()
            end
        elseif oldIndex ~= index then
            if not isValid(obj) then
                obj = LuaClass.GuiUIPackage.CreateObjectFromURL(self.pageResource)
                obj.displayObject.home = self.comp.displayObject.cachedTransform
                self.objects[i] = obj
            end
        else
            if not isValid(obj.parent) then
                self.pagesContainer:AddChild(obj)
                self.pageRenderer(index, obj)
            else
                self.pagesContainer:AddChild(obj)
            end
        end

        if isValid(obj) and isValid(obj.parent) then
            local c1 = obj:GetController("side")
            if isValid(c1) then
                if index == 0 then
                    c1.selectedPage = "first"
                elseif index == self.pageCount - 1 then
                    c1.selectedPage = "last"
                else
                    c1.selectedPage = (index % 2 == 0) and "right" or "left"
                end
            end
            if i == 0 or i == 1 then
                self:setPageNormal(obj, i == 0)
            elseif self.paper == Paper.Soft then
                self:setPageSoft(obj, i == 2)
            else
                self:setPageHard(obj, i == 2)
            end
        end
    end
end

function BookView:renderCovers()
    if self.frontCover then
        if self.coverTurningOp == CoverTurningOp.ShowFront or self.coverTurningOp == CoverTurningOp.HideFront then
            self:setPageHard(self.frontCover, true)
            self:setCoverStatus(self.frontCover, CoverType.Front, self.coverTurningOp == CoverTurningOp.HideFront)
        else
            if self.frontCover.displayObject.cacheAsBitmap then
                self:setCoverNormal(self.frontCover, CoverType.Front)
            end
            self:setCoverStatus(self.frontCover, CoverType.Front, self.coverStatus == CoverStatus.ShowingFront)
        end
    end

    if self.backCover then
        if self.coverTurningOp == CoverTurningOp.ShowBack or self.coverTurningOp == CoverTurningOp.HideBack then
            self:setPageHard(self.backCover, true)
            self:setCoverStatus(self.backCover, CoverType.Back, self.coverTurningOp == CoverTurningOp.HideBack)
        else
            if self.backCover.displayObject.cacheAsBitmap then
                self:setCoverNormal(self.backCover, CoverType.Back)
            end
            self:setCoverStatus(self.backCover, CoverType.Back, self.coverStatus == CoverStatus.ShowingBack)
        end
    end
end

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
            obj.position = coverType == CoverType.Front and LuaClass.Vector3(self.backCoverPos.x, self.backCoverPos.y, 0) or LuaClass.Vector3(self.frontCoverPos.x, self.frontCoverPos.y, 0)
            obj.parent:SetChildIndexBefore(obj, obj.parent:GetChildIndex(self.pagesContainer) + 1)
            c.selectedIndex = 0

            if obj.displayObject.cacheAsBitmap then
                obj.displayObject.cacheAsBitmap = true
            end
        end
    else
        if c.selectedIndex ~= 1 then
            obj.position = coverType == CoverType.Front and LuaClass.Vector3(self.frontCoverPos.x, self.frontCoverPos.y, 0) or LuaClass.Vector3(self.backCoverPos.x, self.backCoverPos.y, 0)
            obj.parent:SetChildIndexBefore(obj, obj.parent:GetChildIndex(self.pagesContainer))
            c.selectedIndex = 1

            if obj.displayObject.cacheAsBitmap then
                obj.displayObject.cacheAsBitmap = true
            end
        end
    end
end

function BookView:setCoverNormal(obj, coverType)
    obj.position = coverType == CoverType.Front and LuaClass.Vector3(self.frontCoverPos.x, self.frontCoverPos.y, 0) or LuaClass.Vector3(self.backCoverPos.x, self.backCoverPos.y, 0)
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
    local w = isCover and self.frontCover.width or self.pageWidth
    local h = isCover and self.frontCover.height or self.pageHeight
    local pt
    if corner == Corner.BL then
        pt = LuaClass.Vector2(0, h)
    elseif corner == Corner.TR then
        pt = LuaClass.Vector2(w * 2, 0)
    elseif corner == Corner.BR then
        pt = LuaClass.Vector2(w * 2, h)
    else
        pt = LuaClass.Vector2.zero
    end
    return pt
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
        elseif self.objectNewIndice[2] ~= -1 then
            if isValid(self.backCover) and self.coverStatus ~= CoverStatus.ShowingBack then
                self.coverTurningOp = CoverTurningOp.ShowBack
            else
                self.draggingCorner = Corner.INVALID
            end
        else
            self.turningTarget = self.objectNewIndice[2] + 1
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

        local duration = LuaClass.Mathf.Max(0.25, math.abs(target.x - self.dragPoint.x) / (self.pageWidth * 2) * 0.5)

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