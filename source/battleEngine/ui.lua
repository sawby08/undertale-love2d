local Ui = {}

local fight = {}
local fightImage = love.graphics.newImage('images/ui/bt/fight.png')
fight[1] = love.graphics.newQuad(0, 0, 110, 42, fightImage)
fight[2] = love.graphics.newQuad(110, 0, 110, 42, fightImage)

local act = {}
local actImage = love.graphics.newImage('images/ui/bt/act.png')
act[1] = love.graphics.newQuad(0, 0, 110, 42, actImage)
act[2] = love.graphics.newQuad(110, 0, 110, 42, actImage)

local item = {}
local itemImage = love.graphics.newImage('images/ui/bt/item.png')
item[1] = love.graphics.newQuad(0, 0, 110, 42, itemImage)
item[2] = love.graphics.newQuad(110, 0, 110, 42, itemImage)

local mercy = {}
local mercyImage = love.graphics.newImage('images/ui/bt/mercy.png')
mercy[1] = love.graphics.newQuad(0, 0, 110, 42, mercyImage)
mercy[2] = love.graphics.newQuad(110, 0, 110, 42, mercyImage)



function Ui.load()
    
end

function Ui.update(dt)

end

function Ui.draw()
    love.graphics.draw(fightImage, fight[1], 27, 432)
    love.graphics.draw(actImage, act[1], 185, 432)
    love.graphics.draw(itemImage, item[1], 343, 432)
    love.graphics.draw(mercyImage, item[1], 501, 432)
end


return Ui