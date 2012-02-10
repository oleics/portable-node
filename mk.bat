
@echo Off

:conf
set PREV_PATH=%PATH%
set PATH=%PATH%;utils
set VENDOR_DIR=.\vendors
set DIST_DIR=.\dist
set TMP_DIR=.\tmp
set PACKS_DIR=.\data\packs
set MK_LIST=%*
:: echo %PATH%

:chkmklist
if "%MK_LIST%"=="" (
  for /R "%PACKS_DIR%" %%a in (*.txt) do (
    call:addToMkList %%~na
  )
)

:mkdirs
rmdir /S /Q "%TMP_DIR%"
if not exist "%TMP_DIR%" (
  mkdir "%TMP_DIR%"
  if %ERRORLEVEL% neq 0 goto error
)

if not exist "%DIST_DIR%" (
  mkdir "%DIST_DIR%"
  if %ERRORLEVEL% neq 0 goto error
)

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
    xcopy /I /E /V /Y "%VENDOR_DIR%\%%b\%%c" "%TMP_DIR%\%%a\%%d"
    if %ERRORLEVEL% neq 0 goto error
  )
  7za a -tzip "%DIST_DIR%\%%a.zip" "%TMP_DIR%\%%a\*" -mx9
  if %ERRORLEVEL% neq 0 goto error
)
goto end

:error
echo ERROR
goto end

:: FUNCTIONS

:addToMkList
if "%MK_LIST%" equ "" (
  set MK_LIST=%1
) else (
  set MK_LIST=%MK_LIST% %1
)
goto:eof

:: END OF FUNCTIONS

:end
set PATH=%PREV_PATH%
echo.
