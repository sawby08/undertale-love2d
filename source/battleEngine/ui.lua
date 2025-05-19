local ui = {}
ui.buttons = {}

function ui.newButton(name, x, y, id, goTo)
    local image = love.graphics.newImage('assets/images/ui/bt/' .. name .. '.png')
    local button = {}
    button.image = image
    button.name = name
    button.quads = {}
    button.quads[1] = love.graphics.newQuad(0, 0, 110, 42, image)
    button.quads[2] = love.graphics.newQuad(110, 0, 110, 42, image)
    button.x = x
    button.y = y
    button.id = id
    button.goTo = goTo or name
    ui.buttons[id] = button
end

-- Load "HP" graphic
local hp = love.graphics.newImage('assets/images/ui/spr_hpname_0.png')

function ui.load()
    -- Set box dimensions
    ui.box = {
        x = 320,
        y = 320,
        width = 570,
        height = 135,
        direction = 0
    }
end

function ui.update(dt)
    -- nothing for now
end

function ui.draw()
    -- Draw buttons
    for _, button in pairs(ui.buttons) do
        love.graphics.draw(
            button.image,
            button.quads[(battle.choice == button.id) and 2 or 1],
            button.x,
            button.y
        )
    end

    -- Draw stats text
    love.graphics.setFont(fonts.mars)
    love.graphics.print(player.stats.name, 30, 400) -- NAME
    love.graphics.print('LV ' .. player.stats.love, 148, 400) -- LV

    -- Draw "HP" symbol
    love.graphics.draw(hp, 240, 400)

    -- Draw HP bar
    love.graphics.setColor(.8, 0, 0)
    love.graphics.rectangle('fill', 275, 400, player.stats.maxHp * 1.25, 21)
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle('fill', 275, 400, player.stats.hp * 1.25, 21)

    -- Draw HP numbers
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fonts.mars)
    love.graphics.print(player.stats.hp .. ' / ' .. player.stats.maxHp, 289 + player.stats.maxHp*1.25, 400)

    -- Draw box
    love.graphics.push("all")

    love.graphics.translate(ui.box.x, ui.box.y)
    love.graphics.rotate(ui.box.direction)

    love.graphics.setColor(0, 0, 0, .50) -- Fill
    love.graphics.rectangle('fill', -ui.box.width/2, -ui.box.height/2, ui.box.width, ui.box.height)
    love.graphics.setColor(1, 1, 1) -- Line
    love.graphics.setLineWidth(5)
    love.graphics.setLineStyle('rough')
    love.graphics.rectangle('line', -ui.box.width/2, -ui.box.height/2, ui.box.width, ui.box.height)

    love.graphics.pop()

    -- Draw text
    if battle.state == 'choose enemy' then
        love.graphics.setFont(fonts.determination)
        for i = 1, 3 do
            love.graphics.print('  * ' .. encounter.enemies[i].name, 52, 242 + (i * 32))
            if i > #encounter.enemies-1 then
                break
            end
        end
    end
end

return ui