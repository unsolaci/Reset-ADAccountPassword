<#PSScriptInfo
.VERSION     1.1.0
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
    & .\Reset-ADAccountPassword.ps1 -Identity johndoe -NewPassword (Read-Host -Prompt "NewPassword" -AsSecureString) -Unlock -MustChangePasswordAtLogon
.EXAMPLE
    & .\Reset-ADAccountPassword.ps1 -Identity johndoe -NewPassword "P@$$w0rd" -AsPlainText -Force -MustChangePasswordAtLogon
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)][Microsoft.ActiveDirectory.Management.ADUser]$Identity,
    # Set new password for the account without providing old one
    $NewPassword,
    # Specify a plain text password instead of secure string
    [switch]$AsPlainText,
    # Confirm that you understand the implications of using the AsPlainText parameter and still want to use it
    [switch]$Force,
    # Unlock AD account
    [switch]$Unlock,
    # Set ChangePasswordAtLogon flag to $true
    [switch]$MustChangePasswordAtLogon
)

$ADUser = Get-ADUser -Identity $Identity
if ( ! $NewPassword ) {
    if ($AsPlainText.IsPresent) {
        Write-Verbose -Message "NewPassword not specified, ignoring AsPlainText parameter."
    }
    $NewPassword = Read-Host -Prompt "NewPassword" -AsSecureString
}

if ($NewPassword.GetType().Name -eq "SecureString") {
    Set-ADAccountPassword `
    -Identity $ADUser `
    -Reset `
    -NewPassword $NewPassword
} elseif ($NewPassword.GetType().Name -eq "String") {
    if ($AsPlainText.IsPresent) {
        if ($Force.IsPresent) {
            Set-ADAccountPassword `
                -Identity $ADUser `
                -Reset `
                -NewPassword ( `
                    ConvertTo-SecureString `
                        -AsPlainText `
                        -Force `
                        -String $NewPassword `
                )
        } else {
            Write-Error `
                -Message "The system cannot protect plain text input. To suppress this warning and convert the plain text to a SecureString, reissue the command specifying the Force parameter."
        }
    }
}

if ($Unlock.IsPresent) {
    Unlock-ADAccount -Identity $ADUser
}

if ($MustChangePasswordAtLogon.IsPresent) {
    Set-ADUser `
        -Identity $ADUser `
        -ChangePasswordAtLogon $true
}
