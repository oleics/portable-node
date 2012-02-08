@echo Off

goto conf

:conf
set VERSION=%1
if "%VERSION%"=="" set VERSION=920
set URL=http://downloads.sourceforge.net/sourceforge/sevenzip/7za%VERSION%.zip
set DIR=./vendors/7z/%VERSION%
set FILE=%DIR%/7za.exe
goto run

:run
if not exist "%DIR%" ( mkdir "%DIR%" )
if not exist "%FILE%" goto dl
goto exists

:dl
wget -O "%DIR%/7za.zip" "%URL%"
if ERRORLEVEL 1 goto error
goto unzip

:unzip
7za x "%DIR%/7za.zip" -o"%DIR%"
if ERRORLEVEL 1 goto error
del %DIR:/=\%\7za.zip
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
