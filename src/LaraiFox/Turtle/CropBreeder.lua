--- Description
--
-- @author Larai Fox ( http://pastebin.com/u/LaraiFox )
-- @license GNU General Public License v3.0
-- @module CropBreeder.lua

local SLOT_CROP_STICKS = 1
local SLOT_FUEL = 16

local function main(args)
	if (turtle.getFuelLevel() < 80) then
		turtle.select(SLOT_FUEL)
		turtle.refuel(1)
	end
	
	turtle.turnLeft()
	turtle.forward()
	
	turtle.select(SLOT_CROP_STICKS)
	turtle.placeDown()
	turtle.select(2)
	turtle.turnLeft()
	turtle.drop(1)
	
	turtle.turnLeft()
	turtle.forward()
	turtle.forward()
	
	turtle.select(SLOT_CROP_STICKS)
	turtle.placeDown()
	turtle.select(2)
	turtle.turnRight()
	turtle.drop(1)
	
	turtle.turnRight()
	turtle.forward()
	
	sleep(60)
	
	turtle.select(SLOT_CROP_STICKS)
	turtle.placeDown()
	turtle.placeDown()
	
	for i = 1, 16 do
		print("Breed cycle #" .. i)
		
		if (turtle.getFuelLevel() < 80) then
			turtle.select(SLOT_FUEL)
			turtle.refuel(1)
		end
		
		local blockData = turtle.inspect()
		while (blockData.name == "AgriCraft:crops") do
			sleep(1)
			
			blockData = turtle.inspect()
		end
		
		turtle.digDown()
		
		turtle.forward()
		
		turtle.digDown()
		turtle.select(SLOT_CROP_STICKS)
		turtle.placeDown()
		turtle.select(2)
		turtle.turnLeft()
		turtle.drop(1)
		
		turtle.turnLeft()
		turtle.forward()
		
		sleep(60)
	
		turtle.select(SLOT_CROP_STICKS)
		turtle.placeDown()
		turtle.placeDown()
		
		if (turtle.getFuelLevel() < 80) then
			turtle.select(SLOT_FUEL)
			turtle.refuel(1)
		end
		
		local blockData = turtle.inspect()
		while (blockData.name == "AgriCraft:crops") do
			sleep(1)
			
			blockData = turtle.inspect()
		end
		
		turtle.digDown()
		
		turtle.forward()
		
		turtle.digDown()
		turtle.select(SLOT_CROP_STICKS)
		turtle.placeDown()
		turtle.select(2)
		turtle.turnRight()
		turtle.drop(1)
		
		turtle.turnRight()
		turtle.forward()
		
		sleep(60)
	
		turtle.select(SLOT_CROP_STICKS)
		turtle.placeDown()
		turtle.placeDown()
	end
	
	local blockData = turtle.inspect()
	while (blockData.name == "AgriCraft:crops") do
		sleep(1)
		
		blockData = turtle.inspect()
	end
	
	turtle.digDown()
	
	turtle.turnRight()
end

main({ ... })