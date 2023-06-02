# Remediate-ChromeMSDefenderPolicies.ps1 Intune Proactive Remediation remediation script
# For the Microsoft Defender Browser Protection for Chrome extension, disable toggling proteciton off, and bypassing blocks.
# Reference: https://textslashplain.com/2023/05/31/improving-the-microsoft-defender-browser-protection-extension/
# Written by Doug Howell on 2023-06-01

$Title = "Microsoft Defender Browser Protection for Chrome extension"
$Path = "HKLM:\SOFTWARE\Policies\Google\Chrome\3rdParty\Extensions\bkbeeeffjjeopflfhgeknacdieedcoml\policy"
$KeyName1 = "HideProtectionToggle"
$Type1 = "DWORD"
$Value1 = 1
$KeyName2 = "PreventBlockOverride"
$Type2 = "DWORD"
$Value2 = 1

try {
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force -ErrorAction "SilentlyContinue" | Out-Null
    }

    Set-ItemProperty -Path $Path -Name $KeyName1 -Type $Type1 -Value $Value1
    Set-ItemProperty -Path $Path -Name $KeyName2 -Type $Type2 -Value $Value2

    Write-Host "$Title keys $KeyName1 and $KeyName2 remediation succeeded"
    Exit 0
}
catch {
    Write-Warning "$($_.Exception.Message)"
    Exit 1
}
