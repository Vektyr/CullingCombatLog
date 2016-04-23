$log = "$env:USERPROFILE\AppData\Local\Victory\Saved\Logs\Victory.log"

# Find occurences of "You Hit" or "Struck by"
$terms = "(You Hit)|(Struck by)"

# Background color
$host.UI.RawUI.BackgroundColor = "black"

# Color the occurences while in file stream
function Get-CombatColor {
    Param([Parameter(Position=0)]
    [String]$logEntry)

    process {
        if ($logEntry.Contains("You Hit")) {Return "Green"}
        elseif ($logEntry.Contains("Struck by")) {Return "Red"}
        else {Return "White"}
    }
}

cls
Write-Host -ForegroundColor Yellow " - - - - - - - - - - - - - - - - - - - - - -"
Write-Host -ForegroundColor Yellow " - - - The Culling: Live Combat Logger - - -"
Write-Host -ForegroundColor Yellow " - - - - - - - - - - - - - - - - - - - - - -"
Write-Host -ForegroundColor Yellow "Loaded, go punch someone."

# File stream
Get-Content $log -Tail 1 -Wait | 
Where-Object { $_ -match $terms } | 
ForEach-Object { 
    Write-Host -ForegroundColor (Get-CombatColor $_) ($_ -replace ".*:"); 
}
