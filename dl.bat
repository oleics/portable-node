
@echo Off

if not exist "./vendors" (
  mkdir "./vendors"
)

set PREV_PATH=%PATH%
set PATH=%PATH%;utils
echo %PATH%

for %%B in (node npm 7z unxutils git nginx) do (
  echo.
  echo %%B
  if not exist "./vendors/%%B" ( mkdir "./vendors/%%B" )
  for /f %%A in ('type data\versions\%%B.txt') do (
    echo %%A
    call scripts/dl-%%B.bat %%A
  )
)

set PATH=%PREV_PATH%
echo.
