local battleEngine = {}
local ui = require 'source.battleEngine.ui'


function battleEngine.load()
    ui.load()
end

function battleEngine.update(dt)
    ui.update(dt)
end

function battleEngine.draw()
    ui.draw()
end


return battleEngine