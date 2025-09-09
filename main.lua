
lg = love.graphics
fontH = lg.newFont("nihonium.otf", 90) 

wW = lg.getWidth()
wH = lg.getHeight()
function love:load()
    header = "Gratitude Quest"
    headerArray = {}
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
end

