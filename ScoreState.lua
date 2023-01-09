ScoreState = Class{__includes = BaseState}

local dead = love.graphics.newImage('dead3.png')
local dead2 = love.graphics.newImage('dead2.png')
local gold = love.graphics.newImage('gold.png')
local silver = love.graphics.newImage('silver.png')
local bronze = love.graphics.newImage('bronze.png')

function ScoreState:enter(params)
    self.score = params.score
    if self.score == 0 then
        medal = 0
    elseif self.score >= 4 then
        medal = 1
    elseif self.score >= 2 then
        medal = 2
    elseif self.score >= 1 then
        medal = 3

    end

end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    --  render the score to the middle of the screen and decide the screen based on score 
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    if medal == 0 then 
       love.graphics.draw(dead2, VIRTUAL_WIDTH/2 -95, VIRTUAL_HEIGHT/2 -50)     

    elseif medal == 1 then
        love.graphics.draw(gold, VIRTUAL_WIDTH - 120, 90)
        love.graphics.printf('You won a Gold Medal!', 393, 170, gold:getWidth(), 'center')
        love.graphics.draw(dead, 10, 80)    

    elseif medal == 2 then
        love.graphics.draw(silver, VIRTUAL_WIDTH - 120, 90)
        love.graphics.printf('You won a Silver Medal!', 393, 170, silver:getWidth(), 'center')
        love.graphics.draw(dead, 10, 80)    

    elseif medal == 3 then
        love.graphics.draw(bronze, VIRTUAL_WIDTH - 120, 90)
        love.graphics.printf('You won a Bronze Medal!', 393, 170, bronze:getWidth(), 'center')
        love.graphics.draw(dead, 10, 80)      
    end

    love.graphics.printf('', 10, 0, VIRTUAL_WIDTH, 'center')
end 
