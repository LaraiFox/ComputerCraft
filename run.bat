@echo off
lua "S:\Programs\LDoc\ldoc.lua" "%~1" -t "%~n1.lua" -o "%~n1" -d "%~d1%~p1
PAUSE