@echo off

:config
call config.bat
set DL_LIST=%*

:chkdllist
if "%DL_LIST%"=="" set DL_LIST=node npm 7z unxutils git nginx

:dl
for %%a in (%DL_LIST%) do (
  echo.
  if exist "%VERSIONS_DIR%\%%a.txt" (
    echo %%a
    if not exist "%VENDORS_DIR%\%%a" (
      mkdir "%VENDORS_DIR%\%%a"
      if %ERRORLEVEL% neq 0 goto error
    )
    for /f "tokens=1,2 delims=," %%b in ('type %VERSIONS_DIR%\%%a.txt') do (
      echo %%b %%c
      if exist "%VENDORS_DIR%\%%a\%%b.7z" (
        echo Already exists: %VENDORS_DIR%\%%a\%%b.7z
      ) else (
        if not exist "%VENDORS_DIR%\%%a\%%b" (
          mkdir "%VENDORS_DIR%\%%a\%%b"
          if %ERRORLEVEL% neq 0 goto error
        )
        call scripts\dl\%%a.bat %%c %VENDORS_DIR%\%%a\%%b
        if %ERRORLEVEL% neq 0 goto error
        7za a -t7z "%VENDORS_DIR%\%%a\%%b.7z" "%VENDORS_DIR%\%%a\%%b\*"
        if %ERRORLEVEL% neq 0 goto error
        rmdir /S /Q "%VENDORS_DIR%\%%a\%%b"
        if %ERRORLEVEL% neq 0 goto error
      )
    )
  ) else (
    echo File not found: %VERSIONS_DIR%\%%a.txt
  )
)
goto end

:error
echo ERROR

:end
call .\scripts\utils\end.bat
