local player = {}
local battleEngine = require 'source.battleEngineState'
local xvel, yvel = 0, 0
local blueGrav = 0
local jumpstage = 0
local jumptimer = 0

-- Load heart image and position
player.heart = {
    image = love.graphics.newImage('assets/images/ut-heart.png'),
    x = 0,
    y = 0
}

-- Load global player stuff
player.stats = {}

-- This only exists because I don't know a better way to make the heart not delayed between menu states
function player.updatePosition()
    if battle.turn == 'player' then
        if battle.state == 'fight' then
            player.heart.x = -16
            player.heart.y = -16
        elseif battle.state == 'buttons' then
            player.heart.x = ui.buttons[battle.choice].x + 8
            player.heart.y = ui.buttons[battle.choice].y + 13
        elseif battle.state == 'choose enemy' or battle.state == 'mercy' then
            player.heart.x = 55
            player.heart.y = 279 + (battle.subchoice * 32)
        elseif battle.state == 'act' then
            if battle.subchoice == 0 then
                player.heart.x = 55
                player.heart.y = 279
            elseif battle.subchoice == 1 then
                player.heart.x = 327
                player.heart.y = 279
            elseif battle.subchoice == 2 then
                player.heart.x = 55
                player.heart.y = 311
            elseif battle.subchoice == 3 then
                player.heart.x = 327
                player.heart.y = 311
            elseif battle.subchoice == 4 then
                player.heart.x = 55
                player.heart.y = 343
            elseif battle.subchoice == 5 then
                player.heart.x = 327
                player.heart.y = 343
            end
        elseif battle.state == 'item' then
            player.heart.x = 64
            player.heart.y = 278
        end
    end
    if battle.turn == 'enemies' then
        if battle.state == 'attack' then
            player.heart.x = player.heart.x + xvel
            player.heart.y = player.heart.y + yvel
        end
        if player.heart.x < ui.box.x + 2 then
            player.heart.x = ui.box.x + 2
        end
        if player.heart.x > ui.box.x + ui.box.width - 19 then
            player.heart.x = ui.box.x + ui.box.width - 19
        end
        if player.heart.y < ui.box.y + 2 then
            player.heart.y = ui.box.y + 2
        end
        if player.heart.y > ui.box.y + ui.box.height - 19 then
            player.heart.y = ui.box.y + ui.box.height - 19
        end
    end
end

function player.load()
    player.mode = 1
end

