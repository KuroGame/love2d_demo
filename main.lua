-- Simple Project

-- global initialization
function love.load()
    Apperance = require("src/core/apperance")
    StateMachine = require("src/core/state_machine")
    Condition = require("src/core/condition")
    -- load images
    marisa_stand = Apperance("asset/images/marisa/stand")
    marisa_walkFront = Apperance("asset/images/marisa/walkFront")
    marisa_walkBack = Apperance("asset/images/marisa/walkBack")
    -- set states
    states = StateMachine()
    states:addState("stand", marisa_stand)
    states:addState("walkFront", marisa_walkFront)
    states:addState("walkBack", marisa_walkBack)
    states:addEdge("stand", "walkFront", Condition:newKeyboardCondition("d", "down"))
    states:addEdge("walkFront", "stand", Condition:newKeyboardCondition("d", "up"))
    states:addEdge("stand", "walkBack", Condition:newKeyboardCondition("a", "down"))
    states:addEdge("walkBack", "stand", Condition:newKeyboardCondition("a", "up"))
end

function love.update(dt)
    states:update(dt)
end

function love.draw()
    states:draw()
end