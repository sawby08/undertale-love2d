local input = {}

local keyMap = {
    -- General keys
    up = conf.keys.up,
    down = conf.keys.down,
    left = conf.keys.left,
    right = conf.keys.right,
    primary = conf.keys.primary,
    secondary = conf.keys.secondary
}

local pressed = {}
local held = {}

function input.refresh()
    for action in pairs(keyMap) do
        pressed[action] = false
        held[action] = false
    end
end

function input.keypressed(key)
    for action, keys in pairs(keyMap) do
        for _, k in ipairs(keys) do
            if key == k then
                pressed[action] = true
            end
        end
    end
end

function input.update(dt)
    for action, keys in pairs(keyMap) do
        for _, k in ipairs(keys) do
            if love.keyboard.isDown(k) then
                held[action] = true
                break
            end
        end
    end
end

function input.check(name, type)
    if type == 'held' then return held[name]
    elseif type == 'pressed' then return pressed[name]
    elseif keyMap[type] then
        error('\ninputType is a direction.\nDid you mix the two parameters up?')
    else
        error('\nInvalid inputType: ' .. tostring(type))
    end
end

return input