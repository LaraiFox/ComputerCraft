--- Description
--
-- @author Larai Fox ( http://pastebin.com/u/LaraiFox )
-- @module EndoflameFeeder.lua

--- @usage
local USAGE_TEXT = [[
EndoflameFeeder.lua <count>
    
count  - The number of endoflames near the turtle.
]]

local ITEM_BURN_TIME = {
	["minecraft:coal"] 			=  1600,
	["minecraft:coal_block"] 	= 16000,
	["minecraft:blaze_rod"] 	=  2400,
	["Railcraft:fuel.coke"] 	=  3200,
	["Railcraft:cube"] 			= 32000,
	["Botania:blazeBlock"] 		= 24000
}

local endoflameCount

local function parseProgramArgs(args)
	endoflameCount = tonumber(args[1], 10)
	
	assert(endoflameCount, "Error, invalid parameter. Usage: " .. USAGE_TEXT)
end

local function main(args)
	parseProgramArgs(args)

	turtle.select(1)
	
	while (turtle.getSelectedSlot() < 16) do
		for i = 1, 16 do
			if (turtle.getItemCount(i) > 0) then
				turtle.select(i)
				break
			end
		end
		
		while (turtle.getItemCount() > 0) do
			local itemName = turtle.getItemDetail()["name"]
			local sleepTime = ITEM_BURN_TIME[itemName] / 40
			
			assert(sleepTime, "Error, unrecognized item in slot #" .. turtle.getSelectedSlot() .. "!")
			
			turtle.drop(endoflameCount)
			
			sleep(sleepTime)
		end
	end
	
	print("Can not find any more items in inventory. Program finished.")
end

main({ ... })
