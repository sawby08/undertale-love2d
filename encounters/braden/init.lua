local encounter = {}
encounter.enemies = {}

local Enemy = require("source.utils.enemyClass")

function encounter.load()
    encounter.text = "[clear]* DELTARUNE chapters 3 and 4[break]  release [rainbow]June [clear]4."
    encounter.startFirst = false
    encounter.canFlee = true

    encounter.bgm = love.audio.newSource('encounters/braden/sound/mus.ogg', 'stream')
    encounter.bgm:setVolume(0.5)
    encounter.bgm:setLooping(true)

    encounter.backgroundImage = nil

    encounter.enemies[1] = Enemy:new({
        name = "Braden",
        description = "* A guy out there in the world.",
        acts = {'Crash', 'Talk'},
        canSpare = false,
        showHPBar = true,
        hp = 100,
        maxHp = 100,
        attack = 5,
        defense = 2,
        imagePath = 'encounters/braden/images/spr_braden.png',
        x = 240,
        y = 42,

        attacks = {
            {
                load = function(self)
                    self.timer = 0
                end,

                update = function(self, dt)
                    local prevCount = math.floor(self.timer * 30)
                    self.timer = self.timer + dt
                    local currentCount = math.floor(self.timer * 30)

                    if prevCount < 30 and currentCount >= 30 then
                        battle.choice = player.lastButton
                        changeBattleState('buttons')
                        battle.turnCount = battle.turnCount + 1
                    end
                end,

                draw = function(self)
                    love.graphics.print('Attack timer: ' .. self.timer, 5, 5)
                end
            },
            {
                load = function(self)
                    self.timer = 0
                end,

                update = function(self, dt)
                    local prevCount = math.floor(self.timer * 30)
                    self.timer = self.timer + dt
                    local currentCount = math.floor(self.timer * 30)

                    --[[
                    if prevCount < 30 and currentCount >= 30 then
                        battle.choice = player.lastButton
                        changeBattleState('buttons')
                        battle.turnCount = battle.turnCount + 1
                    end
                    ]]
                end,

                draw = function(self)
                    love.graphics.print('Attack timer: ' .. self.timer, 5, 37)
                end
            }
        }
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
            if battle.state == 'attack' then
                enemy.attacks[battle.turnCount]:update(dt)
            end
        end
    end
end

function encounter.draw()
    love.graphics.setColor(1, 1, 1)
    for _, enemy in ipairs(encounter.enemies) do
        enemy:draw()
        if battle.turn == 'enemies' then
            if battle.state == 'attack' then
                enemy.attacks[battle.turnCount]:draw()
            end
        end
    end
end

function encounter.background()
    if encounter.backgroundImage then
        love.graphics.draw(encounter.backgroundImage)
    end
end

return encounter