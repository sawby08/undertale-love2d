local currentScene = nil
local scenes = {
    battleEngine = require 'source.battleEngineState'
}
local defaultFont = love.graphics.newFont(14)

fps = require 'source.utils.fps'
input = require 'source.utils.input'
dtMultiplier = 0

function love.keypressed(key)
    input.keypressed(key)
end

local currentScene = scenes.battleEngine
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    currentScene.load()
end

function love.update(dt)
    currentScene.update(dt)
    dtMultiplier = dt * 30
end

function love.draw()
    currentScene.draw()

    love.graphics.setFont(defaultFont)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print('FPS: ' .. love.timer.getFPS())
end