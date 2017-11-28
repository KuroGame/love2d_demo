-- Simple Project
local Scene = require("src/core/scene")
local Object = require("src/core/object")

-- global initialization
function love.load()
    scene = Scene()
    car = Object("car", 0, 0, 120, 120)
    enemy = Object("enemy", 400, 400, 120, 120)
    enemy:addApperance("ready", "asset/images/squares/car_ready")
    enemy:addState("ready", "ready")
    car:addApperance("ready", "asset/images/squares/car_ready")
    car:addApperance("reload", "asset/images/squares/car_reload", 0.5)
    car:addApperance("empty", "asset/images/squares/car_empty")
    car:addState("reload", "reload")
    car:addState("ready", "ready")
    car:addState("empty", "empty")
    local over = function(obj, state)
        return state.apperance.over
    end
    local timeOver = function(obj, state)
        return state.duration > 0.5
    end
    local keyF = function()
        return love.keyboard.isDown("f")
    end
    car:addStateEdge("reload", "ready", over)
    car:addStateEdge("empty", "reload", timeOver)
    car:addStateEdge("ready", "empty", keyF)
    scene:add("car", car, "player")
    scene:add("enemy", enemy)
end

function love.update(dt)
    if love.keyboard.isDown("j") then car:move(-2, 0) end
    if love.keyboard.isDown("l") then car:move(2, 0) end
    if love.keyboard.isDown("i") then car:move(0, -2) end
    if love.keyboard.isDown("k") then car:move(0, 2) end
    scene:update(dt)
end

function love.draw()
    scene:draw()
end
