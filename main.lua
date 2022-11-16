-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local physics = require ("physics")
physics.start()

local background = display.newRect(160, 250, 350, 550)
background:setFillColor(0.4, 0.2, 0.3)

local hx = 160
local hy = -20
for i=1, 28  do
    local myGrid = display.newRect(hx, hy, 350, 2)
    myGrid:setFillColor(0.5, 0.5, 0.5)
    hy=hy+20
end  

local vx = 20
local vy = 250
for i=1, 16 do
    local myGrid = display.newRect(vx, vy, 2, 550)
    myGrid:setFillColor(0.5,0.5,0.5)
    vx=vx+20
end   

local block_1 = display.newRect(280, 430, 40, 220)
local block_2 = display.newRect(280, 65, 40, 180)

local block_3 = display.newRect(440, 450, 40, 180)
local block_4 = display.newRect(440, 85, 40, 220)

local block_5 = display.newRect(600, 470, 40, 140)
local block_6 = display.newRect(600, 105, 40, 260)

local block_7 = display.newRect(760, 490, 40, 100)
local block_8 = display.newRect(760, 125, 40, 300)

local bird = display.newRect(40, 200, 40, 40)
bird:setFillColor(0.5,0.7,0.9)

physics.addBody(bird)
bird.gravityScale = 0
bird.isFixedRotation = false
bird.isSensor = true

physics.addBody(block_1, "static")
physics.addBody(block_2, "static")
physics.addBody(block_3, "static")
physics.addBody(block_4, "static")
physics.addBody(block_5, "static")
physics.addBody(block_6, "static")
physics.addBody(block_7, "static")
physics.addBody(block_8, "static")

bird.ID="Bird"

block_1.ID="Crash"
block_2.ID="Crash"
block_3.ID="Crash"
block_4.ID="Crash"
block_5.ID="Crash"
block_6.ID="Crash"
block_7.ID="Crash"
block_8.ID="Crash"


local moveDown = 4
local moveUp = 0
local function toBird(event)
    if(event.phase == "began") then
        moveUp=11
    end    
end

local speed = 0.7
local function onUpdate(event)
    block_1.x = block_1.x - 0.5 - speed
    block_2.x = block_1.x - 0.5 - speed
    
    block_3.x = block_3.x - 0.5 - speed
    block_4.x = block_3.x - 0.5 - speed
    
    block_5.x = block_5.x - 0.5 - speed
    block_6.x = block_5.x - 0.5 - speed
    
    block_7.x = block_7.x - 0.5 - speed
    block_8.x = block_7.x - 0.5 - speed
    
    if(block_1.x <= -20) then
        block_1.x = block_7.x + 160
        elseif(block_3.x<=-20) then
        block_3.x = block_1.x + 160
        elseif(block_5.x<=-20) then
        block_5.x = block_3.x + 160
        elseif(block_7.x<=-20) then
        block_7.x = block_5.x + 160 
    end
    
    if (moveUp > 0)then
        bird.y=bird.y-moveUp
        moveUp= moveUp - 0.8
    end    
    bird.y=bird.y+moveDown
    
    if(bird.y<-40) then
        endGame()
        elseif(bird.y>520) then
        endGame();
    end
end 

local function onLocalCollision(self, event)
    if(event.phase == "began") then
    if(self.ID == "Bird" and event.other.ID == "Crash" )then
            endGame()
    end
    end
end

function endGame()
   bird:removeEventListener("collision")
   Runtime:removeEventListener("enterFrame", onUpdate)
   Runtime:removeEventListener("touch", toBird)
   local text = display.newText("Вы проиграли", 160, 100, font, 32)
   text:setFillColor(0,0,0)
end

bird.collision = onLocalCollision
bird:addEventListener("collision", bird)

Runtime:addEventListener("enterFrame", onUpdate)
Runtime:addEventListener("touch", toBird)