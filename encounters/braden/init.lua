local encounter = {}
encounter.enemies = {}


function encounter.load()
    encounter.text = "* The room smells of Scratch.       [break]* Please make this quick."
    encounter.bgm = love.audio.newSource('encounters/braden/sound/mus.ogg', 'stream')
    encounter.enemies[1] = {
        name = "Braden",
        description = "BradensMediocreGames himself. [break]* Why him of all people?",

        hp = 100,
        maxHp = 100,
        attack = 5,
        defense = 2,

        image = love.graphics.newImage('encounters/braden/images/spr_braden.png'),
        x = 240,
        y = 42
    }
end

function encounter.update(dt)
    encounter.bgm:play()
    encounter.bgm:setVolume(0.5)
    encounter.bgm:setLooping(true)
end

function encounter.draw()
    love.graphics.draw(encounter.enemies[1].image, encounter.enemies[1].x, encounter.enemies[1].y, 0, 2)
end

function encounter.background()
    
end


return encounter