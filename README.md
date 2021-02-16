# Reset-ADAccountPassword.ps1
## SYNOPSIS
Reset AD account password and set AD user parameters.
Basically, a quick command line version of Active Directory Users and
Computers'(dsa.msc) password reset dialog.


## SYNTAX
```powershell
.\Reset-ADAccountPassword.ps1 [-Identity] <ADUser> [[-NewPassword] <Object>] [-AsPlainText] [-Force] [-Unlock] [-MustChangePasswordAtLogon] [<CommonParameters>]
```


## PARAMETERS
### -Identity <ADUser>
Active Directory user object to perform operations on

### -NewPassword <Object>
Set new password for the account without providing old one

### -AsPlainText <SwitchParameter>
Specify a plain text password instead of secure string

### -Force <SwitchParameter>
Confirm that you understand the implications of using the AsPlainText parameter and still want to use it

### -Unlock <SwitchParameter>
Unlock AD account

### -MustChangePasswordAtLogon <SwitchParameter>
Set ChangePasswordAtLogon flag to $true


## EXAMPLES
### EXAMPLE 1
```powershell
PS C:\>& .\Reset-ADAccountPassword.ps1 -Identity johndoe -NewPassword (Read-Host -Prompt 'NewPassword' -AsSecureString) -Unlock -MustChangePasswordAtLogon
```

### EXAMPLE 2
```powershell
PS C:\>& .\Reset-ADAccountPassword.ps1 -Identity johndoe -NewPassword 'P@$$w0rd' -AsPlainText -Force -MustChangePasswordAtLogon
```
