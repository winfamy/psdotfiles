Function Get-DiscordTfa() {
    bw get totp discord
}

Function Open-DiscordTab() {
    start microsoft-edge:https://safe.menlosecurity.com/https://discord.com/login
    $wshell = New-Object -ComObject wscript.shell;
    $wshell.AppActivate('Edge')
}

Function Launch-Discord() {
    Set-Clipboard -Value (Get-DiscordTfa)
    Open-DiscordTab
}