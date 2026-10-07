$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Split-Path -Parent $ScriptDir
Set-Location $RootDir

# PowerShell does not stop when a native command fails, so check the exit code.
function Invoke-Step {
  param([string]$Name, [scriptblock]$Command)

  Write-Host "> $Name"
  & $Command
  if ($LASTEXITCODE -ne 0) {
    Write-Host "FAILED: $Name (exit $LASTEXITCODE)" -ForegroundColor Red
    exit $LASTEXITCODE
  }
}

Invoke-Step 'build_runner' { dart run build_runner build }
Invoke-Step 'remove unused imports' { dart fix --apply --code=unused_import --code=unnecessary_import --code=directives_ordering }
Invoke-Step 'dart format' {
  $files = git ls-files '*.dart' | Where-Object { $_ -notlike 'lib/core/generated/*' }
  dart format $files
}
Invoke-Step 'analyze' { flutter analyze --no-fatal-infos }

Write-Host 'All checks passed.' -ForegroundColor Green