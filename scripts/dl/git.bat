
@ECHO OFF
goto config

:config

set VERSION=%1
IF "%VERSION%"=="" set VERSION=1.7.9-preview20120201
set URL=http://msysgit.googlecode.com/files/PortableGit-%VERSION%.7z
set DIR=%2
if "%DIR%"=="" set DIR=%CD%
set FILE=%DIR%\git-bash.bat
goto run

:run
if not exist %FILE% goto dl
goto exists

:dl
wget -O "%DIR%\pgit.7z" "%URL%
if %ERRORLEVEL% neq 0 goto error
goto unzip

:unzip
7za x "%DIR%\pgit.7z" -o"%DIR%"
if %ERRORLEVEL% neq 0 goto error
del %DIR:/=\%\pgit.7z
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

