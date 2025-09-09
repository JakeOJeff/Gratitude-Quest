lg = love.graphics
fontH = lg.newFont("Palisade.otf", 100)
fontP = lg.newFont("quilka.otf", 25)
fontPP = lg.newFont("quilka.otf", 13)
    data = require "data"

wW = lg.getWidth()
wH = lg.getHeight()
function love:load()
    header = "Gratitude Quest"
    headerArray = {}
    rightArrow = lg.newImage("right-arrow.png")
    leftArrow = lg.newImage("left-arrow.png")

    startedTyping = false

    inputBox = {
        width = wW / 2,
        height = 50,
        value = ""
    }
    inputBox.x = wW / 2 - inputBox.width / 2
    inputBox.y = wH / 2 - inputBox.height / 2

    for i = 1, #header do
        headerArray[i] = header:sub(i, i)
    end
    searchList = {}
end

function love:update(dt)
    if inputBox.value ~= "" then
        startedTyping = true
    else
        startedTyping = false
    end
end

function love:draw()
    
    lg.setColor(1, 1, 1)
    lg.setFont(fontH)

    local totalWidth = fontH:getWidth(header)
    local startX = wW / 2 - totalWidth / 2
    local baseY = wH / 4 - fontH:getHeight() / 2

    local currentX = startX

    for i, char in ipairs(headerArray) do
        local waveHeight = 5 + #inputBox.value * 2 -- amplitude
        local waveSpeed = 3                        -- speed
        local waveFreq = 0.2 + #inputBox.value     -- frequency

        local waveY = math.sin(love.timer.getTime() * waveSpeed + i * waveFreq) * waveHeight

        lg.print(char, currentX, baseY + waveY)


        currentX = currentX + fontH:getWidth(char)
    end
    lg.setFont(fontP)
    lg.setLineWidth(math.sin(love.timer.getTime() * 2 + 3))
    lg.rectangle("line", inputBox.x, inputBox.y, inputBox.width, inputBox.height, 10, 10)
    lg.print(inputBox.value, inputBox.x + (inputBox.width / 2 - fontP:getWidth(inputBox.value) / 2),
        inputBox.y + (inputBox.height / 2 - fontP:getHeight() / 2))
        lg.setFont(fontPP)

    if not startedTyping then
        lg.draw(rightArrow, inputBox.x - rightArrow:getWidth() - 30 + (math.sin(love.timer.getTime() * 15) * 5),
            inputBox.y + (inputBox.height / 2 - rightArrow:getHeight() / 2))
        lg.draw(leftArrow, inputBox.x + inputBox.width + 30 + (math.sin(love.timer.getTime() * 15) * 5),
            inputBox.y + (inputBox.height / 2 - leftArrow:getHeight() / 2))
        lg.setColor(0.7, 0.7, 0.7)
        lg.setFont(fontPP)
        lg.print("type in your discord username to see!",
            inputBox.x + (inputBox.width / 2 - fontPP:getWidth("type in your discord username to see!") / 2),
            inputBox.y + (inputBox.height) + 20)
    else
        for i, v in ipairs(searchList) do
            local text = v.name
            local x = inputBox.x + (inputBox.width /2 - fontPP:getWidth(text)/2)
            local y = inputBox.y + (inputBox.height) + 40 * i
            lg.rectangle("line", x - 15, y, fontPP:getWidth(text) + 30, fontPP:getHeight() + 15)
            lg.print(text, x, y + 7)
        end
    end
end

function love.keypressed(key)
    if key == "backspace" then
        if inputBox.value ~= "" then
            inputBox.value = string.sub(inputBox.value, 1, -2)
        end
    end
        searchData()

end

function love.textinput(t)
    if fontP:getWidth(inputBox.value) < (inputBox.width - fontP:getWidth("a") * 2) then
        inputBox.value = inputBox.value .. t
    end
        searchData()

end

function searchData()
    searchList = {}
    for i, v in ipairs(data) do
        if string.find(v.name, inputBox.value) then
            table.insert(searchList, v)
        end
    end

end