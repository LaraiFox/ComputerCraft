--- Description
--
-- @author Larai Fox ( http://pastebin.com/u/LaraiFox )
-- @license GNU General Public License v3.0
-- @module Install.lua

local CONFIG_FILENAME = ".laraifox.cfg"

--- @usage
local USAGE_TEXT = [[
Install.lua [-d <directory>]

-d      - Specifies a custom installation directory.
]]

local installDirectory = "/laraifox"

local function parseProgramArgs(args)
	local argTable = {
		["-d"] = function(i)
			installDirectory = args[i + 1]
			return 1
		end
	}
	
	for i = 1, #args do
		local argFunction = argTable[args[i]]
		
		assert(argFunction, "Error, invalid parameters. Usage: " .. USAGE_TEXT)
		
		i = i + argFunction()
	end
end

local function getFileList()
	local fileList = {
		[1] = {
			["dir"]  = "",
			["name"] = "Uninstall.lua",
			["url"]  = "HFhGh6aq"
		},
		[2] = {
			["dir"]  = "",
			["name"] = "Update.lua",
			["url"]  = "yPVyzA4K"
		},
		[3] = {
			["dir"]  = "",
			["name"] = "",
			["url"]  = ""
		}
	}
	
	return fileList
end

local function writeConfigFile()
	local config = fs.open(CONFIG_FILENAME, "w")
	
	config.writeLine("root:\"" .. installDirectory .. "\"")
	
	config.close()
end

local function main(args)
	parseProgramArgs(args)
	
	local fileList = getFileList()

	if (not fs.exists(INSTALL_FOLDER)) then
		fs.makeDir(INSTALL_FOLDER)
	end

	for _, file in pairs(fileList) do
		local fileDirectory = INSTALL_FOLDER .. file["dir"]
		if (not fs.exists(fileDirectory)) then
			fs.makeDir(fileDirectory)
		end

		local filePath = fileDirectory .. "/" .. file["name"]

		if (not fs.exists(filePath)) then
			shell.run("pastebin", "get", file["url"], filePath)
		else
			print("File already exists: \"" .. filePath .. "\"")
		end
	end
	
	writeConfigFile()

	local installerFilename = shell.getRunningProgram()
	fs.delete(installerFilename)
end

main({ ... })
