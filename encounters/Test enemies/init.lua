local encounter = {}
encounter.enemies = {}

-- Import required libraries (DO NOT GET RID OF THESE)
local Enemy = require("source.utils.battleEngine.enemyClass")
local battleEngine = require("source.battleEngineState")

-- This makes importing images/sounds and stuff easier
local encounterPath = "encounters/Test enemies/" -- Rename "Test enemies" to the name of your encounter folder

-- The main stuff that can be edited
function encounter.load()
    -- General encounter configuration
    encounter.text = {                                      -- This can either be an array and get a string chosen randomly or just one string
        "[clear]* The test enemies draw near.",
        "[clear]* [red][shake]Lorem [green][wave]ipsum [clear][blue]dolar[clear].",
        "[clear][rainbow]* Happy pride month!"
    }
    encounter.startFirst = false
    encounter.canFlee = true

    encounter.bgm = love.audio.newSource(encounterPath .. 'sound/mus.ogg', 'stream')
    encounter.bgm:setVolume(conf.bgmVolume)
    encounter.bgm:setLooping(true)

    encounter.backgroundImage = love.graphics.newImage(encounterPath .. 'images/backgrounds/spr_battlebg_0.png')
    encounter.backgroundColor = {0, 0, 0}

    -- Enemy configuration
    encounter.enemies[1] = Enemy:new({
        name = "Enemy 1",
        description = "[clear]* It can't land a punch but it can take one.",
        acts = {'Talk', 'Shield'},

        canSpare = false,
        showHPBar = true,
        canDodge = false,

        hp = 100,
        maxHp = 100,
        attack = 2,
        defense = 5,

        imagePath = encounterPath .. 'images/test1.png',
        imageScale = 1,
        x = 145,
        y = 34,
        yOffset = 0,
        xOffset = 0
    })
    encounter.enemies[2] = Enemy:new({
        name = "Enemy 2",
        description = "[clear]* A flier.[break]* Not too many fliers around here.",
        acts = {'Flap'},
        canSpare = false,
        showHPBar = true,

        hp = 50,
        maxHp = 50,
        attack = 2,
        defense = 2,

        imagePath = encounterPath .. 'images/test2.png',
        imageScale = 1,
        x = 345,
        y = 140,
        yOffset = 0,
        xOffset = 0
    })

    -- Player specific encounter stats
    player.stats.love = 7
    player.stats.name = 'John'
    player.inventory = {11, 1, 1, 23, 17, 19, 19, 10}
    player.hasKR = false

    -- Don't edit these
    player.stats.maxHp = 16 + (player.stats.love * 4)
    player.stats.hp = player.stats.maxHp
    player.kr = 0
end

function encounter.update(dt)
    for _, enemy in ipairs(encounter.enemies) do
        if enemy.name == 'Enemy 2' then
            local timer = love.timer.getTime()
            enemy.yOffset = (math.sin(timer*2) * 14) - 7
        end
    end
end

function encounter.draw()
    love.graphics.setColor(1, 1, 1)
    -- Draw enemies individually
    for _, enemy in ipairs(encounter.enemies) do
        enemy:draw()
    end
end

-- Draw enemy background
function encounter.background()
    if encounter.backgroundImage then
        love.graphics.draw(encounter.backgroundImage)
    end
end

return encounter