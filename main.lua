local currentScene = nil
local scenes = {
    battleEngine = require 'source.battleEngine'
}

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