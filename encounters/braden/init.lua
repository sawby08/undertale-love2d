local encounter = {}
encounter.enemies = {}


function encounter.load()
    -- Load encounter stuff
    encounter.text = "[clear][rainbow]* undertale rainbow tale of[break]  amazingness"
    -- "[clear]* You feel like you're going to[break]  have a [wave][grey]mediocre [clear]time"
    encounter.bgm = love.audio.newSource('encounters/braden/sound/mus.ogg', 'stream')
    encounter.bgm:setVolume(0.5)
    encounter.bgm:setLooping(true)
    encounter.startFirst = true
    encounter.canFlee = true

    encounter.backgroundImage = nil

    -- Load enemies
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

    -- Load player stats
    player.stats.love = 8
    player.stats.maxHp = 16 + (player.stats.love * 4)
    player.stats.hp = player.stats.maxHp
    player.stats.name = 'Chara'

    -- Report error if too many enemies because i'm too lazy to make it support more than 3
    if #encounter.enemies > 3 then
        error('Too many enemies in encounter. Max is 3, current is ' .. #encounter.enemies)
    end
end

function encounter.update(dt)

end

function encounter.draw()
    -- draw the enemies
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(
        encounter.enemies[1].image,
        encounter.enemies[1].x + encounter.enemies[1].xOffset,
        encounter.enemies[1].y + encounter.enemies[1].yOffset,
        0, 2)
end

function encounter.background()
    if encounter.backgroundImage then love.graphics.draw(encounter.backgroundImage) end
end


return encounter