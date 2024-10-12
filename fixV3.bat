@echo off 
:: Set color scheme to violet and purple
color 5F

:: Enable error capturing
setlocal enabledelayedexpansion
set "errorLog=%temp%\error.log"
if exist "%errorLog%" del "%errorLog%"

:menu
cls
echo............................................................................                                                                                                                               
echo   #####                                     #######                     
echo #     #  ####  #        ##   #####    ##   #       # #    # ###### ##### 
echo #       #    # #       #  #  #    #  #  #  #       #  #  #  #      #    #
echo  #####  #    # #      #    # #    # #    # #####   #   ##   #####  #    #
echo       # #    # #      ###### #####  ###### #       #   ##   #      ##### 
echo #     # #    # #      #    # #   #  #    # #       #  #  #  #      #   #     
echo  #####   ####  ###### #    # #    # #    # #       # #    # ###### #    #  
echo............................................................................                                                                                                                               
echo Version [7.8.6] By Germanized/Marcelo If "Downloads" dont work Means u Need to open As Admin
echo.
echo 1. Fix Solara Not Opening after Bootstrapper and more
echo 2. Download Solara Bootstrapper (Already Bypassed)
echo 3. Get Solara Boot Strapper (linkvertise help qui pay his bills)
echo 4. Go to Solara Website (THE ONLY ONE IS GETSOLARA.DEV)
echo 5. Join Discord Server
echo 6. Exit
echo.
set /p choice="Enter your choice: "

if %choice%==1 goto fix_solara
if %choice%==2 goto download_bypassed
if %choice%==3 goto download_linkvertise
if %choice%==4 goto solara_website
if %choice%==5 goto join_discord
if %choice%==6 goto exit
goto menu

:fix_solara
echo Closing any running Node.js processes...

:: Close any running Node.js process before attempting deletion
taskkill /f /im node.exe /t 2>nul

echo Node.js process terminated (if any were running).
echo Now attempting to delete Solara folder and Solara.zip from all AppData folders and ProgramData...

:: Check and delete Solara folder and Solara.zip from ProgramData
if exist "%ProgramData%\Solara" (
    echo Deleting Solara folder from ProgramData...
    rmdir /s /q "%ProgramData%\Solara"
) >> "%errorLog%" 2>&1
if exist "%ProgramData%\Solara.zip" (
    echo Deleting Solara.zip from ProgramData...
    del /q "%ProgramData%\Solara.zip"
) >> "%errorLog%" 2>&1

:: Define user-specific AppData paths
setlocal
set appDataLocal=%LocalAppData%
set appDataRoaming=%AppData%
set appDataLocalLow=%UserProfile%\AppData\LocalLow

:: Delete Solara folder and Solara.zip from LocalAppData
if exist "%appDataLocal%\Solara" (
    echo Deleting Solara folder from LocalAppData...
    rmdir /s /q "%appDataLocal%\Solara"
) >> "%errorLog%" 2>&1
if exist "%appDataLocal%\Solara.zip" (
    echo Deleting Solara.zip from LocalAppData...
    del /q "%appDataLocal%\Solara.zip"
) >> "%errorLog%" 2>&1

:: Delete Solara folder and Solara.zip from Roaming (AppData\Roaming)
if exist "%appDataRoaming%\Solara" (
    echo Deleting Solara folder from Roaming...
    rmdir /s /q "%appDataRoaming%\Solara"
) >> "%errorLog%" 2>&1
if exist "%appDataRoaming%\Solara.zip" (
    echo Deleting Solara.zip from Roaming...
    del /q "%appDataRoaming%\Solara.zip"
) >> "%errorLog%" 2>&1

:: Delete Solara folder and Solara.zip from LocalLow (AppData\LocalLow)
if exist "%appDataLocalLow%\Solara" (
    echo Deleting Solara folder from LocalLow...
    rmdir /s /q "%appDataLocalLow%\Solara"
) >> "%errorLog%" 2>&1
if exist "%appDataLocalLow%\Solara.zip" (
    echo Deleting Solara.zip from LocalLow...
    del /q "%appDataLocalLow%\Solara.zip"
) >> "%errorLog%" 2>&1
endlocal

:: Empty the Recycle Bin using PowerShell
echo Emptying Recycle Bin...
powershell -command "(New-Object -ComObject Shell.Application).NameSpace(0xA).Items() | ForEach-Object { $_.InvokeVerb('delete') }" >> "%errorLog%" 2>&1

:: Prompt to try opening Solara or using Part Two if it doesn't work
echo Deletion process completed and Recycle Bin emptied. If Solara doesn't open, try using Part Two.
echo Open Solara Then Press Enter on This Cmd...
pause
echo Did Solara open successfully?
echo 1. Yes
echo 2. No, try Part Two.
set /p solara_success="Enter your choice: "
if %solara_success%==1 goto menu
if %solara_success%==2 goto part_two
goto menu

:part_two
echo Extracting SolaraV3.dll from Solara.zip...

:: Extract SolaraV3.dll from Solara.zip and move to ProgramData\Solara folder
powershell -command "Add-Type -AssemblyName System.IO.Compression.FileSystem; \
[IO.Compression.ZipFile]::ExtractToDirectory('%ProgramData%\Solara.zip', '%ProgramData%\Solara');"
if exist "%ProgramData%\Solara\SolaraV3.dll" (
    echo SolaraV3.dll successfully extracted to ProgramData\Solara.
) else (
    echo Error: SolaraV3.dll extraction failed.
    echo Please report this issue to the GitHub: https://github.com/Germanized/Solara-Fixer
)
pause
goto menu

:download_bypassed
start https://2231fc06.solaraweb-alj.pages.dev/download/static/files/Bootstrapper.exe
goto menu

:download_linkvertise
start https://linkvertise.com/1208172/solara-bootstrapper?o=sharing
goto menu

:solara_website
start https://getsolara.dev
goto menu

:join_discord
start https://discord.gg/yrr3QERx9d
goto menu

:exit
:: Display error log if it exists
if exist "%errorLog%" (
    echo.
    echo Errors encountered during execution:
    type "%errorLog%"
    echo.
    pause
)
exit /b
