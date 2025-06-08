local battleEngine = {}

local refs = {
    main = love.graphics.newImage("refs/main.png"),
    acts = love.graphics.newImage("refs/acts.png"),
    items = love.graphics.newImage("refs/items.png"),
}

function battleEngine.changeBattleState(state, turn)
    if state == 'buttons' and turn == 'player' then
        if battle.state == 'attack' and battle.turn == 'enemies' then
            battle.choice = player.lastButton
            battle.subchoice = 0
        end
        local encounterText
        if type(encounter.text) == 'string' then
            encounterText = encounter.text
        else
            encounterText = encounter.text[love.math.random(1, #encounter.text)]
        end
        writer:setParams(encounterText, 52, 274, fonts.determination, 0.02, writer.voices.menuText)
    elseif state == 'attack' and turn == 'enemies' then
        writer:stop()
    elseif state == 'fight' and turn == 'player' then
        battle.choice = -1
    elseif state == 'perform act' and turn == 'player' then
        encounter.doAct()
    end

    battle.turn = turn
    battle.state = state
end

function battleEngine.load(encounterName)
    -- Set up basic battle variables
    battle = {
        turn = 'player',
        state = 'buttons',
        choice = 0,
        subchoice = 0,
        turnCount = 1
    }

    -- Import assets
    sfx = {
        menumove = love.audio.newSource('assets/sound/menuMove.ogg', 'static'),
        menuselect = love.audio.newSource('assets/sound/menuSelect.ogg', 'static'),
    }
    fonts = {
        mars = love.graphics.newFont('assets/fonts/Mars_Needs_Cunnilingus.ttf', 23),
        determination = love.graphics.newFont('assets/fonts/determination-mono.ttf', 32),
        default = love.graphics.newFont(14)
    }

    -- Set all sounds to player configuration
    for _, sound in pairs(sfx) do
        sound:setVolume(conf.sfxVolume)
    end

    -- Import objects
    player = require 'source.battleEngine.player'
    ui = require 'source.battleEngine.ui'
    writer = require 'source.utils.writer'
    -- Set writer volume to player configuration
    for _, sound in pairs(writer.voices) do
        sound:setVolume(conf.textVolume)
    end
    encounter = require('encounters/' .. encounterName)
    itemManager = require 'source.utils.battleEngine.itemManager'

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
        battleEngine.changeBattleState('attack', 'enemies')
    else
        battleEngine.changeBattleState('buttons', 'player')
    end
end

function battleEngine.update(dt)
    encounter.update(dt)
    encounter.bgm:play()

    ui.update(dt)
    player.update(dt)
    writer:update(dt)
end

function battleEngine.draw()
    -- Saves the graphics state so drawing the ref and black base doesn't mess up the other stuff
    love.graphics.push("all")

    love.graphics.setColor(encounter.backgroundColor)
    love.graphics.rectangle('fill', 0, 0, 640, 480)

    love.graphics.setColor(1, 1, 1, 0)
    -- love.graphics.draw(refs.acts, 0, 0, 0, 0.5)

    love.graphics.pop()

    encounter.background()

    ui.draw()
    writer:draw()

    encounter.draw() -- basically draws the enemies and the background
    player.draw()
end

return battleEngine