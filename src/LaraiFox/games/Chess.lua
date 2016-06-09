local STARTING_BOARD = {
	{ " r ", " n ", " b ", " q ", " k ", " b ", " n ", " r " },
	{ " p ", " p ", " p ", " p ", " p ", " p ", " p ", " p " },
	{ "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   " },
	{ "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   " },
	{ "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   " },
	{ "   ", "   ", "   ", "   ", "   ", "   ", "   ", "   " },
	{ " P ", " P ", " P ", " P ", " P ", " P ", " P ", " P " },
	{ " R ", " N ", " B ", " Q ", " K ", " B ", " N ", " R " }
}

local pieceMovement = {
	[" P "] = {
		{ ["x"] = 0, ["y"] = 1 },
		{ ["x"] = 0, ["y"] = 2 }
	},
	[" R "] = {
		{ ["x"] = 0, ["y"] = 1 },
		{ ["x"] = 0, ["y"] = 2 },
		{ ["x"] = 0, ["y"] = 3 },
		{ ["x"] = 0, ["y"] = 4 },
		{ ["x"] = 0, ["y"] = 5 },
		{ ["x"] = 0, ["y"] = 6 },
		{ ["x"] = 0, ["y"] = 7 },
		
		{ ["x"] = 1, ["y"] = 0 },
		{ ["x"] = 2, ["y"] = 0 },
		{ ["x"] = 3, ["y"] = 0 },
		{ ["x"] = 4, ["y"] = 0 },
		{ ["x"] = 5, ["y"] = 0 },
		{ ["x"] = 6, ["y"] = 0 },
		{ ["x"] = 7, ["y"] = 0 },
		
		{ ["x"] = 0, ["y"] = -1 },
		{ ["x"] = 0, ["y"] = -2 },
		{ ["x"] = 0, ["y"] = -3 },
		{ ["x"] = 0, ["y"] = -4 },
		{ ["x"] = 0, ["y"] = -5 },
		{ ["x"] = 0, ["y"] = -6 },
		{ ["x"] = 0, ["y"] = -7 },
		
		{ ["x"] = -1, ["y"] = 0 },
		{ ["x"] = -2, ["y"] = 0 },
		{ ["x"] = -3, ["y"] = 0 },
		{ ["x"] = -4, ["y"] = 0 },
		{ ["x"] = -5, ["y"] = 0 },
		{ ["x"] = -6, ["y"] = 0 },
		{ ["x"] = -7, ["y"] = 0 }
	},
	[" N "] = {
		{ ["x"] = 1, ["y"] = 2 },
		{ ["x"] = 2, ["y"] = 1 },
		{ ["x"] = 2, ["y"] = -1 },
		{ ["x"] = 1, ["y"] = -2 },
		{ ["x"] = -1, ["y"] = -2 },
		{ ["x"] = -2, ["y"] = -1 },
		{ ["x"] = -2, ["y"] = 1 },
		{ ["x"] = -1, ["y"] = 2 },
	},
	[" B "] = {
		{ ["x"] = 1, ["y"] = 1 },
		{ ["x"] = 2, ["y"] = 2 },
		{ ["x"] = 3, ["y"] = 3 },
		{ ["x"] = 4, ["y"] = 4 },
		{ ["x"] = 5, ["y"] = 5 },
		{ ["x"] = 6, ["y"] = 6 },
		{ ["x"] = 7, ["y"] = 7 },
		
		{ ["x"] = 1, ["y"] = -1 },
		{ ["x"] = 2, ["y"] = -2 },
		{ ["x"] = 3, ["y"] = -3 },
		{ ["x"] = 4, ["y"] = -4 },
		{ ["x"] = 5, ["y"] = -5 },
		{ ["x"] = 6, ["y"] = -6 },
		{ ["x"] = 7, ["y"] = -7 },
		
		{ ["x"] = -1, ["y"] = -1 },
		{ ["x"] = -2, ["y"] = -2 },
		{ ["x"] = -3, ["y"] = -3 },
		{ ["x"] = -4, ["y"] = -4 },
		{ ["x"] = -5, ["y"] = -5 },
		{ ["x"] = -6, ["y"] = -6 },
		{ ["x"] = -7, ["y"] = -7 },
		
		{ ["x"] = -1, ["y"] = 1 },
		{ ["x"] = -2, ["y"] = 2 },
		{ ["x"] = -3, ["y"] = 3 },
		{ ["x"] = -4, ["y"] = 4 },
		{ ["x"] = -5, ["y"] = 5 },
		{ ["x"] = -6, ["y"] = 6 },
		{ ["x"] = -7, ["y"] = 7 }
	},
	[" Q "] = {
		{ ["x"] = 0, ["y"] = 1 },
		{ ["x"] = 0, ["y"] = 2 },
		{ ["x"] = 0, ["y"] = 3 },
		{ ["x"] = 0, ["y"] = 4 },
		{ ["x"] = 0, ["y"] = 5 },
		{ ["x"] = 0, ["y"] = 6 },
		{ ["x"] = 0, ["y"] = 7 },
		
		{ ["x"] = 1, ["y"] = 1 },
		{ ["x"] = 2, ["y"] = 2 },
		{ ["x"] = 3, ["y"] = 3 },
		{ ["x"] = 4, ["y"] = 4 },
		{ ["x"] = 5, ["y"] = 5 },
		{ ["x"] = 6, ["y"] = 6 },
		{ ["x"] = 7, ["y"] = 7 },
		
		{ ["x"] = 1, ["y"] = 0 },
		{ ["x"] = 2, ["y"] = 0 },
		{ ["x"] = 3, ["y"] = 0 },
		{ ["x"] = 4, ["y"] = 0 },
		{ ["x"] = 5, ["y"] = 0 },
		{ ["x"] = 6, ["y"] = 0 },
		{ ["x"] = 7, ["y"] = 0 },
		
		{ ["x"] = 1, ["y"] = -1 },
		{ ["x"] = 2, ["y"] = -2 },
		{ ["x"] = 3, ["y"] = -3 },
		{ ["x"] = 4, ["y"] = -4 },
		{ ["x"] = 5, ["y"] = -5 },
		{ ["x"] = 6, ["y"] = -6 },
		{ ["x"] = 7, ["y"] = -7 },
		
		{ ["x"] = 0, ["y"] = -1 },
		{ ["x"] = 0, ["y"] = -2 },
		{ ["x"] = 0, ["y"] = -3 },
		{ ["x"] = 0, ["y"] = -4 },
		{ ["x"] = 0, ["y"] = -5 },
		{ ["x"] = 0, ["y"] = -6 },
		{ ["x"] = 0, ["y"] = -7 },
		
		{ ["x"] = -1, ["y"] = -1 },
		{ ["x"] = -2, ["y"] = -2 },
		{ ["x"] = -3, ["y"] = -3 },
		{ ["x"] = -4, ["y"] = -4 },
		{ ["x"] = -5, ["y"] = -5 },
		{ ["x"] = -6, ["y"] = -6 },
		{ ["x"] = -7, ["y"] = -7 },
		
		{ ["x"] = -1, ["y"] = 0 },
		{ ["x"] = -2, ["y"] = 0 },
		{ ["x"] = -3, ["y"] = 0 },
		{ ["x"] = -4, ["y"] = 0 },
		{ ["x"] = -5, ["y"] = 0 },
		{ ["x"] = -6, ["y"] = 0 },
		{ ["x"] = -7, ["y"] = 0 },
		
		{ ["x"] = -1, ["y"] = 1 },
		{ ["x"] = -2, ["y"] = 2 },
		{ ["x"] = -3, ["y"] = 3 },
		{ ["x"] = -4, ["y"] = 4 },
		{ ["x"] = -5, ["y"] = 5 },
		{ ["x"] = -6, ["y"] = 6 },
		{ ["x"] = -7, ["y"] = 7 }
	},
	[" K "] = {
		{ ["x"] = 0, ["y"] = 1 },
		{ ["x"] = 1, ["y"] = 1 },
		{ ["x"] = 1, ["y"] = 0 },
		{ ["x"] = 1, ["y"] = -1 },
		{ ["x"] = 0, ["y"] = -1 },
		{ ["x"] = -1, ["y"] = -1 },
		{ ["x"] = -1, ["y"] = 0 },
		{ ["x"] = -1, ["y"] = 1 },
	},
}

