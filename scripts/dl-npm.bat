
@ECHO OFF
goto config

:config
set VERSION=%1
IF "%VERSION%"=="" set VERSION=1.1.0-3
set URL=http://npmjs.org/dist/npm-%VERSION%.zip
set DIR=./vendors/npm/%VERSION%
set FILE=%DIR%/npm.cmd
goto run

:run
if not exist "%DIR%" ( mkdir "%DIR%" )
if not exist %FILE% goto dl
goto exists

:dl
wget -O "%DIR%/npm.zip" "%URL%
if ERRORLEVEL 1 goto error
goto unzip

:unzip
7za x "%DIR%/npm.zip" -o"%DIR%"
if ERRORLEVEL 1 goto error
del %DIR:/=\%\npm.zip
if ERRORLEVEL 1 goto error
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

