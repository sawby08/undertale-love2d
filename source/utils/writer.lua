local writer = {}

local text
local parsedText = {}
local startX, startY
local timeSince, timeInterval
local textFont
local textSound = 1
local index = 1
local doingText = false

writer.isDone = nil

local colors = {
    white = {1, 1, 1},
    red = {1, 0, 0},
    green = {0, 1, 0},
    blue = {0, 0, 1},
    cyan = {0, 1, 1},
    yellow = {1, 1, 0},
    weirdRed = {1, .2, .4},
    orange = {1, .4, .2},
    black = {0, 0, 0},
    rainbow = true
}


local function parseText(raw)
    local parsed = {}
    local i = 1
    local currentColor = 'white'
    local currentAnim = 'none'

    while i <= #raw do
        local char = raw:sub(i, i)

        if char == '[' then
            local close = raw:find("]", i)
            if close then
                local code = raw:sub(i + 1, close - 1)

                if code == "break" then
                    table.insert(parsed, {char = "\n", color = currentColor, animation = currentAnim})
                elseif code == "clear" then
                    currentColor = 'white'
                    currentAnim = 'none'
                elseif colors[code] then
                    currentColor = code
                elseif code == "wave" or code == "shake" then
                    currentAnim = code
                end

                i = close + 1
            else
                i = i + 1
            end
        else
            table.insert(parsed, {
                char = char,
                color = currentColor,
                animation = currentAnim
            })
            i = i + 1
        end
    end

    return parsed
end

function writer:stop()
    doingText = false
    index = #parsedText
end

function writer:setParams(string, x, y, font, time, sound)
    text = string or 'no string provided :/'
    parsedText = parseText(text)
    startX = x or 0
    startY = y or 0
    textFont = font or fonts.mono
    timeInterval = time or 0.01
    textSound = sound
    timeSince = 0
    index = 1
    doingText = true
    writer.isDone = false
end

function writer:update(dt)
    if not doingText then return end

    timeSince = timeSince + dt

    while timeSince >= timeInterval and index < #parsedText do
        local c = parsedText[index + 1]

        if c and (c.char == '' or c.char == nil) then
            index = index + 1
        else
            index = index + 1
            timeSince = 0

            if c.char ~= ' ' and c.char ~= '\n' then
                textSound:stop()
                textSound:play()
            end

            break
        end
    end

    if index >= #parsedText then
        writer.isDone = true
    end

    if input.check('secondary', 'pressed') then
        index = #parsedText
        writer.isDone = true
    end
end

function writer:draw()
    if not doingText then return end

    love.graphics.setFont(textFont)

    local x = startX
    local y = startY
    local animi = 1

    for i = 1, index do
        local c = parsedText[i]
        local shakeX, shakeY = 0, 0

        if c.animation == "wave" then
            shakeX = math.sin(love.timer.getTime() * -8 + animi) * 2
            shakeY = math.cos(love.timer.getTime() * -8 + animi) * 2
        elseif c.animation == "shake" then
            shakeX = love.math.random(-1, 1)
            shakeY = love.math.random(-1, 1)
        end

        if c.char == "\n" then
            x = startX
            y = y + 32
        else
            local currentColor
            if c.color == "rainbow" then
                local t = love.timer.getTime() * 2 + i * 0.2
                local r = 0.5 + 0.5 * math.sin(t)
                local g = 0.5 + 0.5 * math.sin(t + 2)
                local b = 0.5 + 0.5 * math.sin(t + 4)
                currentColor = {r, g, b}
            else
                currentColor = colors[c.color] or colors.white
            end

            love.graphics.setColor(currentColor)
            love.graphics.print(c.char, x + shakeX, y + shakeY)
            x = x + love.graphics.getFont():getWidth(c.char)
            if c.char ~= ' ' then
                animi = animi + 0.5
            end
        end
    end
end

return writer
