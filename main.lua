-- title:   git project
-- author:  obi3112
-- desc:    simple game that is coded for fun ig lol.
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- date : 29/06/2023 (DD/MM/YYYY format)
-- script:  lua

--adding props to the game
--PROPS START
chairData = {x=116 - 20, y=64-20}
gunData = {}
paintingData = {}
--PROPS END

player = {x=116,y=64} --player position at center.
diagBox = {
	x=0,
	y=86,
	w=232+8,
	h=50
}

dialogueIndex = 1
dialogues = {
    "Welcome to my tic80 project\n press Z to continue",
    "this is a simple game that i \ncoded in tic80.press Z to continue",
    "You may press Z again to end this dialogue.",
}
mode="menu" --default game state
scr=15
function menu()
if mode=="menu"then
 for i=1, 100 do
 col=math.random(1,16)
 	for j=1, 100 do
			circ(i*13, j*9, 3, col) 
 	end
 end
 print("PRESS X TO PLAY", 50,50,12)
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
	playerSpr = spr(256,player.x,player.y,14, 1, 0, 0,1,1)
	text = rectb(diagBox.x,diagBox.y,diagBox.w,diagBox.h, 12)
	if keyp(26) then
	 dialogueIndex = dialogueIndex + 1
		--adding sound effects for the dialogue.
		diagSfx = sfx(0,-1,-1,0,15,0)	
		if dialogueIndex > #dialogues then
			--remove the dialogues text
			diagBox.w = 0
			diagBox.h = 0
			dialogues[dialogueIndex] = ""
		--stopping the sound from playing.
			diagSfx = sfx(-1)
		--start playing the music.
		--msc = music(-1, 60,16,true,false,145,1)
		end
	end
	print(dialogues[dialogueIndex], diagBox.x, diagBox.y+5,12)
end
function game()
	--moving_walls()
	loadProps()
	movePlayer()
	playerCollisions()
	loadDialogue()
end
function loadProps()
	chair = spr(10, chairData.x, chairData.y, 0, 1, 0,0,1,1)
--	gun = spr()
--	painting = spr()
end


function TIC()
	cls(scr)
	menu()
end