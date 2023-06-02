# Detect-ChromeMSDefenderPolicies.ps1 Intune Proactive Remediation detection script
# For the Microsoft Defender Browser Protection for Chrome extension, disable toggling protection off, and bypassing blocks.
# Reference: https://textslashplain.com/2023/05/31/improving-the-microsoft-defender-browser-protection-extension/
# Written by Doug Howell on 2023-06-01

$Title = "Microsoft Defender Browser Protection for Chrome extension"
$Path = "HKLM:\SOFTWARE\Policies\Google\Chrome\3rdParty\Extensions\bkbeeeffjjeopflfhgeknacdieedcoml\policy"
$KeyName1 = "HideProtectionToggle"
$Value1 = 1
$KeyName2 = "PreventBlockOverride"
$Value2 = 1

try {
    $Registry1 = Get-ItemProperty -Path $Path -Name $KeyName1 -ErrorAction Stop | Select-Object -ExpandProperty $KeyName1
    $Registry2 = Get-ItemProperty -Path $Path -Name $KeyName2 -ErrorAction Stop | Select-Object -ExpandProperty $KeyName2
    
    if ($Registry1 -eq $Value1 -and $Registry2 -eq $Value2) {
        Write-Output "$Title keys are compliant ($KeyName1 = $Value1, $KeyName2 = $Value2)"
        Exit 0
    } 
    
    if ($Registry1 -ne $null) {
        Write-Warning "$Title key $KeyName1 is not compliant ($KeyName1 = $Registry1)"
    }
    else {
        Write-Warning "$Title key $KeyName1 is not compliant"
    }
    
    if ($Registry2 -ne $null) {
        Write-Warning "$Title key $KeyName2 is not compliant ($KeyName2 = $Registry2)"
    }
    else {
        Write-Warning "$Title key $KeyName2 is not compliant"
    }
    
    Exit 1
}

catch {
    Write-Warning "$error"
    Exit 1
}
