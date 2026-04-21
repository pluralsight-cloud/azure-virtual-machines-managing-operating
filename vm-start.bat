@echo off
setlocal EnableExtensions EnableDelayedExpansion

echo ================================================
echo Azure VM Start
echo ================================================
echo.

set /p RG="Enter Resource Group Name: "
set /p VM="Enter VM Name (e.g. vm-debian1): "

echo.
echo You are about to START:
echo   Resource Group : %RG%
echo   VM Name        : %VM%
echo.

echo Starting VM %VM%...
echo.

az vm start --resource-group "%RG%" --name "%VM%" --only-show-errors
set "rc=%errorlevel%"

echo Exit code: !rc!
if not "!rc!"=="0" (
    echo ERROR: Failed to start the VM.
    pause
    exit /b 1
)

echo.
echo Verifying power state...
for /f "usebackq delims=" %%A in (`
    az vm get-instance-view --resource-group "%RG%" --name "%VM%" --query "instanceView.statuses[?starts_with(code,'PowerState/')].displayStatus | [0]" -o tsv
`) do set "POWERSTATE=%%A"

echo Power state: !POWERSTATE!

if /i not "!POWERSTATE!"=="VM running" (
    echo WARNING: Start command returned success, but VM is not reported as running yet.
    echo The CLI can return before the VM fully transitions.
    pause
    exit /b 2
)

echo.
echo ================================================
echo SUCCESS: VM %VM% has been started.
echo ================================================
echo.

pause