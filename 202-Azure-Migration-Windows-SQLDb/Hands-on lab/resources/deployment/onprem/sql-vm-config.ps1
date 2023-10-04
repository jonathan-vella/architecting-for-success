<# 
Microsoft Cloud Workshop

.What does this script do?  
 - Initializes a new data disk, formats and give the letter C:\ and creates Backup, Data and Logs directories
    
 - Sets SQL Configs: Directories made as defaults, Enables TCP, Eables Mixed Authentication SA Account

 - Downloads the WideWorldImporters Database as a Backup Device, then Restores the Database

 - Adds the Domain Built-In Administrators to the SYSADMIN group

 - Changes to Recovery type of the DB to "Full Recovery" and then performs a Backup to meet the requirements of AOG

 - Opens three Firewall ports in support of the AOG:  1433 (default SQL), 5022 (HADR Listener), 59999 (Internal Loadbalacer Probe)

#>

Configuration Main
{

Import-DscResource -ModuleName PSDesiredStateConfiguration

Node "localhost"
  {
    Script ConfigureSql
    {
        TestScript = {
            return $false
        }
        SetScript ={
		# $disk = Get-Disk | where-object PartitionStyle -eq "RAW"
		# $disk | Initialize-Disk -PartitionStyle MBR -PassThru -confirm:$false
		# $partition = $disk | New-Partition -UseMaximumSize -DriveLetter F
		# $partition | Format-Volume -Confirm:$false -Force
	
		Start-Sleep -Seconds 60

		$logs = "C:\Logs"
		$data = "C:\Data"
		$backups = "C:\Backup" 
		[system.io.directory]::CreateDirectory($logs)
		[system.io.directory]::CreateDirectory($data)
		[system.io.directory]::CreateDirectory($backups)
		
		# Setup the data, backup and log directories as well as mixed mode authentication
		Import-Module "sqlps" -DisableNameChecking
		[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
		$sqlesq = new-object ('Microsoft.SqlServer.Management.Smo.Server') Localhost
		$sqlesq.Settings.LoginMode = [Microsoft.SqlServer.Management.Smo.ServerLoginMode]::Mixed
		$sqlesq.Settings.DefaultFile = $data
		$sqlesq.Settings.DefaultLog = $logs
		$sqlesq.Settings.BackupDirectory = $backups
		$sqlesq.Alter() 

		# Enable TCP Server Network Protocol
		$smo = 'Microsoft.SqlServer.Management.Smo.'  
		$wmi = new-object ($smo + 'Wmi.ManagedComputer').  
		$uri = "ManagedComputer[@Name='" + (get-item env:\computername).Value + "']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']"  
		$Tcp = $wmi.GetSmoObject($uri)  
		$Tcp.IsEnabled = $true  
		$Tcp.Alter() 

		# Restart the SQL Server service
		Restart-Service -Name "MSSQLSERVER" -Force

		# Re-enable the sa account and set a new password to enable login
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER LOGIN sa ENABLE"
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER LOGIN sa WITH PASSWORD = 'demo!pass123'"

		# Get the database backup 
		$dbsource = "https://github.com/microsoft/MCW-Building-the-business-migration-case-with-Windows-Server-and-SQL-Server/raw/main/Hands-on%20lab/resources/deployment/onprem/database.bak"
		$dbdestination = "C:\database.bak"
		
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		Invoke-WebRequest $dbsource -OutFile $dbdestination

		$mdf = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("AdventureWorks2008R2_Data", "C:\Data\WideWorldImporters.mdf")
		$ldf = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("AdventureWorks2008R2_Log", "C:\Logs\WideWorldImporters.ldf")

		# Restore the database from the backup
		Restore-SqlDatabase -ServerInstance Localhost -Database WideWorldImporters `
						    -BackupFile $dbdestination -RelocateFile @($mdf,$ldf) -ReplaceDatabase

		#Add local administrators group as sysadmin
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "CREATE LOGIN [BUILTIN\Administrators] FROM WINDOWS"
		Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER SERVER ROLE sysadmin ADD MEMBER [BUILTIN\Administrators]"

		# Put the database into full recovery and run a backup (required for SQL AG)
        Invoke-Sqlcmd -ServerInstance Localhost -Database "master" -Query "ALTER DATABASE WideWorldImporters SET RECOVERY FULL"
		Backup-SqlDatabase -ServerInstance Localhost -Database WideWorldImporters
	
		# Build Firewall Rules for SQL & AOG
		New-NetFirewallRule -DisplayName "SQL Server" -Direction Inbound -Protocol TCP -LocalPort 1433 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Endpoint" -Direction Inbound -Protocol TCP -LocalPort 5022 -Action allow 
		New-NetFirewallRule -DisplayName "SQL AG Load Balancer Probe Port" -Direction Inbound -Protocol TCP -LocalPort 59999 -Action allow
			}
        GetScript = {@{Result = "ConfigureSql"}
	  }
	}
  }
}