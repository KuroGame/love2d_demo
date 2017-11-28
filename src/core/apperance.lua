local Class = require("src/core/class")
local Apperance = Class:extend()

function Apperance:ctor(imgPrefix, pos, duration)
    self.animation = newAnimation(imgPrefix, duration)
    self.pos = pos
    self.over = false
end

function Apperance:draw()
    local spriteNum = math.floor(self.animation.currentTime / self.animation.duration * #self.animation.frames) + 1
    -- X, Y, direction, scale
    local img = self.animation.frames[spriteNum]
    love.graphics.draw(img, self.pos.x, self.pos.y)
end

function Apperance:update(dt)
    local spriteNum = math.floor(self.animation.currentTime / self.animation.duration * #self.animation.frames) + 1
    if spriteNum == #self.animation.frames then
        self.over = true
        return
    end
    self.animation.currentTime = self.animation.currentTime + dt
    if self.animation.currentTime >= self.animation.duration then
        self.animation.currentTime = self.animation.currentTime - self.animation.duration
    end
end

function Apperance:reset()
    self.animation.currentTime = 0
    self.over = false
end

function newAnimation(imagePrefix, duration)
    local animation = {}
    animation.frames = {};
 
    local idx = 0
    repeat
        local path = imagePrefix .. string.format("%02d", idx) .. ".png"
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