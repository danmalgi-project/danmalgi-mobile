# scripts/generate_proto.ps1

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RootDir = Split-Path -Parent $ScriptDir

$ProtoDir = "$RootDir\proto"
$OutDir = "$RootDir\lib\core\generated"

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$ProtoFiles = Get-ChildItem -Path $ProtoDir -Recurse -Filter "*.proto" | Select-Object -ExpandProperty FullName

protoc `
  --proto_path="$ProtoDir" `
  --dart_out="grpc:$OutDir" `
  $ProtoFiles

Write-Host "✅ proto generation complete → $OutDir"