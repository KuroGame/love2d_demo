local Class = require("src/core/class")
local StateMachine = Class:extend()

-- constructor
function StateMachine:ctor(obj)
    self.states = {}
    self.graph = {}
    self.curState = nil
    self.curGraph = nil
    self.object = obj
end

function StateMachine:addState(name, apperance)
    -- init a state
    self.states[name] = {
        name=name,
        apperance=apperance,
        duration= 0                                 -- the duration of a state
    }
    -- init the graph for the new state
    self.graph[name] = {}
    -- give an init state
    if self.curState == nil then
        self.curState = self.states[name]
        self.curGraph = self.graph[name]
    end
end

function StateMachine:addEdge(srcState, tarState, condition)
    table.insert(
        self.graph[srcState],
        {
            condition=condition,
            target=tarState
        }
    )
end

function StateMachine:draw()
    -- use the current state's apperance to draw
    if self.curState ~= nil then
        self.curState.apperance:draw()
    end
end

function StateMachine:update(dt)
    if self.curState ~= nil then
        self.curState.apperance:update(dt)
        self.curState.duration = self.curState.duration + dt
        for k, v in pairs(self.curGraph) do
            if v.condition(self.object, self.curState) then
                self:enterState(v.target)
            end
        end
    end
end

function StateMachine:enterState(name)
    if self.curState ~= nil then
        self.curState.duration = 0
        self.curState.apperance:reset()
    end
    self.curState = self.states[name]
    self.curGraph = self.graph[name]
end


return StateMachine
