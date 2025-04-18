local input = {}
local pressed = {up, down, left, right, primary, secondary}
local held = {up, down, left, right, primary, secondary}

--[[

to use this properly you have to do an if statement like this:

input.check(INPUT_TYPE, INPUT_NAME)
if input.check('held', 'up') then
    -- do stuff when up is held
end

]]

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
    if key == 'up' then
        pressed.up = true
    end
    if key == 'down' then
        pressed.down = true
    end
    if key == 'left' then
        pressed.left = true
    end
    if key == 'right' then
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
    if love.keyboard.isDown('up') then
        held.up = true
    end
    if love.keyboard.isDown('down') then
        held.down = true
    end
    if love.keyboard.isDown('left') then
        held.left = true
    end
    if love.keyboard.isDown('right') then
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
    else
        error('inputType is not "held" nor "pressed"')
    end
end

function input.last()
    refresh()
end

return input