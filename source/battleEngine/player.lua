local player = {}

-- Load heart image and position
local heart = {
    image = love.graphics.newImage('assets/images/ut-heart.png'),
    x = nil,
    y = nil
}

-- Load global player stuff
player.stats = {
    love = 1,
    hp = 20,
    maxHp = 20,
    name = 'Player'
}

function player.load()
    heart.x = ui.box.x + ui.box.width / 2 - heart.image:getWidth() / 2
    heart.y = ui.box.y + ui.box.height / 2 - heart.image:getHeight() / 2
end

function player.update(dt)
    -- Menu controls
    if battle.turn == 'player' then
        -- Buttons
        if battle.state == 'buttons' then
            -- Controls
            if input.check('right', 'pressed') then
                battle.choice = (battle.choice + 1) % (#ui.buttons + 1)
                sfx.menumove:play()
            elseif input.check('left', 'pressed') then
                battle.choice = (battle.choice - 1) % (#ui.buttons + 1)
                sfx.menumove:play()
            end

            -- Position
            heart.x = ui.buttons[battle.choice].x + 8
            heart.y = ui.buttons[battle.choice].y + 13
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