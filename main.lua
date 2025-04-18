local currentScene = nil
local scenes = {
    battleEngine = require 'source.battleEngine'
}
local input = require 'source.utils.input'
local fps = require 'source.utils.fps'

function love.keypressed(key)
    input.keypressed(key)
end

currentScene = scenes.battleEngine
function love.load()
    currentScene.load()
end

function love.update(dt)
    currentScene.update(dt)
end

function love.draw()
    currentScene.draw()
end