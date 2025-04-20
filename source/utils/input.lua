local input = {}
local pressed = {up, down, left, right, primary, secondary}
local held = {up, down, left, right, primary, secondary}
-- input.check(inputName, inputType)

local function refresh()
    pressed.up = false
    pressed.down = false
    pressed.left = false
    pressed.right = false
    
    pressed.primary = false
    pressed.secondary = false


    held.up = false
    held.down = false
    held.left = false
    held.right = false

    held.primary = false
    held.secondary = false
end

function input.keypressed(key)
    if key == 'up' or key == 'w' then
        pressed.up = true
    end
    if key == 'down' or key == 's' then
        pressed.down = true
    end
    if key == 'left' or key == 'a' then
        pressed.left = true
    end
    if key == 'right' or key == 'd' then
        pressed.right = true
    end
    if key == 'z' or key == 'return' then
        pressed.primary = true
    end
    if key == 'x' or key == 'lshift' or key == 'rshift' then
        pressed.secondary = true
    end
end

function input.update(dt)
    if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
        held.up = true
    end
    if love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        held.down = true
    end
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        held.left = true
    end
    if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        held.right = true
    end
    if love.keyboard.isDown('z') or love.keyboard.isDown('return') then
        held.primary = true
    end
    if love.keyboard.isDown('x') or love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift') then
        held.secondary = true
    end
end

function input.check(inputName, inputType)
    if inputType == 'held' then
        if inputName == 'up' then
            return held.up
        end
        if inputName == 'down' then
            return held.down
        end
        if inputName == 'left' then
            return held.left
        end
        if inputName == 'right' then
            return held.right
        end
        if inputName == 'primary' then
            return held.primary
        end
        if inputName == 'secondary' then
            return held.secondary
        end
    end
    if inputType == 'pressed' then
        if inputName == 'up' then
            return pressed.up
        end
        if inputName == 'down' then
            return pressed.down
        end
        if inputName == 'left' then
            return pressed.left
        end
        if inputName == 'right' then
            return pressed.right
        end
        if inputName == 'primary' then
            return pressed.primary
        end
        if inputName == 'secondary' then
            return pressed.secondary
        end
    elseif inputType == 'up' or inputType == 'down' or inputType == 'left' or inputType == 'right' then
        error('\ninputType is a direction.\nDid you mix the two parameters up?')
    else
        error('\ninputType is not "held" nor "pressed"\ninputType: ' .. inputType or 'nil')
    end
end

function input.last()
    refresh()
end

return input