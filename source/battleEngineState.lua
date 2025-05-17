local battleEngine = {}

local refs = {
    main = love.graphics.newImage("refs/main.png")
}

function battleEngine.load()
    battle = {
        turn = 'player',
        state = 'buttons',
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
    ui.newButton('fight', 27, 432, 0)
    ui.newButton('act', 185, 432, 1)
    ui.newButton('item', 343, 432, 2)
    ui.newButton('mercy', 501, 432, 3)
    
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

    love.graphics.setColor(.25, .25, .25)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(1, 1, 1, .5)
    -- love.graphics.draw(refs.main)

    love.graphics.pop()

    ui.draw()
    player.draw()
end


return battleEngine