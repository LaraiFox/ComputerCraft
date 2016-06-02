--- Description
--
-- @author Larai Fox ( http://pastebin.com/u/LaraiFox )
-- @module AreaMine.lua

local args = { ... }

local TURTLE_DIRECTORY = "/LaraiFox/Turtle"
assert(fs.isDir(TURTLE_DIRECTORY) and fs.exists(TURTLE_DIRECTORY), "Unable to locate required turtle files!\n" .. "Please download and run the turtle installer from http://pastebin.com/0anzz3sC to run this program.")

dofile(TURTLE_DIRECTORY .. "/TurtleUtils.lua")

--- @usage
local usage = [[
AreaMine <width> <height> <length> [-t]
    
width   - The width of the area. Negative widths result in the turtle going right.
height  - The height of the area. Negative heights result in the turtle going down.
length  - The length of the area. Can not be negative.
-t      - Causes the turtle to place torches as it mines.
]]

local function main()
	
end

main()
