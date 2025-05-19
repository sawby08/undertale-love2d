local encounter = {}
encounter.enemies = {}

function encounter.load()
    encounter.text = "[clear][rainbow]* i really like how this looks"
    encounter.bgm = love.audio.newSource('encounters/braden/sound/mus.ogg', 'stream')
    encounter.enemies[1] = {
        name = "Braden",
        description = "* A guy out there in the world.",
        acts = {'Talk', 'Crash'},

        hp = 100,
        maxHp = 100,
        attack = 5,
        defense = 2,

        image = love.graphics.newImage('encounters/braden/images/spr_braden.png'),
        x = 240,
        y = 42,

        xOffset = 0,
        yOffset = 0
    }

    if #encounter.enemies > 3 then
        error('Too many enemies in encounter. Max is 3, current is ' .. #encounter.enemies)
    end
end

function encounter.update(dt)

end

function encounter.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(
        encounter.enemies[1].image,
        encounter.enemies[1].x + encounter.enemies[1].xOffset,
        encounter.enemies[1].y + encounter.enemies[1].yOffset,
        0, 2)
end

function encounter.background()
    
end


return encounter