function player.update(dt)
    if battle.turn == 'player' then
        if battle.state == 'mercy' then
            if input.check('secondary', 'pressed') then
                input.refresh()
                changeBattleState('buttons')
            end
            if input.check('down', 'pressed') and encounter.canFlee then
                if encounter.canFlee and battle.subchoice == 0 then
                    sfx.menumove:stop()
                    sfx.menumove:play()
                end
                battle.subchoice = 1
                player.updatePosition()
            end
            if input.check('up', 'pressed') then
                if battle.subchoice == 1 then
                    sfx.menumove:stop()
                    sfx.menumove:play()
                end
                battle.subchoice = 0
                player.updatePosition()
            end
        elseif battle.state == 'item' then
            if input.check('secondary', 'pressed') then
                input.refresh()
                changeBattleState('buttons')
            end
        elseif battle.state == 'act' then
            if input.check('up', 'pressed') then
                local last = battle.subchoice
                battle.subchoice = (battle.subchoice - 2)
                if battle.subchoice < 0 then
                    battle.subchoice = 0
                end
                if battle.subchoice > #encounter.enemies[player.chosenEnemy].acts then
                    battle.subchoice = #encounter.enemies[player.chosenEnemy].acts
                end
                if last ~= battle.subchoice then
                    sfx.menumove:stop()
                    sfx.menumove:play()
                end
            end
            if input.check('down', 'pressed') then
                local last = battle.subchoice
                battle.subchoice = (battle.subchoice + 2)
                if battle.subchoice < 0 then
                    battle.subchoice = 0
                end
                if battle.subchoice > #encounter.enemies[player.chosenEnemy].acts then
                    battle.subchoice = #encounter.enemies[player.chosenEnemy].acts
                end
                if last ~= battle.subchoice then
                    sfx.menumove:stop()
                    sfx.menumove:play()
                end
            end
            if input.check('left', 'pressed') then
                local last = battle.subchoice
                battle.subchoice = (battle.subchoice - 1)
                if battle.subchoice < 0 then
                    battle.subchoice = 0
                end
                if battle.subchoice > #encounter.enemies[player.chosenEnemy].acts then
                    battle.subchoice = #encounter.enemies[player.chosenEnemy].acts
                end
                if last ~= battle.subchoice then
                    sfx.menumove:stop()
                    sfx.menumove:play()
                end
            end
            if input.check('right', 'pressed') then
                local last = battle.subchoice
                battle.subchoice = (battle.subchoice + 1)
                if battle.subchoice < 0 then
                    battle.subchoice = 0
                end
                if battle.subchoice > #encounter.enemies[player.chosenEnemy].acts then
                    battle.subchoice = #encounter.enemies[player.chosenEnemy].acts
                end
                if last ~= battle.subchoice then
                    sfx.menumove:stop()
                    sfx.menumove:play()
                end
            end
            if input.check('secondary', 'pressed') then
                input.refresh()
                battle.subchoice = player.chosenEnemy - 1
                changeBattleState('choose enemy')
            end
        elseif battle.state == 'choose enemy' then
            if input.check('primary', 'pressed') then
                if battle.choice == 0 then
                    -- Debug stuff so I know the player can go back to the menu after an attack
                    player.lastButton = battle.choice
                    battle.choice = -1
                    changeBattleState('attack')
                elseif battle.choice == 1 then
                    player.chosenEnemy = battle.subchoice + 1
                    changeBattleState('act')
                    battle.subchoice = 0
                end
                sfx.menuselect:stop()
                sfx.menuselect:play()
            end
            if input.check('secondary', 'pressed') then
                input.refresh()
                changeBattleState('buttons')
            end
            if input.check('up', 'pressed') then
                local last = battle.subchoice
                battle.subchoice = (battle.subchoice - 1)
                if battle.subchoice < 0 then
                    battle.subchoice = 0
                end
                if battle.subchoice > #encounter.enemies-1 then
                    battle.subchoice = #encounter.enemies-1
                end
                if last ~= battle.subchoice then
                    sfx.menumove:stop()
                    sfx.menumove:play()
                end
            end
            if input.check('down', 'pressed') then
                local last = battle.subchoice
                battle.subchoice = (battle.subchoice + 1)
                if battle.subchoice < 0 then
                    battle.subchoice = 0
                end
                if battle.subchoice > #encounter.enemies-1 then
                    battle.subchoice = #encounter.enemies-1
                end
                if last ~= battle.subchoice then
                    sfx.menumove:stop()
                    sfx.menumove:play()
                end
            end
        elseif battle.state == 'buttons' then
            if input.check('right', 'pressed') then
                battle.choice = (battle.choice + 1) % (#ui.buttons + 1)
                sfx.menumove:stop()
                sfx.menumove:play()
                player.updatePosition()
            elseif input.check('left', 'pressed') then
                battle.choice = (battle.choice - 1) % (#ui.buttons + 1)
                sfx.menumove:stop()
                sfx.menumove:play()
                player.updatePosition()
            elseif input.check('primary', 'pressed') then
                writer.stop()
                battle.subchoice = 0
                changeBattleState(ui.buttons[battle.choice].goTo)
                sfx.menuselect:stop()
                sfx.menuselect:play()
            end
        end
    elseif battle.turn == 'enemies' then
        if battle.state == 'attack' then
            xvel, yvel = 0, 0
            local speed = 4
            if input.check('secondary', 'held') then
                speed = 2 * dtMultiplier
            else
                speed = 4 * dtMultiplier
            end
            if player.mode == 1 then
                if input.check('up', 'held') then
                    yvel = yvel - speed
                end
                if input.check('down', 'held') then
                    yvel = yvel + speed
                end
                if input.check('left', 'held') then
                    xvel = xvel - speed
                end
                if input.check('right', 'held') then
                    xvel = xvel + speed
                end
            elseif player.mode == 2 then
                -- Left and right movement and gravitational pull
                blueGrav = blueGrav + (0.75 * dtMultiplier)
                yvel = yvel + blueGrav
                if input.check('left', 'held') then
                    xvel = xvel - speed
                end
                if input.check('right', 'held') then
                    xvel = xvel + speed
                end

                -- Check if player is on the bottom of the box so they can jump, resets the timer and jumpstage
                if player.heart.y >= ui.box.y + ui.box.height - 19 then
                    jumpstage = 0
                    jumptimer = 0
                    if input.check('up', 'held') then
                        -- Change jumpstage so the player stays jumping
                        jumpstage = 1
                    end
                end
                if jumpstage == 1 and input.check('up', 'held') and player.heart.y <= ui.box.y + ui.box.height - 19 then
                    -- Make the player jump by 6 pixels and increase jumptimer to prevent the player from jumping too high
                    blueGrav = -6 * dtMultiplier
                    jumptimer = jumptimer + love.timer.getDelta()
                end
                if player.heart.y <= ui.box.y + ui.box.height - 19 and jumpstage == 1 and not input.check('up', 'held') then
                    -- Change gravity so movement is tighter
                    blueGrav = -1.5
                    jumpstage = 2
                end
                if jumptimer > 0.4 then
                    -- Don't change gravity so the full motion is fluid
                    jumptimer = 0
                    jumpstage = 2
                end
            end
        end
    end
    player.updatePosition()
end


function player.draw()
    love.graphics.push("all")

    if player.mode == 1 then
        love.graphics.setColor(1, 0, 0)
    elseif player.mode == 2 then
        love.graphics.setColor(0, 0, 1)
    end
    love.graphics.draw(player.heart.image, player.heart.x, player.heart.y)

    love.graphics.pop()
end

return player