<# 
.What does this script do?  
 - Downloads NuGet package provider
 - Installs the DscResource and xHyper-V PS modules in support of the upcoming DSC Extenion run in HyperVHostConfig.ps1
 - Installs Hyper-V with all Features and Management Tools and then Restarts the Machine
#>

# Set PowerShell Execution Policy
Set-ExecutionPolicy Unrestricted -Force

# ###########################
# Install Git
# ###########################
# get latest download url for git-for-windows 64-bit exe
$git_url = "https://api.github.com/repos/git-for-windows/git/releases/latest"
$asset = Invoke-RestMethod -Method Get -Uri $git_url | % assets | where name -like "*64-bit.exe"
# download installer
$installer = "$env:temp\$($asset.name)"
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $installer
# run installer
$install_args = "/SP- /VERYSILENT /SUPPRESSMSGBOXES /NOCANCEL /NORESTART /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS"
Start-Process -FilePath $installer -ArgumentList $install_args -Wait

# ###########################
# Enable Internet Sharing
# ###########################
Set-Service -Name SharedAccess -StartupType Automatic
Start-Service -Name SharedAccess


# Register the HNetCfg library (once)
regsvr32 /s hnetcfg.dll

# Create a NetSharingManager object
$m = New-Object -ComObject HNetCfg.HNetShare

# List connections
$m.EnumEveryConnection |% { $m.NetConnectionProps.Invoke($_) }

# Find connection
$c = $m.EnumEveryConnection |? { $m.NetConnectionProps.Invoke($_).Name -eq "Ethernet" }

# Enable sharing (0 - public, 1 - private)
$config = $m.INetSharingConfigurationForINetConnection.Invoke($c)

$config.EnableSharing(0) # public sharing


# ###########################
# ###########################

# Enable TLS 1.2 Strong Cryptography in .NET Framework 4.5 or higher
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install Nuget
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

Find-Module -Includes DscResource -Name xHyper-v | Install-Module -Force

# Install Hyper-V and Reboot
Install-WindowsFeature -Name Hyper-V `
                       -IncludeAllSubFeature `
                       -IncludeManagementTools `
                       -Verbose `
                       -Restart

