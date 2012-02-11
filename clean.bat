@echo off

if exist ".\build\" (
  rmdir /S ".\build"
)

if exist ".\dist\" (
  rmdir /S ".\dist"
)

if exist ".\vendors\" (
  rmdir /S ".\vendors"
)

if exist ".\tmp\" (
  rmdir /S ".\tmp"
)
