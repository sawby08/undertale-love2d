local player = {}
local battleEngine = require 'source.battleEngineState'

-- Load heart image and position
player.heart = {
    image = love.graphics.newImage('assets/images/ut-heart.png'),
    x = nil,
    y = nil
}

-- Load global player stuff
player.stats = {
    love = 1,
    hp = 20,
    maxHp = 20,
    name = 'Chara'
}

function player.updatePosition()
    if battle.state == 'buttons' then
        player.heart.x = ui.buttons[battle.choice].x + 8
        player.heart.y = ui.buttons[battle.choice].y + 13
    elseif battle.state == 'choose enemy' then
        player.heart.x = 55
        player.heart.y = 279 + (battle.subchoice * 32)
    end
end


function player.load()
    player.heart.x = ui.box.x + ui.box.width / 2 - player.heart.image:getWidth() / 2
    player.heart.y = ui.box.y + ui.box.height / 2 - player.heart.image:getHeight() / 2
end

function player.update(dt)
    if battle.turn == 'player' then
        if battle.state == 'choose enemy' then
            if input.check('secondary', 'pressed') then
                battleEngine.changeState('buttons')
            end
            if input.check('up', 'pressed') then
                local last = battle.subchoice
                battle.subchoice = (battle.subchoice - 1) % (#encounter.enemies)
                if last ~= battle.subchoice then
                    sfx.menumove:stop()
                    sfx.menumove:play()
                end
            end
            if input.check('down', 'pressed') then
                local last = battle.subchoice
                battle.subchoice = (battle.subchoice + 1) % (#encounter.enemies)
                if last ~= battle.subchoice then
                    sfx.menumove:stop()
                    sfx.menumove:play()
                end
            end
        player.updatePosition()

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
                battleEngine.changeState(ui.buttons[battle.choice].goTo)
                sfx.menuselect:stop()
                sfx.menuselect:play()
            end
        end
    end
end


function player.draw()
    love.graphics.push("all")

    love.graphics.setColor(1, 0, 0)
    love.graphics.draw(player.heart.image, player.heart.x, player.heart.y)

    love.graphics.pop()
end

return player
