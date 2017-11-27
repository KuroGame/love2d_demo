local Object = require("src/core/object")
local Scene = Object:extend()

function Scene:ctor(distanceFunc)
    -- the objects contains all things in the scene
    -- including players, enemies, items and so on
    self.objects = {}
    self.players = {}
    self.graph = {}
    -- default distance metric is L1 norm
    self.distanceFunc = distanceFunc or function(a, b)
        return math.abs(a.x - b.x) + math.abs(a.y - b.y)
    end
end

function Scene:addObject(name, obj, objType)
    self.objects[name] = {
        name=name,
        object=obj,
        type=objType
    }
    self.graph[name] = {}
    if objType == "player" then
        self.players[name] = self.objects[name]
    end
end

function Scene:addDistanceMeasure(srcName, tarName, both)
    -- default: directed edge
    both = (both == nil) and false or both
    self.graph[srcName].tarName = {
        target=self.objects[tar],
        distance=-1
    }
end

function Scene:update(dt)
    -- update time
    for k, v in pairs(self.objects) do
        v:update(dt)
    end

    -- update collision
    -- to-do

    -- update distance
    for ke, edges in pairs(self.graph) do
        local src = self.objects[ke]
        for k, v in pairs(edges) do
            local tar = v.target
            v.distance = self.distanceFunc(src, tar)
        end
    end
end

return Scene