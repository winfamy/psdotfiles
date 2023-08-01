# Author: 2d Lt Grady Phillips
# Grady's Powershell Profile

$ErrorActionPreference= 'silentlycontinue'

# this allows bitwarden to connect via API even tho SSL connections dont work right
$env:NODE_TLS_REJECT_UNAUTHORIZED = 0
$env:NODE_NO_WARNINGS = 1

$session_key = bw unlock --passwordenv "BW_PW" --raw
$env:BW_SESSION = $session_key

Import-Module Discord -DisableNameChecking

Set-Alias -Name "disc" -Value Launch-Discord