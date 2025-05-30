local battleEngine = {}

local refs = {
    main = love.graphics.newImage("refs/main.png"),
    acts = love.graphics.newImage("refs/acts.png"),
    items = love.graphics.newImage("refs/items.png"),
}

function battleEngine.changeState(state)
    battle.state = state

    if state == 'buttons' then
        writer:setParams(encounter.text, 52, 274, fonts.determination, 0.02 * (FPS/30), sfx.text.uifont)
    elseif state == 'attack' then
       --  ui.box.width = 135
        player.heart.x = ui.box.x + ui.box.width / 2 - 8
        player.heart.y = ui.box.y + ui.box.height / 2 - 8
        ui.box.x = 252
        ui.box.width = 135
    elseif state == 'fight' then
        battle.choice = -1
    end

    player.updatePosition()
end

function battleEngine.load(encounterName)
    -- Set up basic battle variables
    battle = {
        turn = 'player',
        state = 'buttons',
        choice = 0,
        subchoice = 0
    }

    -- Import assets
    sfx = {
        menumove = love.audio.newSource('assets/sound/menuMove.ogg', 'static'),
        menuselect = love.audio.newSource('assets/sound/menuSelect.ogg', 'static'),

        text = {
            uifont = love.audio.newSource('assets/sound/voice/uifont.wav', 'static'),
            sans = love.audio.newSource('assets/sound/voice/v_sans.wav', 'static')
        }
    }
    fonts = {
        mars = love.graphics.newFont('assets/fonts/Mars_Needs_Cunnilingus.ttf', 23),
        determination = love.graphics.newFont('assets/fonts/determination-mono.ttf', 32),
        default = love.graphics.newFont(14)
    }

    -- Import objects
    player = require 'source.battleEngine.player'
    ui = require 'source.battleEngine.ui'
    writer = require 'source.utils.writer'
    encounter = require('encounters/' .. encounterName)
    itemManager = require 'source.utils.itemManager'

    -- Load objects
    encounter.load()

    ui.load()
    ui.newButton('fight', 27, 432, 0, 'choose enemy') -- make buttons
    ui.newButton('act', 185, 432, 1, 'choose enemy')
    ui.newButton('item', 343, 432, 2)
    ui.newButton('mercy', 501, 432, 3)
    
    player.load()

    -- Go to menu or enemy turn
    if encounter.startFirst then
        battle.turn = 'enemies'
        battleEngine.changeState('attack')
        battle.choice = -1
    else
        battle.turn = 'player'
        battleEngine.changeState('buttons')
        battle.choice = 0
    end
end

function battleEngine.update(dt)
    input.update(dt)

    encounter.update(dt)
    encounter.bgm:play()

    ui.update(dt)
    player.update()
    writer:update(dt)

    input.refresh()
end

function battleEngine.draw()
    -- Saves the graphics state so drawing the ref and black base doesn't mess up the other stuff
    love.graphics.push("all")

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(1, 1, 1, .5)
    -- love.graphics.draw(refs.main, 0, 0, 0)

    love.graphics.pop()

    encounter.background()

    ui.draw()
    writer:draw()

    encounter.draw() -- basically draws the enemies and the background
    player.draw()
end

return battleEngine