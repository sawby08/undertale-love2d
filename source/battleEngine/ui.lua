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

local choice = 0

function Ui.load()
    fight[1] = love.graphics.newQuad(0, 0, 110, 42, fightImage)
    fight[2] = love.graphics.newQuad(110, 0, 110, 42, fightImage)
    act[1] = love.graphics.newQuad(0, 0, 110, 42, actImage)
    act[2] = love.graphics.newQuad(110, 0, 110, 42, actImage)
    item[1] = love.graphics.newQuad(0, 0, 110, 42, itemImage)
    item[2] = love.graphics.newQuad(110, 0, 110, 42, itemImage)
    mercy[1] = love.graphics.newQuad(0, 0, 110, 42, mercyImage)
    mercy[2] = love.graphics.newQuad(110, 0, 110, 42, mercyImage)
end

function Ui.update(dt)
    if input.check('left', 'pressed') then
        choice = choice - 1
    end
    if input.check('right', 'pressed') then
        choice = choice + 1
    end
    choice = choice % 4
end

function Ui.draw()
    love.graphics.draw(fightImage, fight[(choice == 0 and 1 or 0) + 1], 27, 432)
    love.graphics.draw(actImage, act[(choice == 1 and 1 or 0) + 1], 185, 432)
    love.graphics.draw(itemImage, item[(choice == 2 and 1 or 0) + 1], 343, 432)
    love.graphics.draw(mercyImage, mercy[(choice == 3 and 1 or 0) + 1], 501, 432)
end

return Ui