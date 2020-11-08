:: bash

echo "Sweet Molly"

@echo off

set "File=C:\Users\mnova\Desktop\trial01.txt"
set /a count=0

SETLOCAL enabledelayedexpansion

for /F "tokens=1 delims=" %%a in ('Type "%File%"') do (
         Set /a count+=1
         Set "output[!count!]=%%a"
         echo %%a     
)

For /L %%i in (1,1,%Count%) Do (
 Call :Action "!output[%%i]!"
 pause
)

Exit
:: *******************************************************
:Action
echo We treat this line : %1
for /f "tokens=1,2 delims=;" %%b in (%1) do echo %%b
: for %%s in ("%1%") do (
:          Echo %%s
:          Echo "end"
: )
exit /b
:: *******************************************************