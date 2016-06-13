local Piece = { }
function Piece:new()
	local class = { }
	
	class.moved = nil
	class.pieceName = nil
	class.playerIndex = nil
	
	function class:isValidMove(x1, y1, x2, y2, board)
		local destPiece = board[x2][y2]
		
		if ((not destPiece) or (self.playerIndex ~= destPiece.playerIndex)) then
			return self:areSquaresValid(x1, y1, x2, y2, board)
		end
		
		return false;
	end
	
	function class:areSquaresValid(x1, y1, x2, y2, board)
		return true
	end
	
	function class:getPieceName()
		if (self.playerIndex == 0) then
			return string.upper(self.pieceName)
		else
			return string.lower(self.pieceName)
		end
	end
	
	return class
end

local Pawn = { }
function Pawn:new(playerIndex, moved)
	local class = Piece:new()
	
	class.moved = moved or false
	class.pieceName = "P"
	class.playerIndex = playerIndex
	
	function class:areSquaresValid(x1, y1, x2, y2, board)
		local destPiece = board[x2][y2]
		if (not destPiece) then
			if (x2 == x1) then
				if (self.playerIndex == 0) then
					if (y2 == y1 + 1 or (y2 == y1 + 2 and not self.moved and not board[x1][y1 + 1])) then
						return true
					end
				else
					if (y2 == y1 - 1 or (y2 == y1 - 2 and not self.moved and not board[x1][y1 - 1])) then
						return true
					end
				end
			end
		else
			if (x2 == x1 + 1 or x2 == x1 - 1) then
				if (self.playerIndex == 0) then
					if (y2 == y1 + 1) then
						return true
					end
				else
					if (y2 == y1 - 1) then
						return true
					end
				end
			end
		end
		
		return false
	end
	
	return class
end

local Rook = { }
function Rook:new(playerIndex, moved)
	local class = Piece:new()
	
	class.moved = moved or false
	class.pieceName = "R"
	class.playerIndex = playerIndex
	
	function class:areSquaresValid(x1, y1, x2, y2, board)
		if (y2 == y1) then
			local step = (x2 - x1 > 0) and 1 or -1
			local column = x1 + step
			while (column ~= x2) do
				if (board[column][y1]) then
					return false
				end
				
				column = column + step
			end
			
			return true
		elseif (x2 == x1) then
			local step = (y2 - y1 > 0) and 1 or -1
			local row = y1 + step
			while (row ~= y2) do
				if (board[x1][row]) then
					return false
				end
				
				row = row + step
			end
			
			return true
		end
	end
	
	return class
end

local Knight = { }
function Knight:new(playerIndex, moved)
	local class = Piece:new()
	
	class.moved = moved or false
	class.pieceName = "N"
	class.playerIndex = playerIndex
	
	function class:areSquaresValid(x1, y1, x2, y2, board)
		if ((math.abs(x2 - x1) == 1 and math.abs(y2 - y1) == 2) or
			(math.abs(x2 - x1) == 2 and math.abs(y2 - y1) == 1)) then
			return true
		end
		
		return false
	end
	
	return class
end

local Bishop = { }
function Bishop:new(playerIndex, moved)
	local class = Piece:new()
	
	class.moved = moved or false
	class.pieceName = "B"
	class.playerIndex = playerIndex
	
	function class:areSquaresValid(x1, y1, x2, y2, board)
		if (math.abs(x2 - x1) == math.abs(y2 - y1)) then
			local rowStep = (y2 - y1 > 0) and 1 or -1
			local columnStep = (x2 - x1 > 0) and 1 or -1
			local row = y1 + rowStep
			local column = x1 + columnStep
			while (row ~= y2 and column ~= x2) do
				if (board[column][row]) then
					return false
				end
				
				row = row + rowStep
				column = column + columnStep
			end
			
			return true
		end
		
		return false
	end
	
	return class
end