local board = STARTING_BOARD

local boardSizePixels = {
	["x"] = 65, ["y"] = 17
}

local currentPlayer = 0

local function printBoard()
	print()
	print(" > Player #" .. (currentPlayer + 1) .. ", it's your turn.")
	
	for i = 1, 8 do
		print("+---+---+---+---+---+---+---+---+")
		
		for j = 1, 8 do
			term.write("|" .. board[i][j])
		end
		
		print("|")
	end
	
	print("+---+---+---+---+---+---+---+---+")
end

local function checkValidMove(x1, y1, x2, y2)
	if (currentPlayer == 0 and string.lower(board[y1][x1]) == board[y1][x1]) then 
		return false
	elseif (currentPlayer == 1 and string.upper(board[y1][x1]) == board[y1][x1]) then 
		return false
	end

	local pieceMoveTable = pieceMovement[string.upper(board[y1][x1])]
	
	local dx = x2 - x1
	local dy = y2 - y1
	
	if (currentPlayer == 0) then
		dy = -dy
	end
	
	for i = 1, #pieceMoveTable do
		if (pieceMoveTable[i]["x"] == dx and pieceMoveTable[i]["y"] == dy) then
			return true
		end
	end
	
	return false
end

local function playerInput()
	local selectedSpace = {
		["x"] = 0,
		["y"] = 0
	}
	
	while (true) do
		local event, button, mouseX, mouseY = os.pullEvent("mouse_click")
		
		if (selectedSpace["x"] ~= 0 and selectedSpace["y"] ~= 0) then
			if (mouseX < boardSizePixels["x"] and mouseY < boardSizePixels["y"] + 1 and (mouseX - 1) % 4 > 0 and (mouseY - 2) % 2 == 1) then
				local x = math.ceil((mouseX - 0) / 4) 
				local y = math.ceil((mouseY - 1) / 2)
			
				if (x == selectedSpace["x"] and y == selectedSpace["y"]) then
					selectedSpace["x"] = 0
					selectedSpace["y"] = 0
		
					printBoard()
				else
					if (checkValidMove(selectedSpace["x"], selectedSpace["y"], x, y)) then
						board[y][x] = board[selectedSpace["y"]][selectedSpace["x"]]
						board[selectedSpace["y"]][selectedSpace["x"]] = "   "
						break
					else
						selectedSpace["x"] = 0
						selectedSpace["y"] = 0
			
						print(" > Player #" .. (currentPlayer + 1) .. ", invalid move!")
						printBoard()
					end
				end
			end
		elseif (mouseX < boardSizePixels["x"] and mouseY < boardSizePixels["y"] + 1 and (mouseX - 1) % 4 > 0 and (mouseY - 2) % 2 == 1) then
			printBoard()
			
			term.write("Player #" .. (currentPlayer + 1) .. " clicked on ")
			
			local x = math.ceil((mouseX - 0) / 4) 
			local y = math.ceil((mouseY - 1) / 2)
			
			if (board[y][x] == "   ") then
				term.write("a blank square")
			else
				selectedSpace["x"] = x
				selectedSpace["y"] = y
			
				term.write("'" .. board[y][x] .. "'")
			end
			
			term.write(" @[ " .. x .. ", " .. y .. " ]")
		end
	end
end

local function main(args)
	print("")
	printBoard()

	while (true) do
		playerInput()
		
		currentPlayer = (currentPlayer + 1) % 2
		
		printBoard()
	end
end

main({ ... })