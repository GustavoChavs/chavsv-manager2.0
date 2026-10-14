@echo off
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0build-chavsv.ps1"
if errorlevel 1 (
  echo.
  echo A compilacao falhou. Consulte a mensagem acima e LEIA-ME-CHAVSV.md.
  pause
  exit /b 1
)
pause
