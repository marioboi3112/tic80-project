--title:   git project
-- author:  obi3112
-- desc:    simple game that is coded for fun ig lol.
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- date: 29/06/2023 (DD/MM/YYYY format)
-- script: lua

--adding props to the game
--PROPS START
chairData = {x=116 - 20, y=64-20}
gunData = {id=17,x=106,y=40}
tableData = {x=106, y=44}
paintingData = {}
--PROPS END
t=0 --time variable
player = {x=116,y=64} --player position at center.
diagBox = {
	x=0,
	y=86,
	w=232+8,
	h=50
}
--[[	oop shit]]--
function Entity(x,y,w,h,col,id,colCode)
	return {
		id=id or "Entity",
		x=x,
		y=y,
		w=w,
		h=h,
		col=col,
		render = function(self,x,y,w,h,col)
			rect(self.x,self.y,self.w,self.h,self.col)
		end
	}
end

function EntityNormalEnemy(id)
	local normalEnemy = Entity()
	normalEnemy.roar = function(self)
		trace(self.id .. " roared!!!")
	end
	return normalEnemy
end


dialogueIndex = 1
dialogues = {
    "Welcome to my tic80 project\n press Z to continue",
    "this is a simple game that i \ncoded in tic80.press Z to continue",
    "make sure to read the instructions \n to deal with any confusion \n when playing the game.",
    "there are some items that you may or may not \n be able to pick up. \n such items that you can pick up have a white \n box around them like the gun on the table",
   	"go and press Z to pick it up!",
    "You may press Z again to end this dialogue.",
}
mode="menu" --default game state
scr=15
function pickItems()
 --pick gun
 local gunPlayerDistXPos=gunData.x - player.x
 local gunPlayerDistYPos=gunData.y - player.y
 print(gunPlayerDistXPos .. " " .. gunPlayerDistYPos, 0, 0, 12) 
	if (gunPlayerDistYPos > 6 and gunPlayerDistYPos > 6) then 
	 trace("pickable", math.random(1,12))
	end
end

function menu()
if mode=="menu"then
 for i=1, 100 do
 	for j=1, 100 do
		 col=math.random(1,16)
			circ(i*13, j*9, 3, col) 
 	end
 end
 print("PRESS X TO PLAY", 50,50,0)
 if key(24) then
  mode="game"
 end
 elseif mode=="game" then  game()end
end
function movePlayer()
	if btn(0)then --up
		player.y = player.y - 2
	elseif btn(1)then --down
		player.y = player.y + 2
	end
	if btn(2)then --left
		player.x = player.x - 2
	elseif btn(3)then --right
		player.x = player.x + 2
	end
end
function playerCollisions()
	--making sure the player doesn't get off screen.
	if player.x < 0 then
		player.x = 0
	end
	if player.x > 232 then
		player.x = 232
	end
	if player.y > 128 then
		player.y = 128
	end
	if player.y < 0 then
		player.y = 0
	end
	--making the player collidable with props.
	
end
function moving_walls()
	wall = rect(200, 0, 128-12,130 , 12)
	--debugging to find the positions of the player
	print(tostring("X: " .. player.x .. " Y: " .. player.y), 0, 18, 12)
end
function loadDialogue()
	playerSpr = spr(256,player.x,player.y,0, 1, 0, 0,1,1)
	text = rectb(diagBox.x,diagBox.y,diagBox.w,diagBox.h, 12)
	if keyp(26) then
	 dialogueIndex = dialogueIndex + 1
		--adding sound effects for the dialogue.
		--diagSfx = sfx(1,"E-4")	
		if dialogueIndex > #dialogues then
			--remove the dialogues text
			diagBox.w = 0
			diagBox.h = 0
			dialogues[dialogueIndex] = ""
		--stopping the sound from playing.
			--diagSfx = sfx(-1)
		--start playing the music.
		--msc = music(-1, 60,16,true,false,145,1)
		end
	end
	print(dialogues[dialogueIndex], diagBox.x, diagBox.y+5,12)
end

function renderer() --function to handle the rendering shit.
	--INSTANCES
	local player = Entity(10,10,5,5,4) --making a new instance of the entity class.
	--METHODS
	player:render() --call the render function on this dude
end

function game()
	renderProps()
	movePlayer()
	playerCollisions()
	loadDialogue()
	pickItems()
	renderer()
end
function renderProps()
	chairSpr = spr(10, chairData.x, chairData.y, 0, 1, 0,0,1,1)
	tableSpr = spr(11, tableData.x, tableData.y, 0,1,0,0,1,1,1)
	gunSpr = spr(gunData.id, gunData.x, gunData.y,13,1,0,0,1,1,1)
end


function TIC()
 cls(scr)
	menu()
	
	t=t+1
end