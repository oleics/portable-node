@echo off
setlocal EnableDelayedExpansion

:conf
call .\scripts\utils\config.bat
set MK_LIST=%*

:chkmklist
if "%MK_LIST%"=="" (
  for /R "%PACKS_DIR%" %%a in (*.txt) do (
    echo %%~na
    call:addToMkList %%~na
  )
)
goto mk

:mk
for %%a in (%MK_LIST%) do (
  if not exist "%PACKS_DIR%\%%a.txt" (
    echo Can not find %PACKS_DIR%\%%a.txt
    goto error
  )
  echo %%a
  if exist "%DIST_DIR%\%%a.zip" (
    del "%DIST_DIR:/=\%\%%a.zip"
    if %ERRORLEVEL% neq 0 goto error
  )
  for /F "tokens=1,2,3 delims=," %%b in (%PACKS_DIR%\%%a.txt) do (
    echo %%b %%c %%d
    7za x "%VENDORS_DIR%\%%b\%%c.7z" -o"%TMP_DIR%\%%a\%%d"
    if %ERRORLEVEL% neq 0 goto error
  )
  7za a -tzip "%DIST_DIR%\%%a.zip" "%TMP_DIR%\%%a\*"
  if %ERRORLEVEL% neq 0 goto error
)
goto end

:error
echo ERROR
goto end

:: FUNCTIONS

:addToMkList
:: %1 - name of pack
if "%MK_LIST%" equ "" (
  set MK_LIST=%1
) else (
  set MK_LIST=%MK_LIST% %1
)
goto:eof

:: END OF FUNCTIONS

:end
call .\scripts\utils\end.bat
