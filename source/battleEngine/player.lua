local player = {}
local battleEngine = require 'source.battleEngineState'
local xOff, yOff = 0, 0
local acts = {}

-- Load heart image and position
player.heart = {
    image = love.graphics.newImage('assets/images/ut-heart.png'),
    x = nil,
    y = nil
}

-- Load global player stuff
player.stats = {}

local function tryMove(newX, newY, requiredActIndex)
    if xOff ~= newX or yOff ~= newY then
        if acts[requiredActIndex] then
            xOff = newX
            yOff = newY
            playSfx("menumove")
        end
    end
end


-- This only exists because I don't know a better way to make the heart not delayed between menu states
function player.updatePosition()
    if battle.state == 'buttons' then
        player.heart.x = ui.buttons[battle.choice].x + 8
        player.heart.y = ui.buttons[battle.choice].y + 13
    elseif battle.state == 'choose enemy' then
        player.heart.x = 55
        player.heart.y = 279 + (battle.subchoice * 32)
    elseif battle.state == 'act' then
        player.heart.x = 55 + (xOff * 272)
        player.heart.y = 279 + (yOff * 32)
    end
end

function player.load()
    player.heart.x = ui.box.x + ui.box.width / 2 - player.heart.image:getWidth() / 2
    player.heart.y = ui.box.y + ui.box.height / 2 - player.heart.image:getHeight() / 2
end

function player.update(dt)
    if battle.turn == 'player' then
        if battle.state == 'act' then
            acts = encounter.enemies[player.chosenEnemy].acts
            if input.check('left', 'pressed') and xOff ~= 0 then
                if yOff == 0 then tryMove(0, yOff, 1)
                elseif yOff == 1 then tryMove(0, yOff, 2)
                elseif yOff == 2 then tryMove(0, yOff, 4)
                end
            end
            if input.check('right', 'pressed') and xOff ~= 1 then
                if yOff == 0 then tryMove(1, yOff, 1)
                elseif yOff == 1 then tryMove(1, yOff, 3)
                elseif yOff == 2 then tryMove(1, yOff, 5)
                end
            end
            if input.check('up', 'pressed') then
                if xOff == 0 and yOff == 1 then tryMove(xOff, 0, 1)
                elseif xOff == 1 and yOff == 1 then tryMove(xOff, 0, 1)
                elseif xOff == 0 and yOff == 2 then tryMove(xOff, 1, 4)
                elseif xOff == 1 and yOff == 2 then tryMove(xOff, 1, 3)
                end
            end
            if input.check('down', 'pressed') then
                if xOff == 0 and yOff == 1 then tryMove(xOff, 2, 4)
                elseif xOff == 1 and yOff == 1 then tryMove(xOff, 2, 5)
                elseif xOff == 0 and yOff == 0 then tryMove(xOff, 1, 2)
                elseif xOff == 1 and yOff == 0 then tryMove(xOff, 1, 3)
                end
            end
            if input.check('secondary', 'pressed') then
                input.refresh()
                battleEngine.changeState('choose enemy')
                battle.subchoice = player.chosenEnemy - 1
            end
        elseif battle.state == 'choose enemy' then
            if input.check('primary', 'pressed') then
                if battle.choice == 1 then
                    player.chosenEnemy = battle.subchoice + 1
                    battleEngine.changeState('act')
                    xOff, yOff = 0, 0
                end
                playSfx("menuselect")
            end
            if input.check('secondary', 'pressed') then
                input.refresh()
                battleEngine.changeState('buttons')
            end
            if input.check('up', 'pressed') then
                local last = battle.subchoice
                battle.subchoice = (battle.subchoice - 1) % (#encounter.enemies)
                if last ~= battle.subchoice then
                    playSfx("menumove")
                end
            end
            if input.check('down', 'pressed') then
                local last = battle.subchoice
                battle.subchoice = (battle.subchoice + 1) % (#encounter.enemies)
                if last ~= battle.subchoice then
                    playSfx("menumove")
                end
            end
        elseif battle.state == 'buttons' then
            if input.check('right', 'pressed') then
                battle.choice = (battle.choice + 1) % (#ui.buttons + 1)
                playSfx("menumove")
                player.updatePosition()
            elseif input.check('left', 'pressed') then
                battle.choice = (battle.choice - 1) % (#ui.buttons + 1)
                playSfx("menumove")
                player.updatePosition()
            elseif input.check('primary', 'pressed') then
                writer.stop()
                battleEngine.changeState(ui.buttons[battle.choice].goTo)
                playSfx("menuselect")
            end
        end
        player.updatePosition()
    end
end


function player.draw()
    love.graphics.push("all")

    love.graphics.setColor(1, 0, 0)
    love.graphics.draw(player.heart.image, player.heart.x, player.heart.y)

    love.graphics.pop()
end

return player