local Ui = {}

-- Load libraries
local input = require 'source.utils.input'

-- Load button images & set up quads
local fightImage = love.graphics.newImage('assets/images/ui/bt/fight.png')
local actImage = love.graphics.newImage('assets/images/ui/bt/act.png')
local itemImage = love.graphics.newImage('assets/images/ui/bt/item.png')
local mercyImage = love.graphics.newImage('assets/images/ui/bt/mercy.png')
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

-- Load fonts
local fonts = {
    mars = love.graphics.newFont('assets/fonts/Mars_Needs_Cunnilingus.ttf', 23),
    determination = love.graphics.newFont('assets/fonts/determination-mono.ttf', 32)
}

function Ui.load()
    -- Set box dimensions
    boxDimensions = {
        x = 35,
        y = 252,
        width = 570,
        height = 135,
    }
end

function Ui.update(dt)
    
end

function Ui.draw()
    -- Draw buttons
    love.graphics.draw(fightImage, fight[(globals.choice == 0 and 1 or 0) + 1], 27, 432)
    love.graphics.draw(actImage, act[(globals.choice == 1 and 1 or 0) + 1], 185, 432)
    love.graphics.draw(itemImage, item[(globals.choice == 2 and 1 or 0) + 1], 343, 432)
    love.graphics.draw(mercyImage, mercy[(globals.choice == 3 and 1 or 0) + 1], 501, 432)

    -- Draw stats text
    love.graphics.setFont(fonts.mars)
    love.graphics.print(playerStats.name, 30, 400) -- NAME
    love.graphics.print('LV ' .. playerStats.love, 148, 400) -- LV

    -- Draw box
    love.graphics.push("all")

    love.graphics.setColor(0, 0, 0, .5) -- Fill
    love.graphics.rectangle('fill', boxDimensions.x, boxDimensions.y, boxDimensions.width, boxDimensions.height)
    love.graphics.setColor(1, 1, 1) -- Line
    love.graphics.setLineWidth(5)
    love.graphics.setLineStyle('rough')
    love.graphics.rectangle('line', boxDimensions.x, boxDimensions.y, boxDimensions.width, boxDimensions.height)

    love.graphics.pop()

    -- Draw menu text (PLACEHOLDER)
    if globals.menuState == 'buttons' then
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(fonts.determination)
        love.graphics.print('* You encountered the Dummy.', 52, 275)
    end
end

return Ui