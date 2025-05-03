local battleEngine = {}

local refs = {
    main = love.graphics.newImage("refs/main.png")
}

function battleEngine.load()
    globals = {
        battleState = 'menu',
        menuState = 'buttons',
        choice = 0,
        subchoice = 0
    }
    sfx = {
        menumove = love.audio.newSource('assets/sound/menuMove.ogg', 'static'),
        menuselect = love.audio.newSource('assets/sound/menuSelect.ogg', 'static')
    }
    fonts = {
        mars = love.graphics.newFont('assets/fonts/Mars_Needs_Cunnilingus.ttf', 23),
        determination = love.graphics.newFont('assets/fonts/determination-mono.ttf', 32)
    }

    player = require 'source.battleEngine.player'
    ui = require 'source.battleEngine.ui'

    ui.load()
    player.load()
end

function battleEngine.update(dt)
    input.update(dt)

    ui.update(dt)
    player.update()

    input.refresh()
end

function battleEngine.draw()
    love.graphics.push("all")

    love.graphics.setColor(1, 1, 1, .5)
    -- love.graphics.draw(refs.main)

    love.graphics.pop()

    ui.draw()
    player.draw()
end


return battleEngine