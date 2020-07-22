---Author：  houn
---DATE：    2020/6/26
---DES:      

---@class GameConfig
local GameConfig = {}
GameConfig.IS_DEBUG = false


GameConfig.LockedTimeStep = 20

-- for module display
GameConfig.CC_DESIGN_RESOLUTION = {
    width = 1136,
    height = 640,
    autoscale = "SHOW_ALL",
    callback = function(framesize)
        local ratio = framesize.width / framesize.height
        if ratio <= 1.34 then
            -- iPad 768*1024(1536*2048) is 4:3 screen
            return {autoscale = "FIXED_WIDTH"}
        end
    end
}

return GameConfig