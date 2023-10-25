--author:marioboi3112
--desc: simple code to make keystrokes for TIC-80

--UPDATE: code can now be accessed as a class for more flexibilty or you can edit the table keys yourself :)

function Keystroke()
return{
	--variables for the keystroke
		wX = 10,
		wY = 4,
		aX = 4,
		aY = 10,
		sX = 10,
		sY = 10,
		dX = 16,
		dY = 10,
	render = function(self)
		local wBox = rect(self.wX, self.wY, 5, 5, 2)
    local aBox = rect(self.aX, self.aY, 5, 5, 2)
    local sBox = rect(self.sX, self.sY, 5, 5, 2)
    local dBox = rect(self.dX, self.dY, 5, 5, 2)
		w =	print("W", self.wX,self.wY,12)
		a = print("A", self.aX,self.aY,12)
		s = print("S", self.sX,self.sY,12)
    d = print("D", self.dX,self.dY,12)

   if key(23) then print("W", self.wX,self.wY,0)end
   if key(1) then print("A", self.aX,self.aY,0)end
   if key(19) then print("S",self.sX,self.sY,0)end
   if key(4) then print("D", self.dX,self.dY,0)end
	end
}
end

function TIC()
cls(3)
local keystroke = Keystroke()
keystroke:render()	
end