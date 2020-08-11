---Author：  houn
---DATE：    2020/6/26
---DES:      UI扩展类，主要扩展UI操作的时间

---@class UiOperateUntil
local UiOperateUntil = {}

UiOperateUntil.UIEventType = {
    ---触摸开始
    ["TouchBegin"] = "onTouchBegin",
    ---触摸移动
    ["TouchMove"] = "onTouchMove",
    ---触摸结束
    ["TouchEnd"] = "onTouchEnd",
    ---点击事件
    ["Click"] = "onClick",
    ---拖动开始
    ["DragStart"] = "onDragStart",
    ---拖动中
    ["DragMove"] = "onDragMove",
    ---拖动结束
    ["DragEnd"] = "onDragEnd",
    ---长按
    ["Action"] = "onAction",
    ---长按移动
    ["Move"] = "onMove",
    ---长按结束
    ["End"] = "onEnd",
    ---列表项目
    ["ClickItem"] = "onClickItem",
    ---滚动
    ["Scroll"] = "onScroll",
    ---滚动结束
    ["ScrollEnd"] = "onScrollEnd",
    ---下拉框改变
    ["Changed"] = "onChanged",
    ---输入框获取焦点
    ["FocusIn"] = "onFocusIn",
    ---输入框失去焦点
    ["FocusOut"] = "onFocusOut",
    ---pc端监听输入框的键盘enter点击事件
    ["Submit"] = "onSubmit",
    ---富文本链接点击事件
    ["ClickLink"] = "onClickLink",
    ---输入框的键盘点击事件
    ["KeyDown"] = "onKeyDown",
}

function UiOperateUntil.registerUIEvent(target, eventType, funCall)
    if isValid(target) then
        if isValid(target[eventType]) then
            target[eventType]:Set(
                    function(context)
                        xpcall(funCall, function(msg)
                            error(string.format("UIEvent %s的%s事件回调方法失败", target.name, eventType) .. "\n" .. debug.traceback())
                        end, context)
                    end)
        else
            error(string.format("UIEvent %s的%s事件没有", target.name, eventType))
        end
    end
end

--手势相关的时间
function UiOperateUntil.createGesture()

end

return UiOperateUntil