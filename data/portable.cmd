@echo off
break off
color 07
prompt $p$g
title Command Prompt Portable
cls
rem ver
rem cd\

:common-env-vars
set ALLUSERSPROFILE=%~dp0var
set APPDATA=%~dp0var
set COMPUTERNAME=%COMPUTERNAME%
set COMSPEC=%COMSPEC%
set HOMEDRIVE=%~d0
set HOMEPATH=%~p0home
set PATH=%PATH%
set PATHEXT=%PATHEXT%
set PROGRAMFILES=%~dp0usr\local
set ProgramFiles(x86)=%~dp0usr\local
set PROMPT=%PROMPT%
set SYSTEMDRIVE=%SYSTEMDRIVE%
set SYSTEMROOT=%SYSTEMROOT%
set TEMP=%~dp0tmp
set TMP=%~dp0tmp
set USERNAME=%USERNAME%
set USERPROFILE=%~dp0home
set WINDIR=%WINDIR%

set HOME=%USERPROFILE%
set HISTFILE=%USERPROFILE%\.bash_history

set PATH=%~dp0usr\bin;%PATH%

:unxutils
set PATH=%PROGRAMFILES%\UnxUtils;%PATH%

:git
set PATH=%PROGRAMFILES%\git\bin;%PATH%
set PATH=%PROGRAMFILES%\git\mingw\bin;%PATH%
set PATH=%PROGRAMFILES%\git\cmd;%PATH%
set PLINK_PROTOCOL=ssh

:node
set PATH=%PROGRAMFILES%\node;%PATH%
set NODE_PATH=%PROGRAMFILES%\node\node_modules;%PROGRAMFILES%\node

:npm
set PATH=%APPDATA%\npm;%PATH%

:nginx
set PATH=%PROGRAMFILES%\nginx;%PATH%

:start
cmd.exe /D /F:ON /K cd %HOME%
