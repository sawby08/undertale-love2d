local currentScene = nil
local scenes = {
    battleEngine = require 'source.battleEngine'
}
local input = require 'source.utils.input'
local fps = require 'source.utils.fps'

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
end

function love.draw()
    currentScene.draw()
end