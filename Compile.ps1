#! /usr/bin/pwsh

#===========================================================================
# Compiles latest version and adds to Intune
#===========================================================================

# Check the AHK compiler was found
$CompilerPath = "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"
if (-not(Test-Path -Path $CompilerPath)) {
  throw "AutoHotKey compiler not found. Ensure it's installed in: '$($CompilerPath)'"
}

# Delete the old compiled folder if it exists
$CompiledFolder = "$($PSScriptRoot)\LittleBigMouseFix"
if (Test-Path -Path $CompiledFolder) {
  Remove-Item $CompiledFolder -Recurse -Force
}

# Re-create the compiled folder
mkdir $CompiledFolder > $null

# Compile `Little Big Mouse - Unplug Fix` into the 'Compiled' folder
& $CompilerPath /in "$($PSScriptRoot)\LittleBigMouseFix.ahk" /icon "$($PSScriptRoot)\LBMFix.ico" /out "$($CompiledFolder)\LittleBigMouseFix.exe"

# Copy the connection icon into the compiled folder
Copy-Item "$($PSScriptRoot)\LBMFix.ico" $CompiledFolder
