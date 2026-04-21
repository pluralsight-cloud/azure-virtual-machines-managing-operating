@echo off
setlocal EnableDelayedExpansion

echo ================================================
echo     Azure VM Stop + Deallocate
echo ================================================
echo.

:: Prompt for inputs
set /p RG="Enter Resource Group Name: "
set /p VM="Enter VM Name (e.g. vm-debian1): "

echo.
echo You are about to STOP and DEALLOCATE:
echo   Resource Group : %RG%
echo   VM Name        : %VM%
echo.
echo This will stop billing for compute resources.

echo.
echo Stopping and deallocating %VM%...

az vm deallocate --resource-group "%RG%" --name "%VM%"

if %errorlevel% neq 0 (
    echo ERROR: Failed to stop/deallocate the VM.
    pause
    exit /b 1
)

echo.
echo ================================================
echo SUCCESS: VM %VM% has been stopped and deallocated.
echo You are no longer being charged for compute.
echo ================================================
echo.

pause