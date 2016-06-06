--- Description
--
-- @author Larai Fox ( http://pastebin.com/u/LaraiFox )
-- @license GNU General Public License v3.0
-- @module Install.lua

local LARAIFOX_DIRECTORY = "/laraifox"
local LIBRARY_DIRECTORY = "/lib"
local TURTLE_DIRECTORY = "/turtle"

local FILE_LIST = {
	[1] = {
		["dir"]  = {
			LARAIFOX_DIRECTORY
		},
		["name"] = "Uninstall.lua",
		["url"]  = ""
	},
	[2] = {
		["dir"]  = {
			LARAIFOX_DIRECTORY
		},
		["name"] = "Update.lua",
		["url"]  = ""
	},
}

local function main(args)
	if (not fs.exists(LARAIFOX_DIRECTORY)) then
		fs.makeDir(LARAIFOX_DIRECTORY)
	end
	
	for _, file in pairs(FILE_LIST) do
		local fileDirectory = ""
		for i = 1, #file["dir"] do
			fileDirectory = fileDirectory .. file["dir"][i]
			if (not fs.exists(fileDirectory)) then
				fs.makeDir(fileDirectory)
			end
		end
		
		local filePath = fileDirectory .. file["name"]
		
		if (not fs.exists(filePath)) then
			shell.run("pastebin", "get", file["url"], filePath)
		else
			print("File already exists: \"" .. filePath .. "\"")
		end
	end
	
	local installerFilename = shell.getRunningProgram()
	fs.delete(installerFilename)
end

main({ ... })
