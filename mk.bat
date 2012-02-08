
@echo Off

set PREV_PATH=%PATH%
set PATH=%PATH%;utils
set VENDOR_DIR=./vendors
set DIST_DIR=./dist
set TMP_DIR=./tmp
echo %PATH%

if not exist "%TMP_DIR%" (
  mkdir "%TMP_DIR%"
)

if not exist "%DIST_DIR%" (
  mkdir "%DIST_DIR%"
)

for /R "packs" %%a in (*.txt) do (
  echo %%~na
  if not exist "./dist/%%~na" (
    mkdir "%DIST_DIR%/%%~na"
  )
  for /F "tokens=1,2,3 delims=," %%b in (%%a) do (
    echo %%b %%c %%d
    xcopy /I /E /V /Y "%VENDOR_DIR%/%%b/%%c" "%DIST_DIR%/%%~na/%%d"
  )
)

set PATH=%PREV_PATH%
echo.
