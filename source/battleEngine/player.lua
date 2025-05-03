local player = {}

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

function player.lockPosition()
    if heart.x < ui.box.x+2 then
        heart.x = ui.box.x+2
    end
    if heart.x > ui.box.x+ui.box.width-heart.image:getWidth()-3 then
        heart.x = ui.box.x+ui.box.width-heart.image:getWidth()-3
    end
    if heart.y < ui.box.y+2 then
        heart.y = ui.box.y+2
    end
    if heart.y > ui.box.y+ui.box.height-heart.image:getHeight()-3 then
        heart.y = ui.box.y+ui.box.height-heart.image:getHeight()-3
    end
end

function player.load()
    heart.x = ui.box.x + ui.box.width / 2 - heart.image:getWidth() / 2
    heart.y = ui.box.y + ui.box.height / 2 - heart.image:getHeight() / 2
end

function player.update(dt)
    -- Menu controls
    if globals.battleState == 'menu' then
        -- Buttons
        if globals.menuState == 'buttons' then
            -- Controls
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
                if globals.choice == 0 or globals.choice == 1 then
                    globals.menuState = 'choose'
                end
            end

            -- Position
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
        -- Choose enemy
        if globals.menuState == 'choose' then
            -- Position
            heart.x, heart.y = 53, 279

            -- Controls
            if input.check('secondary', 'pressed') then
                globals.menuState = 'buttons'

                -- Position the player heart back to the menu. I couldn't find a better way to do this.
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
    elseif globals.battleState == 'enemyTurn' then
        -- Red soul movement
        heart.x = heart.x + ((input.check('right', 'held') and 1 or 0) - (input.check('left', 'held') and 1 or 0)) * 4/(input.check('secondary', 'held') and 2 or 1) * dtMultiplier
        heart.y = heart.y + ((input.check('down', 'held') and 1 or 0) - (input.check('up', 'held') and 1 or 0)) * 4/(input.check('secondary', 'held') and 2 or 1) * dtMultiplier
    end
end

function player.draw()
    love.graphics.push("all")

    love.graphics.setColor(1, 0, 0)
    love.graphics.draw(heart.image, heart.x, heart.y)

    love.graphics.pop()
end

return player