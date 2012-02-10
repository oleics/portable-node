
@echo Off

set PREV_PATH=%PATH%
set PATH=%PATH%;utils
set VENDOR_DIR=./vendors
set DIST_DIR=./dist
set TMP_DIR=./tmp
echo %PATH%

if not exist "%TMP_DIR%" (
  mkdir "%TMP_DIR%"
  if not errorlevel 0 goto error
)

if not exist "%DIST_DIR%" (
  mkdir "%DIST_DIR%"
  if not errorlevel 0 goto error
)

for /R "data\packs" %%a in (*.txt) do (
  echo %%~na
  if exist "%DIST_DIR%/%%~na.zip" (
    del "%DIST_DIR:/=\%\%%~na.zip"
    if not errorlevel 0 goto error
  )
  rem if not exist "./dist/%%~na" ( mkdir "%DIST_DIR%/%%~na" )
  for /F "tokens=1,2,3 delims=," %%b in (%%a) do (
    echo %%b %%c %%d
    rem xcopy /I /E /V /Y "%VENDOR_DIR%/%%b/%%c" "%DIST_DIR%/%%~na/%%d"
    rem if not errorlevel 0 goto error
    7za a -tzip "%DIST_DIR%/%%~na.zip" "%VENDOR_DIR%/%%b/%%c/*" -mx9
    if not errorlevel 0 goto error
  )
)
goto end

:error
echo ERROR
goto end

:end
set PATH=%PREV_PATH%
echo.
