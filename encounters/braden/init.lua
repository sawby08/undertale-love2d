local encounter = {}
encounter.enemies = {}

local Enemy = require("source.utils.battleEngine.enemyClass")

function encounter.load()
    encounter.text = "[clear]* DELTARUNE chapters 3 and 4[break]  have released [rainbow]June [clear]4."
    encounter.startFirst = false
    encounter.canFlee = true

    if encounter.bgm then encounter.bgm:stop() end
    encounter.bgm = love.audio.newSource('encounters/braden/sound/mus.ogg', 'stream')
    encounter.bgm:setVolume(conf.bgmVolume)
    encounter.bgm:setLooping(true)

    encounter.backgroundImage = nil

    encounter.enemies[1] = Enemy:new({
        name = "Sawby",
        description = "* A guy out there in the world.",
        acts = {'Crash', 'Talk'},
        canSpare = true,
        showHPBar = false,
        hp = 100,
        maxHp = 100,
        attack = 5,
        defense = 2,
        imagePath = 'encounters/braden/images/spr_braden.png',
        x = 120,
        y = 42,
    })
    encounter.enemies[2] = Enemy:new({
        name = "bradensMG",
        description = "* Retired.",
        acts = {},
        canSpare = false,
        showHPBar = false,
        hp = 100,
        maxHp = 100,
        attack = 5,
        defense = 2,
        imagePath = 'encounters/braden/images/spr_braden.png',
        x = 240,
        y = 42,
    })
    encounter.enemies[3] = Enemy:new({
        name = "BradensMediocreGames",
        description = "* Who this this guy?",
        acts = {},
        canSpare = false,
        showHPBar = false,
        hp = 1,
        maxHp = 1,
        attack = 5,
        defense = 2,
        imagePath = 'encounters/braden/images/spr_braden.png',
        x = 360,
        y = 42,
    })


    player.stats.love = 1
    player.stats.name = nil
    player.inventory = {11, 1, 1, 23, 17, 19, 19, 10}
    player.hasKR = false

    player.stats.maxHp = 16 + (player.stats.love * 4)
    player.stats.hp = player.stats.maxHp
    player.kr = 0
end

function encounter.update(dt)
    for _, enemy in ipairs(encounter.enemies) do
        if battle.turn == 'enemies' then
            if input.check('secondary', 'pressed') then
                battle.choice = player.lastButton
                input.refresh()
                changeBattleState('buttons')
            end
        end
    end
end

function encounter.draw()
    love.graphics.setColor(1, 1, 1)
    for _, enemy in ipairs(encounter.enemies) do
        enemy:draw()
        if battle.turn == 'enemies' then

        end
    end
end

function encounter.background()
    if encounter.backgroundImage then
        love.graphics.draw(encounter.backgroundImage)
    end
end

return encounter