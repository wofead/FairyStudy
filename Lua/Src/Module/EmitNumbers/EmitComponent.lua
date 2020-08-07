-- @Author: jow
-- @Date:   2020/8/7 16:18
-- @Des:    
local LuaClass = LuaClass
local super = LuaClass.BaseLuaComponent
---@class EmitComponent:BaseLuaComponent
local EmitComponent = class("EmitComponent", super)

function EmitComponent:ctor(gameObject)
    super.ctor(self, gameObject)
    self:init()
end

function EmitComponent:init()

end

function EmitComponent:onHpChange(value)

end

return EmitComponent
