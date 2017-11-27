-- Simple Project

-- global initialization
function love.load()
    Condition = require("src/utils/condition")
    StateMachine = require("src/utils/state_machine")
    Apperance = require("src/utils/apperance")

    local anime_stand = Apperance("one.png", 16, 18, 1)
    local anime_move = Apperance("oldHero.png", 16, 18, 1)
    states = StateMachine()
    states:addState("stand", anime_stand)
    states:addState("move", anime_move)
    states:addEdge("stand", "move", Condition:newKeyboardCondition("w", "down"))
    states:addEdge("move", "stand", Condition:newKeyboardCondition("w", "up"))
end

function love.update(dt)
    states:update(dt)
end

function love.draw()
    states:draw()
end
