$ErrorActionPreference = "Stop"

$rootDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$buildDir = Join-Path $rootDir "build"
if (-not (Test-Path $buildDir)) {
    New-Item -ItemType Directory -Path $buildDir | Out-Null
}

$iverilogFlags = @("-g2012", "-I", (Join-Path $rootDir "rtl"))

Write-Host "[RUN] tb_core_basic"
& iverilog @iverilogFlags -o (Join-Path $buildDir "tb_core_basic.vvp") `
    (Join-Path $rootDir "tb/tb_core_basic.v") `
    (Join-Path $rootDir "rtl/*.v")
& vvp (Join-Path $buildDir "tb_core_basic.vvp")

Write-Host "[RUN] tb_core_edgecases"
& iverilog @iverilogFlags -o (Join-Path $buildDir "tb_core_edgecases.vvp") `
    (Join-Path $rootDir "tb/tb_core_edgecases.v") `
    (Join-Path $rootDir "rtl/*.v")
& vvp (Join-Path $buildDir "tb_core_edgecases.vvp")
