-- author: JoaoPauloVF
-- desc:   a function that creates timers for events in execution time
-- script: lua
-- input: keyboard
-- license: MIT
-- github: https://github.com/JoaoPauloVF/My-TIC-Cartridges#readme

--[[
SUMMARY(ctrl+f and search for the chapter)

 DESCRIPTION....................:-1-
 TIMER OBJECT                   :-2-
   TIMER VARIABLES AND FUNCTIONS:-2-1
     VARIABLES..................:-2-2
     FUNCTIONS                  :-2-3
     DETAILS....................:-2-4
 HOW TO USE                     :-3-
 NOTES..........................:-4-
 COMPLETE FUNCTION              :-5-
 ONE-LINE FUNCTION..............:-5-1
]]--

--[[

          -1---DESCRIPTION----

 Returns a Timer object. Timer objects
 can be associated with an event and 
 return the time since this event 
 becomes true. 
 See more about Timer objects below.

            ----newTimer----
            
 newTimer --> Timer object

          -2---TIMER OBJECT----

 The Timer Object is a table having 
 variables and functions related to 
 counting the time.

 -2-1--TIMER VARIABLES AND FUNCTIONS----

VARIABLES-2-2

 event <-- boolean
 timeCount <-- global time

FUNCTIONS-2-3

 count --> time
 wait starting [ending=math.huge] --> true/false
 waitFreq frequency --> true/false

DETAILS-2-4

 event: 
    What the timer counts. This 
    can be anything that results in a 
    boolean, such as relational 
    expressions, boolean expressions,
    and functions like btn() and key(). 
    If it isn't a boolean or it 
    doesn't have any value, it is 
    set false.

 timeCount: 
    How the timer counts. The default 
    value is time(), but it can be any 
    variable that works like a 
    global timer.

 count(): 
    Returns the time according to the 
    timeCount since the event 
    becomes true.

 wait(time): 
    Returns true if the count is 
    more or equal to some time.

 wait(starting, ending): 
    Returns true if the count is 
    between the starting time and 
    the ending time.

 waitFreq(frequency): 
    Returns true every cycle of 
    some time amount(frequency).

           -3---HOW TO USE----
           
 First, have the newTimer function
 (see the SUMMARY) in your code.

 After this, use it to create a new 
 Timer object and to keep it in a 
 variable:

    timer = newTimer()

 You can create how many Timer Objects
 you want:

    timer1 = newTimer()
    timer2 = newTimer()
    timer3 = newTimer()
    timers = {
      newTimer(), 
      newTimer(), 
      newTimer()
    }

 Now, in the TIC(), update the 
 event and timeCount values. 
 They must be update every frame:
    
    t = 0
    function TIC()
        ...
        timer.event = btn(0)
        timer.timeCount = t  --It can be time() too
        ...
        t = t + 1
    end

 Done! You already can use the count, 
 wait, and waitFreq functions. Go to 
 TIC() for seeing some examples.

             -4---NOTES----

 *I planned the Timer Object having
 one event and one timeCount only.
 This means that do something like:
 
    timer = newTimer()
    t = 0
    function TIC()
        ...
        timer.event = btn(0)
        timer.timeCount = t
        ...
        timer.event = key(48)
        timer.timeCount = time()
        ...
        t = t + 1
    end
    
 probably produces incoherent results
 in its functions.

 *There be one-timer for each event 
 can be a mess in more complex 
 projects. I could try making a 
 simpler function to return the time 
 of some event as 
 timer(event, timeCount).
]]--

--5--COMPLETE FUNCTION----
function newTimer()
  local self = {}
  
  self.event = false
  self.timeCount = false
  
  local current = 0        -- time in the current frame
  local last = self.current-- time in the last frame
  
  self.count = function()
    self.event = type(self.event) == "boolean" and self.event or false
    
    current = not(self.timeCount) and time() or self.timeCount 
    last = self.event and last or current
    
    return current - last  --time interval
  end
  
  self.wait = function(starting, ending)  
    if not(starting) then return false end
    
    ending = ending or math.huge
    
    return self.count() >= math.abs(starting) and self.count() <= math.abs(ending)
  end
  
  self.waitFreq = function(frequency)
    if frequency == 0 then return false end
    
    return self.count()%(frequency*2) > frequency
  end
  
   
  return self
end

----ONE-LINE FUNCTION-5-1-
--function newTimer()local a={};a.event=false;a.timeCount=false;local b=0;local c=a.b;a.count=function()a.event=type(a.event)=="boolean"and a.event or false;b=not(a.timeCount)and time()or a.timeCount;c=a.event and c or b;return b-c;end;a.wait=function(d, e)if not(d)then return false end;e=e or math.huge;return a.count()>=math.abs(d)and a.count()<=math.abs(e);end a.waitFreq=function(f)if f==0then return false end;return a.count()%(f*2)>f;end;return a;end


