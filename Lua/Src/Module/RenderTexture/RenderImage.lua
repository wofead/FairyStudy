---Author：  houn
---DATE：    2020/8/12
---DES:      

local LuaClass = LuaClass
local super = nil
---@class RenderImage
local RenderImage = class("RenderImage", super)

---@param holder FairyGUI.GGraph
function RenderImage:ctor(holder)
    self.width = holder.width
    self.height = holder.height
    self.cacheTexture = true

    ---@type FairyGUI.Image
    self.image = LuaClass.GuiImage()
    holder:SetNativeObject(self.image)

    local prefab = LuaClass.Resources.Load("RenderTexture/RenderImageCamera")
    local go = LuaClass.Object.Instantiate(prefab)
    ---@type UnityEngine.Camera
    local camera = go:GetComponent(typeof(LuaClass.Camera))
    self.camera = camera
    camera.transform.position = LuaClass.Vector3(0, 1000, 0)
    camera.cullingMask = 1 << 0
    camera.enabled = false
    LuaClass.Object.DontDestroyOnLoad(camera.gameObject)

    ---@type UnityEngine.Transform
    self.root = LuaClass.GameObject("RenderImage").transform
    self.root:SetParent(camera.transform, false)
    self:setLayer(self.root.gameObject, 10)

    ---@type UnityEngine.Transform
    self.modelRoot = LuaClass.GameObject("model_root").transform
    self.modelRoot:SetParent(self.root, false)

    ---@type UnityEngine.Transform
    self.background = LuaClass.GameObject("background").transform
    self.background:SetParent(self.root, false)

    self.image.onAddedToStage:Add(handler(self, self.onAddedToStage))
    self.image.onRemovedFromStage:Add(handler(self, self.onRemoveFromStage))
    if self.image.stage then
        self:onAddedToStage()
    else
        camera.gameObject:SetActive(false)
    end
end

function RenderImage:onRender(param)
    if self.rotating and self.rotating ~= 0 and self.modelRoot then
        local localRotation = self.modelRoot.localRotation.eulerAngles
        localRotation.y = localRotation.y + self.rotating
        self.modelRoot.localRotation = LuaClass.Quaternion.Euler(localRotation)
    end

    self:setLayer(self.root.gameObject, 0)
    self.camera.targetTexture = self.renderTexture
    local old = LuaClass.RenderTexture.active
    LuaClass.RenderTexture.active = self.renderTexture
    LuaClass.GL.Clear(true, true, LuaClass.Color.clear)
    self.camera:Render()
    LuaClass.RenderTexture.active = old
    self:setLayer(self.root.gameObject, 10)
end

---@param image FairyGUI.Image
---@param localRect UnityEngine.Rect
---@param uv UnityEngine.Vector2[]
function RenderImage:getImageUVRect(image, localRect, uv)
    local imageRect = LuaClass.Rect(0, 0, image.size.x, image.size.y)
    local bound = LuaClass.ToolSet.Intersection(imageRect, localRect)
    local uvRect = image.texture.uvRect

    if image.scale9Grid then
        local gridRect = image.scale9Grid
        local sourceW = image.texture.width
        local sourceH = image.texture.height
        uvRect = LuaClass.Rect.MinMaxRect(
                LuaClass.Mathf.Lerp(uvRect.xMin, uvRect.xMax, gridRect.xMin / sourceW),
                LuaClass.Mathf.Lerp(uvRect.yMin, uvRect.yMax, (sourceH - gridRect.yMax) / sourceH),
                LuaClass.Mathf.Lerp(uvRect.xMin, uvRect.xMax, gridRect.xMax / sourceW),
                LuaClass.Mathf.Lerp(uvRect.yMin, uvRect.yMax, (sourceH - gridRect.yMin) / sourceH)
        )
        local vw = imageRect.width - (sourceW - gridRect.width)
        local vh = imageRect.height - (sourceH - gridRect.height)
        uvRect = LuaClass.Rect.MinMaxRect(
                LuaClass.Mathf.Lerp(uvRect.xMin, uvRect.xMax, (bound.x - gridRect.x) / vw),
                LuaClass.Mathf.Lerp(uvRect.yMin, uvRect.yMax, (imageRect.height - bound.yMax - (sourceH - gridRect.yMax)) / vh),
                LuaClass.Mathf.Lerp(uvRect.xMin, uvRect.xMax, (bound.xMax - gridRect.x) / vw),
                LuaClass.Mathf.Lerp(uvRect.yMin, uvRect.yMax, (imageRect.height - bound.yMin - gridRect.y) / vh)
        )
    else
        uvRect = LuaClass.Rect.MinMaxRect(
                LuaClass.Mathf.Lerp(uvRect.xMin, uvRect.xMax, bound.xMin / imageRect.width),
                LuaClass.Mathf.Lerp(uvRect.yMin, uvRect.yMax, (imageRect.height - bound.yMax) / imageRect.height),
                LuaClass.Mathf.Lerp(uvRect.xMin, uvRect.xMax, bound.xMax / imageRect.width),
                LuaClass.Mathf.Lerp(uvRect.yMin, uvRect.yMax, (imageRect.height - bound.yMin) / imageRect.height)
        )
    end
    uv[1] = uvRect.position
    uv[2] = LuaClass.Vector2(uvRect.xMin, uvRect.yMax)
    uv[3] = LuaClass.Vector2(uvRect.xMax, uvRect.yMax)
    uv[4] = LuaClass.Vector2(uvRect.xMax, uvRect.yMin)
    if image.texture.rotated then
        LuaClass.ToolSet.RotateUV(uv, image.texture.uvRect)
    end
    return uvRect
