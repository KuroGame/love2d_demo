-- include
local Class = require("src/core/class")
local Apperance = require("src/core/apperance")
local StateMachine = require("src/core/state_machine")
-- Object
local Object = Class:extend()

function Object:ctor(name, x, y, width, height)
    self.name = name
    self.pos = {x=x, y=y}
    self.size = {w=width, h=height}
    self.apperances = {}
    self.stateMachine = StateMachine(self)
end

function Object:addApperance(name, path, duration)
    self.apperances[name] = Apperance(path, self.pos, duration)
end

function Object:getApperance(name)
    return self.apperances[name]
end

-- Naive move with outh collision detection, should be called carefully
-- Usually called after collision detection in Scene
function Object:move(deltaX, deltaY)
    self.pos.x = self.pos.x + deltaX
    self.pos.y = self.pos.y + deltaY
end

function Object:setPosition(x, y)
    self.pos.x = x
    self.pos.y = y
end

function Object:addState(name, apperance)
    if type(apperance) == "string" then
        apperance = self.apperances[apperance]
    end
    if apperance:is(Apperance) then
        self.stateMachine:addState(name, apperance)
    end
end

function Object:addStateEdge(src, tar, cond)
    self.stateMachine:addEdge(src, tar, cond)
end

function Object:currentState()
    if self.stateMachine.curState then return self.stateMachine.curState.name end
end

function Object:update(dt)
    self.stateMachine:update(dt)
end

function Object:draw()
    self.stateMachine:draw()
end

return Object