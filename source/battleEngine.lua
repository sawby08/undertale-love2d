local battleEngine = {}
local ui = require 'source.battleEngine.ui'
local input = require 'source.utils.input'

function battleEngine.load()
    ui.load()
end

function battleEngine.update(dt)
    input.update(dt)

    ui.update(dt)
    
    input.last()
end

function battleEngine.draw()
    ui.draw()
end


return battleEngine