end

function RenderImage:createTexture()
    if self.renderTexture then
        return
    end
    self.renderTexture = LuaClass.RenderTexture(self.width, self.height, 24, LuaClass.RenderTextureFormat.ARGB32)
    self.renderTexture.antiAliasing = 1
    --self.renderTexture.filterMode = LuaClass.UFilterModule.Bilinear
    self.renderTexture.anisoLevel = 0
    self.renderTexture.useMipMap = false
    self.image.texture = LuaClass.GuiNTexture(self.renderTexture)
    self.image.blendMode = LuaClass.BlendMode.Off
end

function RenderImage:loadModel(model)
    self:unloadModel()

    local prefab = LuaClass.Resources.Load(model)
    local go = LuaClass.Object.Instantiate(prefab)
    self.model = go.transform
    self.model:SetParent(self.modelRoot, false)
end

function RenderImage:unloadModel()
    if self.model then
        LuaClass.Object.Destroy(self.model.gameObject)
        self.model = nil
    end
    self.rotating = 0
end

function RenderImage:startRotate(delta)
    self.rotating = delta
end

function RenderImage:stopRotate()
    self.rotating = 0
end

function RenderImage:onAddedToStage()
    if not self.renderTexture then
        self:createTexture()
    end

    self.timer = App.timeManager:add(20, function()
        self:onRender()
    end, -1, nil)
    self.camera.gameObject:SetActive(true)
    self:onRender()
end

function RenderImage:onRemoveFromStage()
    if not self.cacheTexture then
        self:destroyTexture()
    end
    App.timeManager:remove(self.timer)
    self.camera.gameObject:SetActive(false)
end

function RenderImage:setLayer(go, layer)
    local transforms = go:GetComponentsInChildren(typeof(LuaClass.Transform), true)
    for i = 0, transforms.Length - 1 do
        transforms[i].gameObject.layer = layer
    end
end

function RenderImage:setBackGround(image1, image2)
    ---@type FairyGUI.Image
    local source1 = image1.displayObject
    ---@type FairyGUI.Image
    local source2
    if image2 then
        source2 = image2.displayObject
    end
    local pos = self.background.position
    pos.z = self.camera.farClipPlane
    self.background.position = pos

    local uv = {}
    local uv2

    local rect = self.image:TransformRect(LuaClass.Rect(0, 0, self.width, self.height), source1)
    local uvRect = self:getImageUVRect(source1, rect, uv)
    if source2 then
        rect = self.image:TransformRect(LuaClass.Rect(0, 0, self.width, self.height), source2)
        uv2 = {}
        self:getImageUVRect(source2, rect, uv2)
    end

    local vertices = {}
    for i = 1, 4 do
        local v = uv[i]
        vertices[i] = LuaClass.Vector3((v.x - uvRect.x) / uvRect.width * 2 - 1, (v.y - uvRect.y) / uvRect.height * 2 - 1, 0)
    end

    local mesh = LuaClass.Mesh()
    mesh.vertices = vertices
    mesh.uv = uv
    if uv2 then
        mesh.uv2 = uv2
    end
    mesh.colors32 = { LuaClass.Color.white, LuaClass.Color.white, LuaClass.Color.white, LuaClass.Color.white }
    mesh.triangles = { 0, 1, 2, 2, 3, 0 }

    local meshFilter = self.background.gameObject:GetComponent(typeof(LuaClass.MeshFilter))
    if not isValid(meshFilter) then
        meshFilter = self.background.gameObject:AddComponent(typeof(LuaClass.MeshFilter))
    end
    meshFilter.mesh = mesh
    local meshRenderer = self.background.gameObject:GetComponent(typeof(LuaClass.MeshRenderer))
    if not isValid(meshRenderer) then
        meshRenderer = self.background.gameObject:AddComponent(typeof(LuaClass.MeshRenderer))
    end
    meshRenderer.shadowCastingMode = LuaClass.ShadowCastingMode.Off
    meshRenderer.receiveShadows = false
    local shader = LuaClass.Shader.Find("Game/FullScreen")
    local mat = LuaClass.Material(shader)
    mat.mainTexture = source1.texture.nativeTexture
    if source2 then
        mat:SetTexture("_Tex2", source2.texture.nativeTexture)
    end
    meshRenderer.material = mat
end

function RenderImage:dispose()
    LuaClass.Object.Destroy(self.camera.gameObject)
    self:destroyTexture()
    self.image:Dispose()
    self.image = nil
end

function RenderImage:destroyTexture()
    if self.renderTexture then
        LuaClass.Object.Destroy(self.renderTexture)
        self.renderTexture = nil
        self.image.texture = nil
    end
end

return RenderImage