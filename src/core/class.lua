--
-- class.lua
--
-- Simple method to implement OOP in lua
--

local Class = {}
Class.__index = Class

function Class:ctor(...)
    error("'ctor(...)' is not implemented.")
end

function Class:__call(...)
    local obj = setmetatable({}, self)
    obj:ctor(...)
    return obj
end

function Class:extend()
    local cls = {}
    -- the __functions
    for k, v in pairs(self) do
        if k:find("__") == 1 then
            cls[k] = v
        end
    end
    cls.__index = cls
    -- give super methods
    cls.super = self
    return setmetatable(cls, self)
end

function Class:is(T)
    local mt = getmetatable(self)
    while mt do
        if mt == T then
            return true
        end
        mt = getmetatable(mt)
    end
    return false
end


return Class
