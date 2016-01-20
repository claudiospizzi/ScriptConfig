
# Definition for build
$Module = 'ScriptConfig'
$Source = "C:\Projects\$Module"
$Target = "C:\Program Files\WindowsPowerShell\Modules\$Module"

# Create target module folder
New-Item -Path $Target -ItemType Directory | Out-Null

# Copy all module items
Copy-Item -Path "$Source\Examples"     -Destination $Target -Recurse
Copy-Item -Path "$Source\Functions"    -Destination $Target -Recurse
Copy-Item -Path "$Source\Tests"        -Destination $Target -Recurse
Copy-Item -Path "$Source\$Module.psd1" -Destination $Target
Copy-Item -Path "$Source\$Module.psm1" -Destination $Target

# Patch the manifest file
$ManifestPath = Join-Path -Path $Target -ChildPath "$Module.psd1"
(Get-Content -Path $ManifestPath -Raw).Replace('0.0.0.0', $env:APPVEYOR_BUILD_VERSION) | Out-File -FilePath $ManifestPath

# Push appveyor artifacts
Compress-Archive -Path $Target -DestinationPath "$Source\$Module-$env:APPVEYOR_BUILD_VERSION.zip"
Push-AppveyorArtifact -Path "$Source\$Module-$env:APPVEYOR_BUILD_VERSION.zip" -DeploymentName $Module
