local Ui = {}

local input = require 'source.utils.input'
local fightImage = love.graphics.newImage('images/ui/bt/fight.png')
local actImage = love.graphics.newImage('images/ui/bt/act.png')
local itemImage = love.graphics.newImage('images/ui/bt/item.png')
local mercyImage = love.graphics.newImage('images/ui/bt/mercy.png')

local fight = {}
local act = {}
local item = {}
local mercy = {}

fight[1] = love.graphics.newQuad(0, 0, 110, 42, fightImage)
fight[2] = love.graphics.newQuad(110, 0, 110, 42, fightImage)
act[1] = love.graphics.newQuad(0, 0, 110, 42, actImage)
act[2] = love.graphics.newQuad(110, 0, 110, 42, actImage)
item[1] = love.graphics.newQuad(0, 0, 110, 42, itemImage)
item[2] = love.graphics.newQuad(110, 0, 110, 42, itemImage)
mercy[1] = love.graphics.newQuad(0, 0, 110, 42, mercyImage)
mercy[2] = love.graphics.newQuad(110, 0, 110, 42, mercyImage)

function Ui.load()

end

function Ui.update(dt)
    
end

function Ui.draw()
    -- Draw buttons
    love.graphics.draw(fightImage, fight[(globals.choice == 0 and 1 or 0) + 1], 27, 432)
    love.graphics.draw(actImage, act[(globals.choice == 1 and 1 or 0) + 1], 185, 432)
    love.graphics.draw(itemImage, item[(globals.choice == 2 and 1 or 0) + 1], 343, 432)
    love.graphics.draw(mercyImage, mercy[(globals.choice == 3 and 1 or 0) + 1], 501, 432)
end

return Ui