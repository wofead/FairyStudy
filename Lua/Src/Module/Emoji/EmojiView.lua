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
end

function EmojiView:onEnter()
    super.onEnter(self)
    self:registerEvent()
end

function EmojiView:registerEvent()
    local ui = self.ui
    local eventType = LuaClass.UiOperateUntil.UIEventType
    local registerEventFunc = LuaClass.UiOperateUntil.registerUIEvent
    App.keyManager:registerPressHandler(LuaClass.KeyCode.Escape, "Escape", handler(self, self.closeView))
end

function EmojiView:unRegisterEvent()
    App.keyManager:unregisterPressHandler(LuaClass.KeyCode.Escape, handler(self, self.closeView))
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