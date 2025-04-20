local battleEngine = {}

local ui = require 'source.battleEngine.ui'
local input = require 'source.utils.input'
local player = require 'source.battleEngine.player'

function battleEngine.load()
    globals = {
        battleState = 'menu',
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

    input.last()
end

function battleEngine.draw()
    ui.draw()
    player.draw()
end


return battleEngine