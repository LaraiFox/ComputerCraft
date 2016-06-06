--- Description
--
-- @author Larai Fox ( http://pastebin.com/u/LaraiFox )
-- @license GNU General Public License v3.0
-- @module AreaMine.lua

local TURTLE_DIRECTORY = "/LaraiFox/Turtle"
assert(fs.isDir(TURTLE_DIRECTORY) and fs.exists(TURTLE_DIRECTORY), "Unable to locate required turtle files!\n" .. 
	"Please download and run the turtle installer from http://pastebin.com/0anzz3sC to run this program.")

dofile(TURTLE_DIRECTORY .. "/TurtleUtils.lua")

--- @usage
local USAGE_TEXT = [[
AreaMine.lua <width> <height> <length> [-t]
    
width   - The width of the area. Negative widths result in the turtle going right.
height  - The height of the area. Negative heights result in the turtle going down.
length  - The length of the area. Can not be negative.
-t      - Causes the turtle to place torches as it mines.
]]

local TURTLE_ERROR_SLEEP_TIME = 1

local SLOT_NAME_FUEL      = "fuel"
local SLOT_NAME_INVENTORY = "inventory"
local SLOT_NAME_TORCHES   = "torches"

local CHEST_SIDE_FUEL    = { 
	["dir"] = nil, 
	["act"] = turtle.ACT_ABOVE
}
local CHEST_SIDE_STORAGE = { 
	["dir"] = turtle.LOOK_NEGATIVE_Z, 
	["act"] = turtle.ACT_FRONT 
}
local CHEST_SIDE_TORCHES = { 
	["dir"] = nil, 
	["act"] = turtle.ACT_BELOW
}

local width, height, length
local placeTorches = false

--- Checks to make sure a block with an inventory exists in the specified direction. If no block is found with matching criteria it prints an error message
-- and waits for a block to be placed with matching criteria.
local function checkForInventory(direction)
	local success, blockData = turtle.ACTION_INSPECT[direction]()
	if (not success or not string.find(blockData.name, "chest")) then
		print("Error, unable to find inventory to store collected items!\n" .. 
			"Place an inventory in front of the turtle to resume program.")
			
		while (not success or not string.find(blockData.name, "chest")) do
			sleep(TURTLE_ERROR_SLEEP_TIME)
			success, blockData = turtle.ACTION_INSPECT[direction]()
		end
	end
end

local function storeInventory()
	turtle.turnToFace(CHEST_SIDE_STORAGE["dir"])
	
	checkForInventory(CHEST_SIDE_STORAGE["act"])
		
	for i = 1, turtle.ITEM_SLOT_COUNT do
		if (turtle.getItemSlotName(i) == SLOT_NAME_INVENTORY and turtle.getItemCount(i) > 0) then
			turtle.select(i)
			
			turtle.ACTION_DROP[CHEST_SIDE_STORAGE["act"]]()
		end
	end
end

local function resupplyItemSlotType(chestSide, slotName, minItemCount)
	if (not minItemCount) then minItemCount = 64 end
	
	turtle.turnToFace(chestSide["dir"])
	
	checkForInventory(chestSide["act"])
		
	for i = 1, turtle.ITEM_SLOT_COUNT do
		if (turtle.getItemSlotName(i) == slotName and turtle.getItemCount(i) < minItemCount) then
			turtle.select(i)
			
			turtle.ACTION_SUCK[chestSide["act"]](minItemCount - turtle.getItemCount(i))
		end
	end

--		Supposedly not requred as of ComputerCraft v1.6 due to the ability to choose how many items to suck.
--	for i = 1, turtle.ITEM_SLOT_COUNT do
--		if (turtle.getItemSlotName(i) ~= slotName and turtle.getItemCount(i) > 0) then
--			turtle.select(i)
--			
--			turtle.ACTION_DROP[chestSide["act"]]()
--		end
--	end
end

local function onReturnToStart()
	storeInventory()
	
	resupplyItemSlotType(CHEST_SIDE_FUEL, SLOT_NAME_FUEL, 64)
	
	if (placeTorches) then
		resupplyItemSlotType(CHEST_SIDE_TORCHES, SLOT_NAME_TORCHES, 64)
	end
end

local function parseProgramArgs(args)
	local argTable = {
		["-t"] = function()
			placeTorches = true
		end
	}

	width  = tonumber(args[1], 10)
	height = tonumber(args[2], 10)
	length = tonumber(args[3], 10)
	
	assert(width and height and length, "Error, invalid parameters. Usage: " .. USAGE_TEXT)
	
	for i = 4, table.getn(args) do
		local argFunction = argTable[args[i]]
		
		assert(argFunction, "Error, invalid parameters. Usage: " .. USAGE_TEXT)
		
		argFunction()
	end
end

local function initialize()
	term.write("Initializing program... ")

	local inventorySlotCount = (placeTorches and 14 or 15)

	for i = 1, inventorySlotCount do
		turtle.setItemSlotName(i, SLOT_NAME_INVENTORY)
	end
	
	if (placeTorches) then
		turtle.setItemSlotName(15, SLOT_NAME_TORCHES)
	end
	
	turtle.setItemSlotName(16, SLOT_NAME_FUEL)
	
	print("Ready!")
	print("The total area to be mined is " .. width .. "x" .. height .. length .. "x" .. " (" .. (width * height * length) .. " blocks) and torches will be placed at regular intervals.")
	print("If the size is correct press Enter to continue, if not type 'Q' and press Enter to exit...")
		
	local response = read()
	if (response ~= nil and string.lower(response) == "q") then
		return false
	end
	
	return true
end

local function doMining()

end

local function main(args)
	parseProgramArgs(args)

	if (not initialize()) then
		return
	end
	
	
end

main({ ... })
