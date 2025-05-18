local encounter = {}
encounter.enemies = {}

function encounter.load()
    encounter.text = "* i don't feel like an encounter[break]  message sorry"
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
        y = 42,

        xOffset = 0,
        yOffset = 0,

        head = {
            image = love.graphics.newImage('encounters/braden/images/spr_braden_head.png'),
            x = 0,
            y = 0
        },
        body = {
            image = love.graphics.newImage('encounters/braden/images/spr_braden_body.png'),
            x = 0,
            y = 0
        },
        legs = {
            image = love.graphics.newImage('encounters/braden/images/spr_braden_legs.png'),
            x = 0,
            y = 0
        }
    }
end

function encounter.update(dt)
    encounter.enemies[1].head.x = math.sin(love.timer.getTime() * 5) * 1.5
    encounter.enemies[1].head.y = math.sin(love.timer.getTime() * 10) * 1.5
    encounter.enemies[1].body.x = math.sin(love.timer.getTime() * 5) * 1.5
    encounter.enemies[1].body.y = math.sin(love.timer.getTime() * 10) * 1
end

function encounter.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(encounter.enemies[1].legs.image, encounter.enemies[1].x + encounter.enemies[1].legs.x, encounter.enemies[1].y + encounter.enemies[1].legs.y, 0, 2)
    love.graphics.draw(encounter.enemies[1].body.image, encounter.enemies[1].x + encounter.enemies[1].body.x, encounter.enemies[1].y + encounter.enemies[1].body.y, 0, 2)
    love.graphics.draw(encounter.enemies[1].head.image, encounter.enemies[1].x + encounter.enemies[1].head.x, encounter.enemies[1].y + encounter.enemies[1].head.y, 0, 2)
end

function encounter.background()
    
end


return encounter