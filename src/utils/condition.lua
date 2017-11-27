local Condition = {}
Condition.__index = Condition

function Condition:newTimeCondition(threshold)
    local t = function(duration)
        return (duration >= threshold)
    end
    return t
end

function Condition:newKeyboardCondition(key, action)
    local t = function()
        if action == "down" then
            return love.keyboard.isDown(key)
        elseif action == "up" then
            return not love.keyboard.isDown(key)
        end
        return false
    end
    return t
end

return Condition