local Queen = { }
function Queen:new(playerIndex, moved)
	local class = Piece:new()
	
	class.moved = moved or false
	class.pieceName = "Q"
	class.playerIndex = playerIndex
	
	function class:areSquaresValid(x1, y1, x2, y2, board)
		if (y2 == y1) then
			local step = (x2 - x1 > 0) and 1 or -1
			local column = x1 + step
			while (column ~= x2) do
				if (board[column][y1]) then
					return false
				end
				
				column = column + step
			end
			
			return true
		elseif (x2 == x1) then
			local step = (y2 - y1 > 0) and 1 or -1
			local row = y1 + step
			while (row ~= y2) do
				if (board[x1][row]) then
					return false
				end
				
				row = row + step
			end
			
			return true
		elseif (math.abs(x2 - x1) == math.abs(y2 - y1)) then
			local rowStep = (y2 - y1 > 0) and 1 or -1
			local columnStep = (x2 - x1 > 0) and 1 or -1
			local row = y1 + rowStep
			local column = x1 + columnStep
			while (row ~= y2 and column ~= x2) do
				if (board[column][row]) then
					return false
				end
				
				row = row + rowStep
				column = column + columnStep
			end
			
			return true
		end
		
		return false
	end
	
	return class
end

local King = { }
function King:new(playerIndex, moved)
	local class = Piece:new()
	
	class.moved = moved or false
	class.pieceName = "K"
	class.playerIndex = playerIndex
	
	function class:areSquaresValid(x1, y1, x2, y2, board)
		if ((math.abs(x2 - x1) == 1 or math.abs(x2 - x1) == 0) and
			(math.abs(y2 - y1) == 1 or math.abs(y2 - y1) == 0)) then
			return true
		end
	
		return false
	end
	
	return class
end

local board = {
	{ }, { }, { }, { }, { }, { }, { }, { }
}

local boardSizePixels = {
	["x"] = 65, ["y"] = 17
}

local currentPlayer = 0

local function setupBoard()
	board[1][1] = Rook:new(0) -- P0 Rook
	board[2][1] = Knight:new(0) -- P0 Knight
	board[3][1] = Bishop:new(0) -- P0 Bishop
	board[4][1] = Queen:new(0) -- P0 Queen
	board[5][1] = King:new(0) -- P0 King
	board[6][1] = Bishop:new(0) -- P0 Bishop
	board[7][1] = Knight:new(0) -- P0 Knight
	board[8][1] = Rook:new(0) -- P0 Rook
	for i = 1, 8 do
		board[i][2] = Pawn:new(0)
	end
	
	board[1][8] = Rook:new(1) -- P1 Rook
	board[2][8] = Knight:new(1) -- P1 Knight
	board[3][8] = Bishop:new(1) -- P1 Bishop
	board[4][8] = Queen:new(1) -- P1 Queen
	board[5][8] = King:new(1) -- P1 King
	board[6][8] = Bishop:new(1) -- P1 Bishop
	board[7][8] = Knight:new(1) -- P1 Knight
	board[8][8] = Rook:new(1) -- P1 Rook
	for i = 1, 8 do
		board[i][7] = Pawn:new(1)
	end
end

local function printBasicBoard()
	term.clear()
	term.setCursorPos(1, 1)
	print(" > Player #" .. (currentPlayer + 1) .. ", it's your turn.")
	
	for i = 1, 8 do
		print("+---+---+---+---+---+---+---+---+")
		
		for j = 1, 8 do
			if (board[j][9 - i]) then
				term.write("| " .. board[j][9 - i]:getPieceName() .. " ")
			else
				term.write("|   ")
			end
		end
		
		print("|")
	end
	
	print("+---+---+---+---+---+---+---+---+")
	
	--term.write(tostring(board[1][2]))
end

local function printAdvancedBoard()
	term.clear()
	term.setCursorPos(1, 1)
	
	term.setTextColor(colors.white)
	term.write(" > ")
	term.setTextColor(currentPlayer == 0 and colors.lightBlue or colors.red)
	term.write("Player #" .. (currentPlayer + 1))
	term.setTextColor(colors.white)
	term.write(", it's your turn.")
	
	for i = 1, 8 do
		print("+---+---+---+---+---+---+---+---+")
		
		for j = 1, 8 do
			term.setBackgroundColor(colors.black)
			term.setTextColor(colors.white)
			term.write("|")
			
			if (((9 - i) % 2 == 1 and j % 2 == 0) or ((9 - i) % 2 == 0 and j % 2 == 1)) then
				term.setBackgroundColor(colors.gray)
			end
				
			if (board[j][9 - i]) then
				term.setTextColor(board[j][9 - i].playerIndex == 0 and colors.lightBlue or colors.red)
				term.write(" " .. board[j][9 - i]:getPieceName() .. " ")
			else
				term.write("   ")
			end
		end
		
		term.setBackgroundColor(colors.black)
		term.setTextColor(colors.white)
		
		print("|")
	end
	
	print("+---+---+---+---+---+---+---+---+")
	
	--term.write(tostring(board[1][2]))
