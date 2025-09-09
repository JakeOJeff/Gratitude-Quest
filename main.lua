
lg = love.graphics
fontH = lg.newFont("Palisade.otf", 100) 
fontP = lg.newFont("quilka.otf", 25)

wW = lg.getWidth()
wH = lg.getHeight()
function love:load()
    header = "Gratitude Quest"
    headerArray = {}
    rightArrow = lg.newImage("right-arrow.png")
    leftArrow = lg.newImage("left-arrow.png")

    

    inputBox = {
        width = wW/2,
        height = 50,
        value = ""
    }
    inputBox.x = wW/2 - inputBox.width/2
    inputBox.y = wH/2 - inputBox.height/2

    for i = 1, #header do
        headerArray[i] = header:sub(i, i)
    end
end

function love:update(dt)

end

function love:draw()
    lg.setColor(1, 1, 1)
    lg.setFont(fontH)
    
    local totalWidth = fontH:getWidth(header)
    local startX = wW / 2 - totalWidth / 2
    local baseY = wH / 4 - fontH:getHeight() / 2
    
    local currentX = startX
    
    for i, char in ipairs(headerArray) do
        local waveHeight = 5   -- amplitude
        local waveSpeed = 3    -- speed
        local waveFreq = 0.2   -- frequency
        
        local waveY = math.sin(love.timer.getTime() * waveSpeed + i * waveFreq) * waveHeight
        
        lg.print(char, currentX, baseY + waveY)

        
        currentX = currentX + fontH:getWidth(char)
    end
    lg.setFont(fontP)
    lg.setLineWidth(math.sin(love.timer.getTime() * 2 + 2))
    lg.rectangle("line", inputBox.x, inputBox.y, inputBox.width, inputBox.height, 10, 10)
    lg.print(inputBox.value, inputBox.x + (inputBox.width/2 - fontP:getWidth(inputBox.value)/2), inputBox.y + (inputBox.height/2 - fontP:getHeight()/2))
end



function love.textinput(t)
    if  fontP:getWidth(inputBox.value) < (inputBox.width - fontP:getWidth("a") * 2) then
        inputBox.value = inputBox.value .. t
    end
end