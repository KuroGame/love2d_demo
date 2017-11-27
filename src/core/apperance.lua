local Object = require("src/core/object")
local Apperance = Object:extend()

function Apperance:ctor(imgPrefix, duration)
    self.animation = newAnimation(imgPrefix, duration)
end

function Apperance:draw()
    local spriteNum = math.floor(self.animation.currentTime / self.animation.duration * #self.animation.frames) + 1
    -- X, Y, direction, scale
    love.graphics.draw(self.animation.frames[spriteNum], 0, 0)
end

function Apperance:update(dt)
    self.animation.currentTime = self.animation.currentTime + dt
    if self.animation.currentTime >= self.animation.duration then
        self.animation.currentTime = self.animation.currentTime - self.animation.duration
    end
end

function Apperance:reset()
    self.animation.currentTime = 0
end

function newAnimation(imagePrefix, duration)
    local animation = {}
    animation.frames = {};
 
    local idx = 0
    repeat
        local path = imagePrefix .. string.format("%03d", idx) .. ".png"
        if love.filesystem.exists(path) then
            local img = love.graphics.newImage(path)
            table.insert(animation.frames, img)
            idx = idx + 1
        else
            idx = -1
        end
    until (idx < 0)
 
    animation.duration = duration or 1
    animation.currentTime = 0
 
    return animation
end

return Apperance