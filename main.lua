-- https://tomat.dev/undertale
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

currentScene = scenes.battleEngine
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    currentScene.load('braden')
end

function love.update(dt)
    currentScene.update(dt)
    dtMultiplier = dt * 30
end

function love.draw()
    currentScene.draw()
end