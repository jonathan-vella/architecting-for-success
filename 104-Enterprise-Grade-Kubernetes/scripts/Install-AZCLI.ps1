# install oz cli if you don't have it installed locally
#Start-Process "https://go.azuredemos.net/docs-iac"

# you can use Azure shell which has all the tools installed 
# Start-Process "https://shell.azure.com" 

## below instructions for installation procedure with powershell on LOCAL machine 
$answer = Read-Host "Press ENTER to start installing AZ CLI (y/n)"
if ($answer -eq "y")
{
    $ProgressPreference = 'SilentlyContinue';
    Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi;
    Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet';

    ## cleanup of Azure CLI
    Remove-Item .\AzureCLI.msi
}
# test out if your solution is working
az login
#check the subscription
az account list --output table

#set the installation of extensions without prompt
az config set extension.use_dynamic_install=yes_without_prompt

# continue with next steps
Write-Host "Done with login and initial step, continue to next step"
