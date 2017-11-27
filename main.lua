-- Simple Project
local bump = require("src/lib/bump")

local world = bump.newWorld(50)

-- global initialization
function love.load()
    Object = require("src/core/object")
    StateMachine = require("src/core/state_machine")
    Condition = require("src/core/condition")
    -- load images
    marisa = Object("marisa", 0, 0, 61, 109)
    enemy = Object("enemy", 100, 0, 61, 109)
    world:add(marisa, marisa.pos.x, marisa.pos.y, marisa.size.w, marisa.size.h)
    world:add(enemy, enemy.pos.x, enemy.pos.y, enemy.size.w, enemy.size.h)
    marisa:addApperance("stand", "asset/images/marisa/stand")
    marisa:addApperance("walkFront", "asset/images/marisa/walkFront")
    marisa:addApperance("walkBack", "asset/images/marisa/walkBack")
    marisa:addState("stand", "stand")
    marisa:addState("walkFront", "walkFront")
    marisa:addState("walkBack", "walkBack")
    enemy:addApperance("stand", "asset/images/marisa/stand")
    enemy:addState("stand", "stand")
    -- set states
    marisa:addStateEdge("stand", "walkFront", Condition:newKeyboardCondition("d", "down"))
    marisa:addStateEdge("walkFront", "stand", Condition:newKeyboardCondition("d", "up"))
    marisa:addStateEdge("stand", "walkBack", Condition:newKeyboardCondition("a", "down"))
    marisa:addStateEdge("walkBack", "stand", Condition:newKeyboardCondition("a", "up"))
end

function love.update(dt)
    -- collision
    local playerFilter = function(item, other)
        return 'slide'
        -- else return nil
    end
    marisa:update(dt)
    enemy:update(dt)
    if marisa:currentState() == "walkFront" then
        marisa:move(1.5, 0)
    elseif marisa:currentState() == "walkBack" then
        marisa:move(-1, 0)
    end
    if love.keyboard.isDown("s") then
        marisa:move(0, 2)
    end
    if love.keyboard.isDown("w") then
        marisa:move(0, -2)
    end
    local actualX, actualY, cols, len = world:move(marisa, marisa.pos.x, marisa.pos.y, playerFilter)
    marisa.pos.x = actualX
    marisa.pos.y = actualY
end

function love.draw()
    marisa:draw()
    enemy:draw()
end
