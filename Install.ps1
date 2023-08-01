# build local modules dir if not exist
$localPSModulePath = [IO.Path]::Combine($HOME, "Documents", "WindowsPowerShell", "Modules");
# assigning to $null silences the output
$null = New-Item -ItemType Directory -Force -Path $localPSModulePath

# build path to copy modules directory
$modulesPath = [IO.Path]::Combine($PSScriptRoot, "Modules")
$modulesStar = -join ($modulesPath, "\*");
Copy-Item -Force -Recurse $modulesStar $localPSModulePath
Copy-Item -Force ([IO.Path]::Combine($PSScriptRoot, "Profile.ps1")) $profile

# import modules from local module lib
Import-Module EnvPathFunctions
$pathsToAddToPath = @(
    Join-Path $PSScriptRoot "Path"
);

foreach ($path in $pathsToAddToPath) {
    if ( !(Get-DoesExistInEnvPath $path) ) {
        Write-Output "$path added to PATH"
        Add-EnvPath $path
    }
}


# load bitwarden stuff
$email = Read-Host "Bitwarden Email" -AsSecureString
$email_plaintext = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($email))
[Environment]::SetEnvironmentVariable("BW_EMAIL", $email_plaintext, "User")
$pwd = Read-Host "Bitwarden Master Password" -AsSecureString
$pwd_plaintext = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pwd))
[Environment]::SetEnvironmentVariable("BW_PW", $pwd_plaintext, "User")