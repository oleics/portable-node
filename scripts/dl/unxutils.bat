@echo Off

goto conf

:conf
set VERSION=%1
if "%VERSION%"=="" set VERSION=latest
set URL=http://downloads.sourceforge.net/sourceforge/unxutils/UnxUtils.zip
set URL2=http://unxutils.sourceforge.net/UnxUpdates.zip
set DIR=%2
if "%DIR%"=="" set DIR=%CD%
set FILE=%DIR%\sh.exe
goto run

:run
if not exist "%FILE%" goto dl
goto exists

:dl
wget -O "%DIR%\unxutils.zip" "%URL%"
if %ERRORLEVEL% neq 0 goto error
wget -O "%DIR%\unxupdates.zip" "%URL2%"
if %ERRORLEVEL% neq 0 goto error
goto unzip

:unzip
7za e "%DIR%\unxutils.zip" -o"%DIR%" "usr\local\wbin\*" "bin\*"
7za e "%DIR%\unxupdates.zip" -y -o"%DIR%" "*"
if %ERRORLEVEL% neq 0 goto error
del %DIR:/=\%\unxutils.zip
if %ERRORLEVEL% neq 0 goto error
del %DIR:/=\%\unxupdates.zip
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
