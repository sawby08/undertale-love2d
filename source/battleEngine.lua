local battleEngine = {}

local ui = require 'source.battleEngine.ui'
local input = require 'source.utils.input'
local player = require 'source.battleEngine.player'
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