local encounter = {}
encounter.enemies = {}

-- Import required libraries (DO NOT GET RID OF THESE)
local Enemy = require("source.utils.battleEngine.enemyClass")
local battleEngine = require("source.battleEngineState")

-- This makes importing images/sounds and stuff easier
local encounterPath = "encounters/Test enemies/" -- Rename "Test enemies" to the name of your encounter folder

-- Helper functions for acting so it's easier for me to program
local function performAct(act)
    if type(act.execute) == "function" then
        act:execute()
    end
end
local function performActText(selection, text)
    writer:setParams(encounter.enemies[player.chosenEnemy].acts[selection].text[text], 52, 274, fonts.determination, 0.02, writer.voices.menuText)
end
local actTextI = 1

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

    encounter.bgm = love.audio.newSource(encounterPath .. 'sound/mus_strongermonsters.ogg', 'stream')
    encounter.bgm:setVolume(conf.bgmVolume)
    encounter.bgm:setLooping(true)

    encounter.backgroundImage = love.graphics.newImage(encounterPath .. 'images/backgrounds/spr_battlebg_1.png')
    encounter.backgroundColor = {0, 0, 0}

    -- Enemy configuration
    encounter.enemies[1] = Enemy:new({
        name = "Enemy 1",
        description = "[clear]* The first half of the test[break]  site.",
        acts = {
            {
                name = 'Talk',
                execute = function()
                    -- nothing
                end,
                text = {
                    "* You try to talk to it.",
                    "* ...not much of a talker, I[break]  guess."
                }
            },
            {
                name = 'Unfinished',
                execute = function(self)
                    self.enemy.canSpare = true
                end,
                text = {
                    '[clear]* You point your arms out into[break]  opposite directions to form a[break]  "T" shape.',
                    "[clear]* Liking your now unfinished[break]  appearance, Enemy 1 is[break]  [yellow]sparing you."
                }
            },
        },

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
        description = "[clear]* The other half of the test[break]  site.",
        acts = {'Flap'},
        acts = {
            {
                name = 'Flap',
                execute = function(self)
                    self.enemy.canSpare = true
                end,
                text = {
                    "* You flap your arms like[break]  they're wings.",
                    "* Enemy 2 appreciates your effort     [break][clear][yellow]* Enemy 2 is sparing you."
                }
            }
        },
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
    player.stats.love = 8
    player.stats.name = 'A guy'
    player.inventory = {11, 1, 1, 23, 17, 19, 19, 10}
    player.hasKR = false

    -- Don't edit these
    player.stats.maxHp = 16 + (player.stats.love * 4)
    player.stats.hp = player.stats.maxHp
    player.kr = 0
end

function encounter.doAct()
    player.lastButton = battle.choice
    battle.choice = -1
    local enemy = encounter.enemies[player.chosenEnemy]
    if battle.subchoice > 0 then
        performAct(enemy.acts[battle.subchoice])
        performActText(battle.subchoice, actTextI)
    else
        writer:setParams("* " .. string.upper(enemy.name) .. " - ATT " .. enemy.attack .. " DEF " .. enemy.defense .. "[break]" .. enemy.description, 52, 274, fonts.determination, 0.02, writer.voices.menuText)
    end
end

function encounter.update(dt)
    for _, enemy in ipairs(encounter.enemies) do
        if enemy.name == 'Enemy 2' then         -- Basic enemy animation example
            local timer = love.timer.getTime()
            enemy.yOffset = (math.sin(timer*2) * 14) - 7
        end
    end

    if battle.state == 'perform act' then       -- Enable text scrolling in acting
        if writer.isDone and input.check('primary', 'pressed') then
            if battle.subchoice > 0 then
                if actTextI < #encounter.enemies[player.chosenEnemy].acts[battle.subchoice].text then
                    actTextI = actTextI + 1
                    performActText(battle.subchoice, actTextI)
                else
                    battleEngine.changeBattleState('attack', 'enemies')
                end
            else
                battleEngine.changeBattleState('attack', 'enemies')
            end
        end
    end

    if battle.state == 'attack' and battle.turn == 'enemies' then
        if input.check('secondary', 'pressed') then     -- Just here so I know that the player can go back to the menu
            input.refresh() -- So text doesn't skip
            actTextI = 1 -- Reset act text interval
            battleEngine.changeBattleState('buttons', 'player')
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
    love.graphics.setColor(encounter.backgroundColor)
    love.graphics.rectangle('fill', 0, 0, 640, 480)

    love.graphics.setColor(1, 1, 1)
    if encounter.backgroundImage then
        love.graphics.draw(encounter.backgroundImage)
    end
end

return encounter