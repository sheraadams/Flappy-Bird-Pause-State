-- pause feature added to main.lua in below functions:

function love.update(dt)
    -- scroll our background and ground, looping back to 0 after a certain amount
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

    -- spawn pipes every two seconds here add random
    spawnTimer = spawnTimer + dt 
   
    if spawnTimer > randomDT then
        spawnTimer = 0
        table.insert(pipes, Pipe())
    end
    
    bird:update(dt)

    for k, pipe in pairs(pipes) do
        pipe:update(dt)

        if pipe.x < -pipe.width then
            table.remove(pipes, k)
        end

    end

    gStateMachine:update(dt)


    -- pause feature
    if love.keyboard.wasPressed('p') or love.keyboard.wasPressed('P') then
        if pause == false then
            pause = true
            
            BACKGROUND_SCROLL_SPEED = 0
            GROUND_SCROLL_SPEED = 0

            sounds['pause']:play()
            love.audio.pause(sounds['music'], sounds['explosion'], sounds['score'], sounds['jump'], sounds ['pause'], sounds['hurt'])

        else
            pause = false

            BACKGROUND_SCROLL_SPEED = 30
            GROUND_SCROLL_SPEED = 60

            sounds['music']:setLooping(true)
            sounds['music']:play()

        end
    end

    -- reset input table
    love.keyboard.keysPressed = {}

    love.mouse.buttonsPressed = {}
end

-- drawing the scene last 
function love.draw() 

    push:start()
   
    -- draw background first
    love.graphics.draw(background, -backgroundScroll, 0)

    -- render pipes next
    for k, pipe in pairs(pipes) do
        pipe:render()
    end

    gStateMachine:render()

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
  
    if pause == true and love.keyboard.wasPressed('p')  then
        love.graphics.draw(playImg, VIRTUAL_WIDTH/2 - playImg:getWidth()/2, VIRTUAL_HEIGHT/2 - playImg:getHeight()/2)
    elseif pause == true then
        love.graphics.draw(pauseImg, VIRTUAL_WIDTH/2 - pauseImg:getWidth()/2, VIRTUAL_HEIGHT/2 - pauseImg:getHeight()/2)
    end

    push:finish()
end