end

local printBoard = term.isColor() and printAdvancedBoard or printBasicBoard

local function findKing(playerIndex)
	for i = 1, 8 do
		for j = 1, 8 do
			if (board[j][i] and board[j][i].playerIndex == playerIndex and
				string.upper(board[j][i]:getPieceName()) == "K") then
				return j, i
			end
		end
	end
end

local function isThreatened(x, y, playerIndex)
	for i = 1, 8 do
		for j = 1, 8 do
			if (board[j][i] and board[j][i].playerIndex == playerIndex and
				board[j][i]:isValidMove(j, i, x, y, board)) then
				return true
			end
		end
	end

	return false;
end

local function checkCastling(x1, y1, x2, y2)
	if (not board[x1][y1].moved) then
		if (y2 == y1 and x2 == x1 + 2) then
			if (board[8][y1] and not board[8][y1].moved and not board[7][y1] and not board[6][y1]) then
				local playerIndex = (board[x1][y1].playerIndex + 1) % 2
				if (not isThreatened(x1 + 0, y1, playerIndex) and not isThreatened(x1 + 1, y1, playerIndex) and 
					not isThreatened(x1 + 2, y1, playerIndex) and not isThreatened(x1 + 3, y1, playerIndex)) then
					board[6][y1] = board[8][y1]
					board[8][y1] = nil
					return true	
				end
			end
		elseif (y2 == y1 and x2 == x1 - 2) then
			if (board[1][y1] and not board[1][y1].moved and not board[2][y1] and not board[3][y1] and not board[4][y1]) then
				local playerIndex = (board[x1][y1].playerIndex + 1) % 2
				if (not isThreatened(x1 - 0, y1, playerIndex) and not isThreatened(x1 - 1, y1, playerIndex) and 
					not isThreatened(x1 - 2, y1, playerIndex) and not isThreatened(x1 - 3, y1, playerIndex) and
					not isThreatened(x1 - 4, y1, playerIndex)) then
					board[4][y1] = board[1][y1]
					board[1][y1] = nil
					return true
				end
			end
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
				local y = 9 - math.ceil((mouseY - 1) / 2)
			
				if (x == selectedSpace["x"] and y == selectedSpace["y"]) then
					selectedSpace["x"] = 0
					selectedSpace["y"] = 0
		
					printBoard()
				else
					if (board[selectedSpace["x"]][selectedSpace["y"]]:isValidMove(selectedSpace["x"], selectedSpace["y"], x, y, board)) then
						board[x][y] = board[selectedSpace["x"]][selectedSpace["y"]]
						board[selectedSpace["x"]][selectedSpace["y"]] = nil
						board[x][y].moved = true
						break
					elseif (string.upper(board[selectedSpace["x"]][selectedSpace["y"]]:getPieceName()) == "K" and
							checkCastling(selectedSpace["x"], selectedSpace["y"], x, y)) then
						board[x][y] = board[selectedSpace["x"]][selectedSpace["y"]]
						board[selectedSpace["x"]][selectedSpace["y"]] = nil
						board[x][y].moved = true
						break
					else
						selectedSpace["x"] = 0
						selectedSpace["y"] = 0
			
						printBoard()
						term.write(" > Player #" .. (currentPlayer + 1) .. ", invalid move!")
					end
				end
			end
		elseif (mouseX < boardSizePixels["x"] and mouseY < boardSizePixels["y"] + 1 and (mouseX - 1) % 4 > 0 and (mouseY - 2) % 2 == 1) then
			printBoard()
			
			term.write("Player #" .. (currentPlayer + 1) .. " clicked on ")
			
			local x = math.ceil((mouseX - 0) / 4) 
			local y = 9 - math.ceil((mouseY - 1) / 2)
			
			if (board[x][y]) then
				if (board[x][y].playerIndex == currentPlayer) then
					selectedSpace["x"] = x
					selectedSpace["y"] = y
				
					term.write("'" .. board[x][y]:getPieceName() .. "'")
				end
			else
				term.write("a blank square")
			end
			
			term.write(" @[ " .. x .. ", " .. y .. " ]")
		end
	end
end

local function main(args)
	setupBoard()
	
	printBoard()

	while (true) do
		playerInput()
		
		currentPlayer = (currentPlayer + 1) % 2
		
		printBoard()
	end
end

main({ ... })