--This is just another custom function
--For more information: https://tic80.com/play?cart=2594
local function printAlign(text, x, y, alignX, alignY, color, fixed, scale, smallFont)
  local x = x or 0
  local y = y or 0
  local alignX = alignX or "right"
  local alignY = alignY or "bottom"
  local color = color or 15
  local fixed = fixed or false
  local scale = scale or 1
  local smallFont = smallFont or false
  
  local font_h = 6 * scale
  local font_w = print(text, 0, -font_h*scale, color, fixed, scale, smallFont)
  
  x = alignX=="right" and x or alignX=="center" and x - font_w//2 or alignX=="left" and x - font_w + 1*scale or x --if alignX is not any of the accepted values, x gets the default value from "right".
  y = alignY=="bottom" and y or alignY=="middle" and y - font_h//2 or alignY=="top" and y - font_h + 1*scale or y --The same for alignY that y gets the value from "bottom".
  
  print(text, x, y, color, fixed, scale, smallFont)
end


--Initialize the Timer
timer = newTimer()
--Internal use
timerButtons = newTimer()

--Variable for count the ticks/frames
countTicks = 0

--Others Variables
WIDTH = 240
HEIGHT = 136

x = WIDTH * 0.05
x2 = WIDTH * 0.95
y = HEIGHT * 0.15

yMargin = 10

colorText = 12 --white
background = 15 --dark gray

eventInd = 1
timeCountsInd = 1
function TIC()
		cls(background) 
  
  mouseX, mouseY, mousePressed = mouse()
  
  events = {
    {mousePressed, "mousePressed"}, 
    {btn(0), "btn(0)"}, 
    {mouseX > WIDTH/2, "mouseX > 120"},
    {key(48), "spacePressed"},
    {not(btn(3)), "not(btn(3))"} 
  }
  timeCounts = {
    {time(), 1000, "time()"},
    {countTicks, 60, "frames/ticks"}
  }
  
  --Update the current event
  if btn(2) and timerButtons.wait(100) then
    eventInd = math.max(1, eventInd - 1)
  elseif btn(3) and timerButtons.wait(100)  then
    eventInd = math.min(#events, eventInd + 1)
  end
  
  --Update the current time count
  if btnp(4, 0, 10) and timer.count() == 0 then
    timeCountsInd = timeCountsInd == 1 and 2 or 1
  end
  
  --Internal use
  timerButtons.event = not(btn(2) or btn(3))
  
  --Update the attributes of the timer
  timer.event = events[eventInd][1]
  timer.timeCount = timeCounts[timeCountsInd][1]
  
  --Show everthing: the event and the functions of the timer
  print(
    "<- Alter event ->",
    x, y,
    colorText
  ) 
  
  print(
    events[eventInd][2], 
    x, y+yMargin, 
    colorText,
    false,
    2
  )
  
  print(
    "Time in "..timeCounts[timeCountsInd][3]..": (Z to alter)", 
    x, y+yMargin*3, 
    colorText
  )
  printAlign(
    string.format("%.2f", timer.count()), 
    x2, y+yMargin*3, 
    "left",
    "botton",
    colorText,
    true
  )
    
  print(
    "Time >= 3 seconds: ", 
    x, y+yMargin*4, 
    colorText
  )
  printAlign(
    tostring(timer.wait(timeCounts[timeCountsInd][2]*3)), 
    x2, y+yMargin*4, 
    "left",
    "botton",
    colorText
  )
  
  print(
    "6 seconds >= Time >= 3 seconds: ", 
    x, y+yMargin*5, 
    colorText
  )
  printAlign(
    tostring(timer.wait(timeCounts[timeCountsInd][2]*3, timeCounts[timeCountsInd][2]*6)) , 
    x2, y+yMargin*5, 
    "left",
    "botton",
    colorText
  )
       
  print(
    "It is true every 1 second: ", 
    x, y+yMargin*6, 
    colorText
  )
  printAlign(
    tostring(timer.waitFreq(timeCounts[timeCountsInd][2]*1)), 
    x2, y+yMargin*6, 
    "left",
    "botton",
    colorText
  )
  
  print(
    "True every 1 second and Time >= 3: ", 
    x, y+yMargin*7, 
    colorText
  )
  printAlign(
    tostring(timer.waitFreq(timeCounts[timeCountsInd][2]*1) and timer.wait(timeCounts[timeCountsInd][2]*3)), 
    x2, y+yMargin*7, 
    "left",
    "botton",
    colorText
  )
  
  print(
    "Time < 4 seconds: ", 
    x, y+yMargin*8, 
    colorText
  )
  printAlign(
    tostring(not(timer.wait(timeCounts[timeCountsInd][2]*4))), 
    x2, y+yMargin*8, 
    "left",
    "botton",
    colorText
  )  
  
  --Increase the countTicks
  countTicks = countTicks + 1
end
