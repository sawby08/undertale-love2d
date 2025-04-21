local player = {}

-- Load libraries
local input = require 'source.utils.input'
local ui = require 'source.battleEngine.ui'

-- Load sound effects
local sfx = {
    menumove = love.audio.newSource('assets/sound/menuMove.ogg', 'static'),
    menuselect = love.audio.newSource('assets/sound/menuSelect.ogg', 'static')
}
-- Load heart image and position
local heart = {
    image = love.graphics.newImage('assets/images/ut-heart.png'),
    x = nil,
    y = nil
}

-- Load global player stuff
playerStats = {
    love = 1,
    hp = 20,
    maxHp = 20,
    name = 'Player'
}


function player.load()
    
end

function player.update(dt)
    -- Menu controls
    if globals.battleState == 'menu' then
        if input.check('right', 'pressed') then
            globals.choice = (globals.choice + 1) % 4
            sfx.menumove:play()
        elseif input.check('left', 'pressed') then
            globals.choice = (globals.choice - 1) % 4
            sfx.menumove:play()
        end
        if input.check('primary', 'pressed') then
            sfx.menuselect:stop()
            sfx.menuselect:play()
        end

        heart.y = 445
        if globals.choice == 0 then
            heart.x = 35
        elseif globals.choice == 1 then
            heart.x = 194
        elseif globals.choice == 2 then
            heart.x = 351
        elseif globals.choice == 3 then
            heart.x = 508
        end
    end
end

function player.draw()
    love.graphics.push("all")

    love.graphics.setColor(1, 0, 0)
    love.graphics.draw(heart.image, heart.x, heart.y)

    love.graphics.pop()
end

return player