--[[
this is the lua file i coded to read all contents from the main.tic file
then write it to the main.txt file instead of manually writing it everytime


STILL IN DEVELOPMENT!!!
]]

file = io.input("main.tic")
main = io.input("main.txt")
main:write(file:read)
file:close()