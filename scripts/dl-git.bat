
@ECHO OFF
goto config

:config

set SEVEN_ZIP=vendors\7z\920\7za.exe
set VERSION=%1
IF "%VERSION%"=="" set VERSION=1.7.9-preview20120201
set URL=http://msysgit.googlecode.com/files/PortableGit-%VERSION%.7z
set DIR=./vendors/git/%VERSION%
set FILE=%DIR%/git-bash.bat
goto run

:run
if not exist "%DIR%" ( mkdir "%DIR%" )
if not exist %FILE% goto dl
goto exists

:dl
wget -O "%DIR%/pgit.7z" "%URL%
if ERRORLEVEL 1 goto error
goto unzip

:unzip
7za x "%DIR%/pgit.7z" -o"%DIR%"
if ERRORLEVEL 1 goto error
del %DIR:/=\%\pgit.7z
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

