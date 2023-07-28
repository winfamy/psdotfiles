function Add-EnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [string] $Path,

        [ValidateSet('Machine', 'User', 'Session')]
        [string] $Container = 'Session'
    )

    if ($Container -ne 'Session') {
        $containerMapping = @{
            Machine = [EnvironmentVariableTarget]::Machine
            User = [EnvironmentVariableTarget]::User
        }
        $containerType = $containerMapping[$Container]

        $persistedPaths = [Environment]::GetEnvironmentVariable('Path', $containerType) -split ';'
        if ($persistedPaths -notcontains $Path) {
            $persistedPaths = $persistedPaths + $Path | where { $_ }
            [Environment]::SetEnvironmentVariable('Path', $persistedPaths -join ';', $containerType)
        }
    }

    $envPaths = $env:Path -split ';'
    if ($envPaths -notcontains $Path) {
        $envPaths = $envPaths + $Path | where { $_ }
        $env:Path = $envPaths -join ';'
    }
}

function Get-EnvPath {
    $envPaths = $env:Path -split ';'
    return $envPaths
}

function Get-DoesExistInEnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [string] $Path
    )

    $envPaths = Get-EnvPath
    foreach ($envPath in $envPaths) {
        if ($envPath.ToUpper() -eq $Path.ToUpper()) {
            return $true;
        }
    }

    return $false;
}