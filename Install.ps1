$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$testadmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
if ($testadmin -eq $false) {
    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    exit $LASTEXITCODE
}
$modulePath =  ($Env:PSModulePath.Split(";") | Where-Object { $_ -like "*Program Files\WindowsPowerShell\Modules*"}) +  "\KYC-CLI\"
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Copy-Item "$($scriptDir)\KYC-CLI" -Recurse -Destination $modulePath -Force
Import-Module -Name "KYC-CLI" -Force
#PS Remove-Module -Name KYC-CLI
#PS Uninstall-Module -Name KYC-CLI
