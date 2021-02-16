<#PSScriptInfo
.VERSION     1.0.0
.DESCRIPTION Reset AD account password and set AD user parameters.
.AUTHOR      Violet Haze Roś (code@unsola.ci)
.COPYRIGHT   Copyright (C) Violet Haze Roś (code@unsola.ci)
.LICENSEURI  http://www.apache.org/licenses/LICENSE-2.0
.GUID        074fbf1f-95a3-4cb2-a8f8-9993ca60a2a8
#>
#Requires -Modules ActiveDirectory

<#
.SYNOPSIS
    Reset AD account password and set AD user parameters.
    Basically, a quick command line version of Active Directory Users and
    Computers'(dsa.msc) password reset dialog.
.EXAMPLE
    & .\Reset-ADAccountPassword.ps1 -Identity johndoe -NewPassword "P@$$w0rd" -Unlock -MustChangePasswordAtLogon
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)][Microsoft.ActiveDirectory.Management.ADUser]$Identity,
    # Set new password for the account without providing old one
    [Parameter(Mandatory = $true)][SecureString]$NewPassword,
    # Unlock AD account
    [switch]$Unlock,
    # Set ChangePasswordAtLogon flag to $true
    [switch]$MustChangePasswordAtLogon
)

$ADUser = Get-ADUser -Identity $Identity

Set-ADAccountPassword `
    -Identity $ADUser `
    -Reset `
    -NewPassword $NewPassword

if ($Unlock.IsPresent) {
    Unlock-ADAccount -Identity $ADUser
}

if ($MustChangePasswordAtLogon.IsPresent) {
    Set-ADUser `
        -Identity $ADUser `
        -ChangePasswordAtLogon $true
}
