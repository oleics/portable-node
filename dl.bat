@echo off

:config
set PREV_PATH=%PATH%
set PATH=%PATH%;utils
set VERSIONS_DIR=.\data\versions
set VENDORS_DIR=.\vendors
set DL_LIST=%*

:chkdllist
if "%DL_LIST%"=="" set DL_LIST=node npm 7z unxutils git nginx

:chkdir
if not exist "%VENDORS_DIR%" (
  mkdir "%VENDORS_DIR%"
  if %ERRORLEVEL% neq 0 goto error
)

:dl
for %%B in (%DL_LIST%) do (
  echo.
  if exist "%VERSIONS_DIR%\%%B.txt" (
    echo %%B
    if not exist "%VENDORS_DIR%\%%B" (
      mkdir "%VENDORS_DIR%\%%B"
      if %ERRORLEVEL% neq 0 goto error
    )
    for /f %%A in ('type %VERSIONS_DIR%\%%B.txt') do (
      echo %%A
      if not exist "%VENDORS_DIR%\%%B\%%A" (
        mkdir "%VENDORS_DIR%\%%B\%%A"
        if %ERRORLEVEL% neq 0 goto error
      )
      call scripts\dl-%%B.bat %%A %VENDORS_DIR%\%%B\%%A
      if %ERRORLEVEL% neq 0 goto error
    )
  ) else (
    echo File not found: %VERSIONS_DIR%\%%B.txt
  )
)
goto end

:error
echo ERROR
goto end

:end
set PATH=%PREV_PATH%
echo.
