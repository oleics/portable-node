@echo off
goto config

:config
set VERSION=%1
IF "%VERSION%"=="" set VERSION=latest
set URL=http://nodejs.org/dist/%VERSION%/node.exe
set DIR=%2
if "%DIR%"=="" set DIR=%CD%
set FILE=%DIR%\node.exe
goto run

:run
if not exist %FILE% goto dl
goto exists

:dl
wget -O "%FILE%" "%URL%
if %ERRORLEVEL% neq 0 goto error
goto end

:error
echo ERROR
rmdir /S /Q "%DIR%"
goto end

:exists
echo Already exists: %FILE%
goto end

:done
goto end

:end
