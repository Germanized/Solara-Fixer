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
echo Version [2.0.1] By Germanized/Marcelo If "Downloads" dont work Means u Need to open As Admin
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

echo Deletion process completed and Recycle Bin emptied. If it doesn't work, USE VPN.
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
