@echo off
setlocal EnableExtensions EnableDelayedExpansion

echo ================================================
echo Azure VM SKU Resizer
echo ================================================
echo.

set /p RG="Enter Resource Group Name: "
set /p VM="Enter VM Name (e.g. vm-debian1): "
set /p NEW_SIZE="Enter New SKU (e.g. Standard_B2ls_v2): "

echo.
echo You are about to resize:
echo   Resource Group : %RG%
echo   VM Name        : %VM%
echo   New SKU        : %NEW_SIZE%
echo.
set /p CONFIRM="Type YES to continue (case sensitive): "

if /i not "%CONFIRM%"=="YES" (
    echo Operation cancelled by user.
    pause
    exit /b 1
)

echo.
echo Starting resize process for %VM%...
echo.

echo [1/3] Deallocating VM...
call az vm deallocate --resource-group "%RG%" --name "%VM%"
set "rc=%errorlevel%"
if not "!rc!"=="0" (
    echo ERROR: Failed to deallocate the VM. rc=!rc!
    pause
    exit /b 1
)

echo [2/3] Resizing VM to %NEW_SIZE%...
call az vm resize --resource-group "%RG%" --name "%VM%" --size "%NEW_SIZE%"
set "rc=%errorlevel%"
if not "!rc!"=="0" (
    echo ERROR: Failed to resize the VM. rc=!rc!
    pause
    exit /b 1
)

echo [3/3] Starting VM...
call az vm start --resource-group "%RG%" --name "%VM%"
set "rc=%errorlevel%"
if not "!rc!"=="0" (
    echo ERROR: Failed to start the VM. rc=!rc!
    pause
    exit /b 1
)

echo.
echo ================================================
echo SUCCESS: VM %VM% has been resized to %NEW_SIZE% and started.
echo ================================================