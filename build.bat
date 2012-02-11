@echo off

:config
call .\scripts\utils\config.bat
set BUILD_NAME=%1
shift
if "%BUILD_NAME%" equ "" (
  echo Please give me a name for the thing you want to build.
  goto end
)
if "%1" equ "" (
  echo Don't know what packs to use.
  call:showPacks
  goto end
)
goto buildstructure

:buildstructure
for /f %%a in (%STRUCTURE_FILE%) do (
  echo %TMP_DIR%\%%~a
  mkdir "%TMP_DIR%\%%~a"
)
goto build

:build
for %%a in (%*) do (
  if [%%a] equ [%BUILD_NAME%] (
    echo.
  ) else (
    call:unpack %%a
  )
)
goto pack

:pack
if exist "%BUILD_DIR%\%BUILD_NAME%.zip" ( del %BUILD_DIR%\%BUILD_NAME%.zip )
7za a -tzip "%BUILD_DIR%\%BUILD_NAME%.zip" "%TMP_DIR%\*" ".\data\portable.cmd" -mx9 -mm=LZMA -mmt2
if %ERRORLEVEL% neq 0 goto error
goto end

:error
echo ERROR
goto end

:: FUNCTIONS

:showPacks
:: Print packs to screen.
echo Packs:
for /R "%DATA_DIR%\packs" %%a in (*.txt) do (
  echo     %%~na
)
goto:eof

:unpack
:: Copy pack to usr\local\vendor
:: %~1 - name of pack
7za x "%DIST_DIR%\%~1.zip" -o"%TMP_DIR%\usr\local\"
if %ERRORLEVEL% neq 0 goto error
goto:eof

:: END OF FUNCTIONS

:end
call .\scripts\utils\end.bat
