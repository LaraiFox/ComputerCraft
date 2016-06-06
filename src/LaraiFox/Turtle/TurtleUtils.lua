--- TurtleUtils is a lua file designed to add extra utility functions to ComputerCraft's Turtle API and to slightly modify some of the functions that already
-- exist. Some examples of functions that TurtleUtils adds include turning to face a specified direction, moving to a specified location, etc.
--
-- Turtle movement and rotation functions work the same way as before except you can now optionally specify how many times you want the function to repeat
-- rather than calling it multiple times. These functions now also automatically track the turtle's position and the direction it's facing.
--
-- @author Larai Fox ( http://pastebin.com/u/LaraiFox )
-- @module TurtleUtils.lua

-- Ensures the  is only included once
if (__TURTLE_UTILS_INCLUDED) then
	return
end

__TURTLE_UTILS_INCLUDED = true

-- EXTERNAL FILES TO BE INCLUDED --
local LIBRARY_DIRECTORY = "/laraifox/lib"
assert(fs.isDir(LIBRARY_DIRECTORY) and fs.exists(LIBRARY_DIRECTORY), "Unable to locate required library files!\n" ..
	"Please download and run the library installer from http://pastebin.com/kwKXPQTu to run this program.")

dofile(LIBRARY_DIRECTORY .. "/math/Vector2.lua")
dofile(LIBRARY_DIRECTORY .. "/math/Vector3.lua")

--- Global turtle constants
-- @section

--- Constant representing the forward action direction index.
-- @table turtle.ACT_FRONT
turtle.ACT_FRONT 		= 0
--- Constant representing the upward action direction index.
-- @table turtle.ACT_ABOVE
turtle.ACT_ABOVE 		= 1
--- Constant representing the downward action direction index.
-- @table turtle.ACT_BELOW
turtle.ACT_BELOW 		= 2

--- Constant representing the XYZ axis order.
-- @table turtle.AXIS_ORDER_XYZ
turtle.AXIS_ORDER_XYZ 	= 0
--- Constant representing the XZY axis order.
-- @table turtle.AXIS_ORDER_XZY
turtle.AXIS_ORDER_XZY 	= 1
--- Constant representing the YXZ axis order.
-- @table turtle.AXIS_ORDER_YXZ
turtle.AXIS_ORDER_YXZ 	= 2
--- Constant representing the YZX axis order.
-- @table turtle.AXIS_ORDER_YZX
turtle.AXIS_ORDER_YZX 	= 3
--- Constant representing the ZXY axis order.
-- @table turtle.AXIS_ORDER_ZXY
turtle.AXIS_ORDER_ZXY 	= 4
--- Constant representing the ZYX axis order.
-- @table turtle.AXIS_ORDER_ZYX
turtle.AXIS_ORDER_ZYX 	= 5

turtle.COMMAND_ATTACK	= 0
turtle.COMMAND_COMPARE	= 1
turtle.COMMAND_DETECT	= 2
turtle.COMMAND_DIG		= 3
turtle.COMMAND_DROP		= 4
turtle.COMMAND_INSPECT	= 5
turtle.COMMAND_PLACE	= 6
turtle.COMMAND_SUCK		= 7

--- Constant representing the positive z look direction index.
-- @table turtle.LOOK_POSITIVE_Z
turtle.LOOK_POSITIVE_Z 	= 0
--- Constant representing the positive x look direction index.
-- @table turtle.LOOK_POSITIVE_X
turtle.LOOK_POSITIVE_X 	= 1
--- Constant representing the negative z look direction index.
-- @table turtle.LOOK_NEGATIVE_Z
turtle.LOOK_NEGATIVE_Z 	= 2
--- Constant representing the negative x look direction index.
-- @table turtle.LOOK_NEGATIVE_X
turtle.LOOK_NEGATIVE_X 	= 3
--- A table of turtle look directions as Vector2 objects.
-- @table turtle.LOOK_DIRECTION
turtle.LOOK_DIRECTION 	= {
	[turtle.LOOK_POSITIVE_Z] = Vector2:new( 0,  1),
	[turtle.LOOK_POSITIVE_X] = Vector2:new( 1,  0),
	[turtle.LOOK_NEGATIVE_Z] = Vector2:new( 0, -1),
	[turtle.LOOK_NEGATIVE_X] = Vector2:new(-1,  0)
}

--- Index of the turtle.left function
-- @table turtle.TURN_LEFT
turtle.TURN_LEFT 		= 0
--- Index of the turtle.right function
-- @table turtle.TURN_RIGHT
turtle.TURN_RIGHT 		= 1
--- Index of the turtle.down function
-- @table turtle.MOVE_DOWN
turtle.MOVE_DOWN 		= 2
--- Index of the turtle.up function
-- @table turtle.MOVE_UP
turtle.MOVE_UP 			= 3
--- Index of the turtle.back function
-- @table turtle.MOVE_BACK
turtle.MOVE_BACK 		= 4
--- Index of the turtle.forward function
-- @table turtle.MOVE_FORWARD
turtle.MOVE_FORWARD 	= 5

--- Global turtle function tables
-- @section

--- A table of turtle attack commands.
-- @table turtle.ACTION_ATTACK
turtle.ACTION_ATTACK 	= {
	[turtle.ACT_FRONT] 	= turtle.attack,
	[turtle.ACT_ABOVE] 	= turtle.attackUp,
	[turtle.ACT_BELOW] 	= turtle.attackDown,
}
--- A table of turtle compare commands.
-- @table turtle.ACTION_COMPARE
turtle.ACTION_COMPARE 	= {
	[turtle.ACT_FRONT] 	= turtle.compare,
	[turtle.ACT_ABOVE] 	= turtle.compareUp,
	[turtle.ACT_BELOW] 	= turtle.compareDown,
}
--- A table of turtle detect commands.
-- @table turtle.ACTION_DETECT
turtle.ACTION_DETECT 	= {
	[turtle.ACT_FRONT] 	= turtle.detect,
	[turtle.ACT_ABOVE] 	= turtle.detectUp,
	[turtle.ACT_BELOW] 	= turtle.detectDown,
}
--- A table of turtle dig commands.
-- @table turtle.ACTION_DIG
turtle.ACTION_DIG 		= {
	[turtle.ACT_FRONT] 	= turtle.dig,
	[turtle.ACT_ABOVE] 	= turtle.digUp,
	[turtle.ACT_BELOW] 	= turtle.digDown,
}
--- A table of turtle drop commands.
-- @table turtle.ACTION_DROP
turtle.ACTION_DROP 		= {
	[turtle.ACT_FRONT] 	= turtle.drop,
	[turtle.ACT_ABOVE] 	= turtle.dropUp,
	[turtle.ACT_BELOW] 	= turtle.dropDown,
}
--- A table of turtle inspect commands.
-- @table turtle.ACTION_INSPECT
turtle.ACTION_INSPECT 	= {
	[turtle.ACT_FRONT] 	= turtle.inspect,
	[turtle.ACT_ABOVE] 	= turtle.inspectUp,
	[turtle.ACT_BELOW] 	= turtle.inspectDown,
}
--- A table of turtle place commands.
-- @table turtle.ACTION_PLACE
turtle.ACTION_PLACE 	= {
	[turtle.ACT_FRONT] 	= turtle.place,
	[turtle.ACT_ABOVE] 	= turtle.placeUp,
	[turtle.ACT_BELOW] 	= turtle.placeDown,
}
--- A table of turtle suck commands.
-- @table turtle.ACTION_SUCK
turtle.ACTION_SUCK 		= {
	[turtle.ACT_FRONT] 	= turtle.suck,
	[turtle.ACT_ABOVE] 	= turtle.suckUp,
	[turtle.ACT_BELOW] 	= turtle.suckDown,
}

--- A table of turtle command tables.
-- @table turtle.COMMAND_LIST
turtle.COMMAND_LIST = {
	[turtle.COMMAND_ATTACK] 	= turtle.ACTION_ATTACK,
	[turtle.COMMAND_COMPARE] 	= turtle.ACTION_COMPARE,
	[turtle.COMMAND_DETECT] 	= turtle.ACTION_DETECT,
	[turtle.COMMAND_DIG] 		= turtle.ACTION_DIG,
	[turtle.COMMAND_DROP] 		= turtle.ACTION_DROP,
	[turtle.COMMAND_INSPECT] 	= turtle.ACTION_INSPECT,
	[turtle.COMMAND_PLACE] 		= turtle.ACTION_PLACE,
	[turtle.COMMAND_SUCK] 		= turtle.ACTION_SUCK
}

--- A table of turtle movement commands.
-- @table turtle.MOVE_COMMAND
turtle.MOVE_COMMAND	= {
	[turtle.TURN_LEFT] 		= turtle.left,
	[turtle.TURN_RIGHT] 	= turtle.right,
	[turtle.MOVE_DOWN] 		= turtle.down,
	[turtle.MOVE_UP]		= turtle.up,
	[turtle.MOVE_BACK] 		= turtle.back,
	[turtle.MOVE_FORWARD] 	= turtle.forward
}

--- Local turtle constants
-- @section

--- Maximum number of stored positions allowed
-- @table TURTLE_MAX_STORED_LOCATIONS
local TURTLE_MAX_STORED_LOCATIONS = 32

--- Local turtle variables
-- @section

--- A table containing stored Vector3 positions
-- @table turtle_StoredLocations
local turtle_StoredLocations = { }
for i = 1, TURTLE_MAX_STORED_LOCATIONS do
	turtle_StoredLocations[i] = {
		pos = Vector3:ZERO(),
		dir = turtle.LOOK_POSITIVE_Z
	}
end

--- Vector3 variable tracking the turtle's current position relative to  its position on first running TurtleUtils
-- @table turtle_Position
local turtle_Position = Vector3:new(0, 0, 0)
--- Integer variable tracking the turtle's current look direction relative to its look direction on first running TurtleUtils
-- @table turtle_Direction
local turtle_Direction = turtle.POSITIVE_Z

local turtle_DigOnObstruction = false
local turtle_ObstructedSleepTime = 1

--- Local copies of default turtle functions
-- @section

--- Default turtle.turnLeft function. Turns the turtle left 90 degrees.
-- @function turtle_Left
local turtle_Left = turtle.turnLeft
--- Default turtle.turnRight function. Turns the turtle right 90 degrees.
-- @function turnRight
local turtle_Right = turtle.turnRight
--- Default turtle.down function. Moves the turtle down one block.
-- @function turtle_Down
local turtle_Down = turtle.down
--- Default turtle.up function. Moves the turtle up one block.
-- @function turtle_Up
local turtle_Up = turtle.up
--- Default turtle.back function. Moves the turtle backwards one block.
-- @function turtle_Back
local turtle_Back = turtle.back
--- Default turtle.forward function. Moves the turtle forwards one block.
-- @function turtle_Forward
local turtle_Forward = turtle.forward

--- Global overriden turtle functions
-- @section

--- Turns the turtle 90 degrees to the left and decrements @{turtle_Direction} the number of times specified.
-- If count is nil then count defaults to 1. If count is negative the turtle will turn right instead.
-- @function turtle.turnLeft
-- @param count number of times the turtle will turn left
turtle.turnLeft = function(count)
	if (count == nil) then count = 1 end
	if (count < 0) then return turtle.right(-count) end

	for i = 1, count do
		turtle_Left()
		turtle_Direction = (turtle_Direction - 1) % 4
	end
end

--- Turns the turtle 90 degrees to the right and increments @{turtle_Direction} the number of times specified.
-- If count is nil then count defaults to 1. If count is negative the turtle will turn left instead.
-- @function turtle.turnRight
-- @param count number of times the turtle will turn right
turtle.turnRight = function(count)
	if (count == nil) then count = 1 end
	if (count < 0) then return turtle.left(-count) end

	for i = 1, count do
		turtle_Right()
		turtle_Direction = (turtle_Direction + 1) % 4
	end
end

--- Moves the turtle down by one block a specified number of times and decrements @{turtle_Position}'s y value.
-- If count is nil then count defaults to 1. If count is negative the turtle will move up instead.
-- @function turtle.down
-- @param count number of times the turtle will move down
turtle.down = function(count)
	if (count == nil) then count = 1 end
	if (count < 0) then return turtle.up(-count) end
	if (turtle.getFuelLevel() < count) then return false end

	for i = 1, count do
		while (not turtle_Down()) do
			if (turtle.detectDown() and turtle_DigOnObstruction) then
				turtle.digDown()
			else
				sleep(turtle_ObstructedSleepTime)
			end
		end
		turtle_Position(0, -1, 0)
	end
	
	return true
end

--- Moves the turtle up by one block a specified number of times and increments @{turtle_Position}'s y value.
-- If count is nil then count defaults to 1. If count is negative the turtle will move down instead.
-- @function turtle.up
-- @param count number of times the turtle will move up
turtle.up = function(count)
	if (count == nil) then count = 1 end
	if (count < 0) then return turtle.down(-count) end
	if (turtle.getFuelLevel() < count) then return false end

	for i = 1, count do
		while (not turtle_Up()) do
			if (turtle.detectUp() and turtle_DigOnObstruction) then
				turtle.digUp()
			else
				sleep(turtle_ObstructedSleepTime)
			end
		end
		turtle_Position(0, 1, 0)
	end
	
	return true
end

--- Moves the turtle backwards by one block a specified number of times and changes @{turtle_Position} based on the current @{turtle_Direction}.
-- If count is nil then count defaults to 1. If count is negative the turtle will move forwards instead.
-- @function turtle.backwards
-- @param count number of times the turtle will move backwards
turtle.back = function(count)
	if (count == nil) then count = 1 end
	if (count < 0) then return turtle.forward(-count) end
	if (turtle.getFuelLevel() < count) then return false end

	local lookDirection = Vector2:negative(turtle.LOOK_DIRECTION[turtle_Direction])
	for i = 1, count do
		while (not turtle_Back()) do
			sleep(turtle_ObstructedSleepTime)
		end
		turtle_Position:add(lookDirection.x, 0, lookDirection.z)
	end
	
	return true
end


--- Moves the turtle forwards by one block a specified number of times and changes @{turtle_Position} based on the current @{turtle_Direction}.
-- If count is nil then count defaults to 1. If count is negative the turtle will move backwards instead.
-- @function turtle.forwards
-- @param count number of times the turtle will move forwards
turtle.forward = function(count)
	if (count == nil) then count = 1 end
	if (count < 0) then return turtle.back(-count) end
	if (turtle.getFuelLevel() < count) then return false end

	local lookDirection = turtle.LOOK_DIRECTION[turtle_Direction]
	for i = 1, count do
		while (not turtle_Forward()) do
			if (turtle.detect() and turtle_DigOnObstruction) then
				turtle.dig()
			else
				sleep(turtle_ObstructedSleepTime)
			end
		end
		turtle_Position:add(lookDirection.x, 0, lookDirection.z)
	end
	
	return true
end

--- Global turtle functions
-- @section

--- Adds an alternatively named function identical to @{turtle.turnLeft}
-- @function turtle.left
-- @param count number of times the turtle will turn left
-- @see turtle.turnLeft
turtle.left = turtle.turnLeft

--- Adds an alternatively named function identical to @{turtle.turnRight}
-- @function turtle.right
-- @param count number of times the turtle will turn right
-- @see turtle.turnRight
turtle.right = turtle.turnRight

--- Attempts to find a path to the specified location using the map parameter as a guide.
-- @param location the destination coordinates
-- @param map a map of the area. The map uses 0 to represent empty blocks and 1 for solid blocks.
-- @param origin the offset of the map from the turtle's starting location.
-- @return a table of turtle move commands
function turtle.pathfind(location, map, origin)
--- @todo write function body
end

--- Moves the turtle to the specified location parameter in straight lines along the axes in a certain order. When the turtle finishes moving it faces the
-- direction parameter.
-- @function turtle.moveTowards
-- @param location the destination coordinates
-- @param direction the final look direction after moving
-- @param order the order of axes the turtle will move along
function turtle.moveTowards(location, direction, order)
--- @todo write function body
end

--- Turns the turtle to face the direction parameter with as few calls to the turn functions as posible. If the direction spectified is not between 0 and
-- 3 inclusive the program exits and prints an error. If direction is nil then the turtle will not turn.
-- @function turtle.turnTowards
-- @param direction the direction the turtle should face
function turtle.turnTowards(direction)
	if (direction == nil) then return end
	
	assert(direction >= 0 and direction < 4, "Error, invalid direction specified for turtle.turnTowards(): '" .. direction .. "'")

	local delta = (direction - turtle_Direction) % 4
	if (delta == 0) then
		return
	elseif (delta == 1) then
		turtle.right(1)
	elseif (delta == 2) then
		turtle.right(2)
	elseif (delta == 3) then
		turtle.left(1)
	end
end

--- Moves the turtle back to its starting location in straight lines along the axes in a certain order. When the turtle finishes moving it faces the
-- direction parameter.
-- @function turtle.returnToStart
-- @param direction the final look direction after moving
-- @param order the order of axes the turtle will move along
function turtle.returnToStart(lookDir, order)
	turtle.moveTowards(Vector3:ZERO(), lookDir, order)
end

--- Stores the turtle's current position and look direction at the
-- specified index.
-- @function turtle.storeCurrentLocation
-- @param i the index at which to store the location
function turtle.storeCurrentLocation(i)
	assert(i > 0 and i <= TURTLE_MAX_STORED_LOCATIONS, "Error, location storage index must be between 1 and " .. TURTLE_MAX_STORED_LOCATIONS .. " inclusive.")

	turtle_StoredLocations[i]["pos"] = turtle_Position
	turtle_StoredLocations[i]["dir"] = turtle_Direction
end

--- Gets the position and look direction stored at the specified index.
-- @function turtle.getStoredLocation
-- @param i the index from which to get the location
-- @return the stored position
-- @return the stored look direction
function turtle.getStoredLocation(i)
	assert(i > 0 and i <= TURTLE_MAX_STORED_LOCATIONS, "Error, location storage index must be between 1 and " .. TURTLE_MAX_STORED_LOCATIONS .. " inclusive.")

	return turtle_StoredLocations[i]["pos"], turtle_StoredLocations[i]["dir"]
end

--- Gets the maximum number of stored locations available.
-- @function turtle.getMaxStoredLocations
-- @return the maximum number of stored locations available
function turtle.getMaxStoredLocations()
	return TURTLE_MAX_STORED_LOCATIONS
end

function turtle.shouldDigOnObsruction()
	return turtle_DigOnObstruction
end

function turtle.setDigOnObsruction(value)
	turtle_DigOnObstruction = value
end
