---Author：  houn
---DATE：    2020/8/5
---DES:      

local LuaClass = LuaClass
local super = LuaClass.BaseUi
---@class EmojiView:BaseUi
local EmojiView = class("EmojiView", super)

local module = App.emojiModule

local eventDispatcher = module.eventDispatcher

---@type UiConstant
EmojiView.uiConfig = LuaClass.UiConstant.Emoji

function EmojiView:init()
    LuaClass.GuiUIConfig.verticalScrollBar = "ui://Emoji/ScrollBar_VT"
    LuaClass.GuiUIConfig.defaultScrollBarDisplay = LuaClass.ScrollBarDisplayType.Auto
    ---@type FairyGUI.GList
    local list = self.ui.list
    list:SetVirtual()
    list.itemProvider = handler(self, self.itemProvider)
    list.itemRenderer = handler(self, self.itemRenderer)
    self.chatList = list

    ---@type FairyGUI.GComponent
    self.emojiSelectUi1 = LuaClass.GuiUIPackage.CreateObject("Emoji", "EmojiSelectUI")
    self.emojiSelectUi1.fairyBatching = true
    ---@type FairyGUI.GList
    self.emojiSelectUiList1 = self.emojiSelectUi1:GetChild("list")
    ---@type FairyGUI.GComponent
    self.emojiSelectUi2 = LuaClass.GuiUIPackage.CreateObject("Emoji", "EmojiSelectUI_ios")
    self.emojiSelectUi2.fairyBatching = true
    ---@type FairyGUI.GList
    self.emojiSelectUiList2 = self.emojiSelectUi2:GetChild("list")
    self.messageCache = {}

    self.emojies = {}
    for i = 0x1f600, 0x1f637 do
        local url = LuaClass.GuiUIPackage.GetItemURL("Emoji", string.format("%X", i))
        self.emojies[i] = url
    end
    self.ui.input2.emojies = self.emojies
end

function EmojiView:itemProvider(index)
    local msg = self.messageCache[index + 1]
    if msg.fromMe then
        return "ui://Emoji/chatRight"
    else
        return "ui://Emoji/chatLeft"
    end
end

--这个index为显示对象索引
--itemRenderer(i, GetChildAt(i))
---@param obj FairyGUI.GButton
function EmojiView:itemRenderer(index, obj)
    --显示对象和item的数量在数量上和顺序上是不一致的
    --转换项目索引为显示对象索引  ItemIndexToChildIndex
    --转换显示对象索引为项目索引  ChildIndexToItemIndex
    local msg = self.messageCache[index + 1]
    if not msg.fromMe then
        obj:GetChild("name").text = msg.sender
    end
    obj.icon = LuaClass.GuiUIPackage.GetItemURL("Emoji", msg.senderIcon)
    ---@type FairyGUI.GRichTextField
    local tf = obj:GetChild("msg")
    tf.emojies = self.emojies
    tf.text = msg.msg
end

function EmojiView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function EmojiView:addMsg(sender, senderIcon, msg, fromMe)
    local isScrollBottom = self.chatList.scrollPane.isBottomMost
    local newMsg = {}
    newMsg.sender = sender
    newMsg.senderIcon = senderIcon
    newMsg.msg = msg
    newMsg.fromMe = fromMe
    table.insert(self.messageCache, newMsg)
    if fromMe then
        if #self.messageCache == 1 or math.random() < 0.5 then
            local replyMsg = {}
            replyMsg.sender = "FairyGUI"
            replyMsg.senderIcon = "r1"
            replyMsg.msg = "Today is a good day."
            replyMsg.fromMe = false
            table.insert(self.messageCache, replyMsg)
        end
    end
    self.chatList.numItems = #self.messageCache
    if isScrollBottom then
        self.chatList.scrollPane:ScrollBottom()
    end
end

function EmojiView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
    registerEventFunc(ui.input1, eventType.KeyDown, handler(self, self.onKeyDown1))
    registerEventFunc(ui.input2, eventType.KeyDown, handler(self, self.onKeyDown2))
    registerEventFunc(ui.input2, eventType.Submit, handler(self, self.onKeyDown3))
    registerEventFunc(ui.btnSend1, eventType.Click, handler(self, self.onClickSend1))
    registerEventFunc(ui.btnSend2, eventType.Click, handler(self, self.onClickSend2))
    registerEventFunc(ui.btnEmoji1, eventType.Click, handler(self, self.onClickEmojiBtn1))
    registerEventFunc(ui.btnEmoji2, eventType.Click, handler(self, self.onClickEmojiBtn2))
    registerEventFunc(self.emojiSelectUiList1, eventType.ClickItem, handler(self, self.onClickEmoji1))
    registerEventFunc(self.emojiSelectUiList2, eventType.ClickItem, handler(self, self.onClickEmoji2))
end

---@param context FairyGUI.EventContext
function EmojiView:onKeyDown1(context)
    if context.inputEvent.keyCode == LuaClass.KeyCode.Return then
        self.ui.btnSend1.onClick:Call()
    end
end

---@param context FairyGUI.EventContext
function EmojiView:onKeyDown2(context)
    if context.inputEvent.keyCode == LuaClass.KeyCode.Return then
        self.ui.btnSend2.onClick:Call()
    end
end

---@param context FairyGUI.EventContext
function EmojiView:onKeyDown3(context)
    printJow("EmojiView", context.inputEvent.keyCode, LuaClass.KeyCode.Return)
    --if context.inputEvent.keyCode == LuaClass.KeyCode.Return then
    --    self.ui.btnSend2.onClick:Call()
    --end
end

---@param context FairyGUI.EventContext
function EmojiView:onClickSend1(context)
    local msg = self.ui.input1.text
    if #msg == 0 then
        return
    end
    self:addMsg("Unity", "r0", msg, true)
    self.ui.input1.text = ""
end

---@param context FairyGUI.EventContext
function EmojiView:onClickSend2(context)
    local msg = self.ui.input2.text
    if #msg == 0 then
        return
    end
    self:addMsg("Unity", "r0", msg, true)
    self.ui.input2.text = ""
end

---@param context FairyGUI.EventContext
function EmojiView:onClickEmojiBtn1(context)
    LuaClass.GuiGRoot.inst:ShowPopup(self.emojiSelectUi1, context.sender, LuaClass.PopupDirection.Up)
end

---@param context FairyGUI.EventContext
function EmojiView:onClickEmojiBtn2(context)
    LuaClass.GuiGRoot.inst:ShowPopup(self.emojiSelectUi2, context.sender, LuaClass.PopupDirection.Up)
end

---@param context FairyGUI.EventContext
function EmojiView:onClickEmoji1(context)
    ---@type FairyGUI.GTextInput
    local input = self.ui.input1
    --input:ReplaceSelection()
    self.ui.input1:ReplaceSelection("[:" .. context.data.text .. "]")
end

---@param context FairyGUI.EventContext
function EmojiView:onClickEmoji2(context)
    --Char.ConvertFromUtf32(Convert.ToInt32(UIPackage.GetItemByURL(item.icon).name, 16))
    local emojiName = LuaClass.GuiUIPackage.GetItemByURL(context.data.icon).name
    printJow("EmojiView", emojiName)
    self.ui.input2:ReplaceSelection(emojiName)
end

function EmojiView:unRegisterEvent()
end

function EmojiView:closeView()
    module:closeView()
end

function EmojiView:onExit()
    self:unRegisterEvent()
end

function EmojiView:dispose()
    super.dispose(self)
end

return EmojiView