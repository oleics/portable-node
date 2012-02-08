
@echo Off

if not exist "./vendors" (
  mkdir "./vendors"
)

set PREV_PATH=%PATH%
set PATH=%PATH%;utils
echo %PATH%

For %%B IN (node npm 7z unxutils git nginx) DO (
  echo.
  echo %%B
  if not exist "./vendors/%%B" ( mkdir "./vendors/%%B" )
  For /f %%A IN ('type versions\%%B.txt') DO (
    echo %%A
    call scripts/dl-%%B.bat %%A
  )
)

set PATH=%PREV_PATH%
echo.
