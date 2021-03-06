
@ECHO OFF
goto config

:config
set VERSION=%1
IF "%VERSION%"=="" set VERSION=1.1.14
set URL=http://nginx.org/download/nginx-%VERSION%.zip
set DIR=%2
if "%DIR%"=="" set DIR=%CD%
set FILE=%DIR%\nginx.exe
goto run

:run
if not exist %FILE% goto dl
goto exists

:dl
wget -O "%DIR%\nginx.zip" "%URL%"
if %ERRORLEVEL% neq 0 goto error
goto unzip

:unzip
7za x "%DIR%\nginx.zip" -o"%DIR%" "nginx-%VERSION%\*"
if %ERRORLEVEL% neq 0 goto error
del %DIR:/=\%\nginx.zip
if %ERRORLEVEL% neq 0 goto error
xcopy /E /V "%DIR%\nginx-%VERSION%" "%DIR%"
if %ERRORLEVEL% neq 0 goto error
rmdir /S /Q "%DIR%\nginx-%VERSION%"
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

