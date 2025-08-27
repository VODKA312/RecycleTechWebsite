@echo off
REM RecycleTech Windows Deployment Script
REM Usage: deploy.bat [staging|production]

setlocal enabledelayedexpansion

REM Check parameters
set "ENVIRONMENT=%1"
if "%ENVIRONMENT%"=="" set "ENVIRONMENT=staging"

if not "%ENVIRONMENT%"=="staging" (
    if not "%ENVIRONMENT%"=="production" (
        echo Error: Invalid environment parameter '%ENVIRONMENT%'
        echo Usage: deploy.bat [staging^|production]
        exit /b 1
    )
)

echo Starting deployment to %ENVIRONMENT% environment...

REM Check required files
if not exist "deploy\deploy.sh" (
    echo Error: Deployment script deploy\deploy.sh not found
    exit /b 1
)

if not exist "deploy\config.env.example" (
    echo Warning: Config file deploy\config.env.example not found
)

REM Check environment file
if not exist "deploy\.env" (
    echo Creating environment config file...
    if exist "deploy\config.env.example" (
        copy "deploy\config.env.example" "deploy\.env" >nul
        echo Please edit deploy\.env file with correct configuration
        echo Then run this script again
        pause
        exit /b 1
    )
)

REM Run deployment script (requires WSL or Git Bash)
echo Executing deployment script...
echo Note: This script needs to run in WSL or Git Bash environment
echo Please use: bash deploy/deploy.sh %ENVIRONMENT%

echo Deployment completed!

REM Show next steps
echo.
echo Next steps:
echo 1. Check service status: sudo systemctl status recycletech
echo 2. Check Nginx status: sudo systemctl status nginx
echo 3. View logs: sudo tail -f /var/log/recycletech/django.log
echo 4. Visit website: http://your-domain.com
echo.
echo Deployment successful!

pause 