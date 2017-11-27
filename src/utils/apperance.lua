local Object = require("src/misc/object")
local Apperance = Object:extend()

function Apperance:ctor(imgPath, width, height, duration)
    self.animation = newAnimation(love.graphics.newImage(imgPath), width, height, duration)
end

function Apperance:draw()
    local spriteNum = math.floor(self.animation.currentTime / self.animation.duration * #self.animation.quads) + 1
    -- X, Y, direction, scale
    love.graphics.draw(self.animation.spriteSheet, self.animation.quads[spriteNum], heroX, heroY, 0, 10)
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

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    animation.duration = duration or 1
    animation.currentTime = 0
 
    return animation
end

return Apperance