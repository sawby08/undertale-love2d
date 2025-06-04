-- https://tomat.dev/undertale
local currentScene = nil
local scenes = {
    battleEngine = require 'source.battleEngineState'
}
conf = {
    keys = {
        up = {'up', 'w'},
        down = {'down', 's'},
        left = {'left', 'a'},
        right = {'right', 'd'},
        primary = {'z', 'return'},
        secondary = {'x', 'lshift', 'rshift'}
    },
    fps = 30
}

fps = require 'source.utils.fps'
input = require 'source.utils.input'

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
end

function love.draw()
    currentScene.draw()
end