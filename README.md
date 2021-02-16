# Reset-ADAccountPassword.ps1
## SYNOPSIS
Reset AD account password and set AD user parameters.
Basically, a quick command line version of Active Directory Users and
Computers'(dsa.msc) password reset dialog.


## SYNTAX
```powershell
.\Reset-ADAccountPassword.ps1 [-Identity] <ADUser> [-NewPassword] <SecureString> [-Unlock] [-MustChangePasswordAtLogon] [<CommonParameters>]
```


## PARAMETERS
### -Identity <ADUser>
Active Directory user object to perform operations on

### -NewPassword <SecureString>
Set new password for the account without providing old one

### -Unlock <SwitchParameter>
Unlock AD account

### -MustChangePasswordAtLogon <SwitchParameter>
Set ChangePasswordAtLogon flag to $true


## EXAMPLES
### EXAMPLE 1
```powershell
PS C:\>& .\Reset-ADAccountPassword.ps1 -Identity johndoe -NewPassword "P@$$w0rd" -Unlock -MustChangePasswordAtLogon
```
