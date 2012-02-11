@echo off

:: paths
set DIST_DIR=.\dist
set DATA_DIR=.\data
set PACKS_DIR=.\data\packs
set VERSIONS_DIR=.\data\versions
set VENDORS_DIR=.\vendors
set BUILD_DIR=.\build
set STRUCTURE_FILE=%DATA_DIR%\layout.txt
set TMP_DIR=.\tmp

:: save path
set PREV_PATH=%PATH%
set PATH=%PATH%;utils

:: create vendors directory
if not exist "%VENDORS_DIR%" (
  mkdir "%VENDORS_DIR%"
  if %ERRORLEVEL% neq 0 goto error
)

:: create distribution directory
if not exist "%DIST_DIR%" (
  mkdir "%DIST_DIR%"
  if %ERRORLEVEL% neq 0 goto error
)

:: create build directory
if not exist "%BUILD_DIR%" (
  mkdir "%BUILD_DIR%"
  if %ERRORLEVEL% neq 0 goto error
)

:: create random temp directory
if not exist "%TMP_DIR%" (
  mkdir "%TMP_DIR%"
  if %ERRORLEVEL% neq 0 goto error
)
set TMP_DIR=%TMP_DIR%\pn_%RANDOM%
mkdir "%TMP_DIR%"
if %ERRORLEVEL% neq 0 goto error

:done
goto end

:error
echo ERROR
goto end

:end
