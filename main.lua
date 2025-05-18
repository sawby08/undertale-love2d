local currentScene = nil
local scenes = {
    battleEngine = require 'source.battleEngineState'
}

fps = require 'source.utils.fps'
input = require 'source.utils.input'
dtMultiplier = 0

function love.keypressed(key)
    input.keypressed(key)
end

local currentScene = scenes.battleEngine
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    currentScene.load('braden')
end

function love.update(dt)
    currentScene.update(dt)
end

function love.draw()
    currentScene.draw()

    love.graphics.setFont(fonts.default)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('FPS: ' .. love.timer.getFPS())
end