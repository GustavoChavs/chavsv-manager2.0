$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
function Run-Step([string]$Label, [scriptblock]$Action) {
  Write-Host "`n=== $Label ===" -ForegroundColor Red
  & $Action
  if ($LASTEXITCODE -ne 0) { throw "$Label falhou (codigo $LASTEXITCODE)." }
}
foreach ($tool in @('node', 'npm.cmd', 'py', 'cargo')) {
  if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) {
    throw "Requisito ausente: $tool. Consulte LEIA-ME-CHAVSV.md."
  }
}
Run-Step 'Dependencias da interface' { npm.cmd ci }
Run-Step 'Ambiente Python' { py -3.11 -m venv .venv }
Run-Step 'Dependencias do backend' { & .\.venv\Scripts\python.exe -m pip install -r backend/requirements.txt pyinstaller==6.11.1 }
Run-Step 'Backend Windows' { & .\.venv\Scripts\python.exe -m PyInstaller backend/backend.spec --noconfirm --clean }
if (-not (Test-Path dist/backend.exe)) { throw 'backend.exe nao foi gerado.' }
New-Item -ItemType Directory -Force src-tauri/resources | Out-Null
Copy-Item dist/backend.exe src-tauri/resources/backend.exe -Force
Run-Step 'Instalador CHAVSV' { npm.cmd run tauri:build }
$installers = @(Get-ChildItem src-tauri/target/release/bundle/nsis/*-setup.exe)
if ($installers.Count -eq 0) { throw 'Instalador nao encontrado.' }
Write-Host "`nInstalador gerado:" -ForegroundColor Green
$installers | Select-Object FullName, Length
