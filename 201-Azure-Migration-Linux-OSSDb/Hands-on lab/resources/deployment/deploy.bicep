@description('The prefix base used to name resources created.')
param resourceNameBase string = 'terrafirm'


var location = resourceGroup().location

var onpremNamePrefix = '${resourceNameBase}-onprem-'
var hubNamePrefix = '${resourceNameBase}-hub-'
var spokeNamePrefix = '${resourceNameBase}-spoke-'

var onpremWorkloadVMNamePrefix = '${onpremNamePrefix}workload-'

var GitHubScriptRepo = 'microsoft/MCW-Building-the-business-migration-case-with-Linux-and-OSS-DB-to-Azure'
var GitHubScriptRepoBranch = 'main'
var GitHubScriptRepoBranchURL = 'https://raw.githubusercontent.com/${GitHubScriptRepo}/${GitHubScriptRepoBranch}/Hands-on lab/resources/deployment/'

var WorkloadInstallScriptFileName = 'workload-install.sh'
var WorkloadInstallScriptURL = '${GitHubScriptRepoBranchURL}onprem/${WorkloadInstallScriptFileName}'

var labUsername = 'demouser'
var labPassword = 'demo!pass123'

var tags = {
    purpose: 'MCW'
}

/* ****************************
Virtual Networks
**************************** */

resource onprem_vnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
    name: '${onpremNamePrefix}vnet'
    location: location
    tags: tags
    properties: {
        addressSpace: {
            addressPrefixes: [
                '10.0.0.0/16'
            ]
        }
        subnets: [
            {
                name: 'default'
                properties: {
                    addressPrefix: '10.0.0.0/24'
                }
            }
        ]
    }
}

resource hub_vnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
    name: '${hubNamePrefix}vnet'
    location: location
    tags: tags
    properties: {
        addressSpace: {
            addressPrefixes: [
                '10.1.0.0/16'
            ]
        }
        subnets: [
            {
                name: 'hub'
                properties: {
                    addressPrefix: '10.1.0.0/24'
                }
            }
            {
                name: 'AzureBastionSubnet'
                properties: {
                    addressPrefix: '10.1.1.0/24'
                }
            }
        ]
    }
}

resource spoke_vnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
    name: '${spokeNamePrefix}vnet'
    location: location
    tags: tags
    properties: {
        addressSpace: {
            addressPrefixes: [
                '10.2.0.0/16'
            ]
        }
        subnets: [
            {
                name: 'default'
                properties: {
                    addressPrefix: '10.2.0.0/24'
                }
            }
        ]
    }
}

/* ****************************
Virtual Network Peerings
**************************** */

resource hub_onprem_vnet_peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-11-01' = {
    name: '${hub_vnet.name}/hub-onprem'
    properties: {
        remoteVirtualNetwork: {
            id: onprem_vnet.id
        }
        allowVirtualNetworkAccess: true
        allowForwardedTraffic: true
        remoteAddressSpace: {
            addressPrefixes: [
                '10.0.0.0/16'
            ]
        }
    }
}

resource onprem_hub_vnet_peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-11-01' = {
    name: '${onprem_vnet.name}/onprem-hub'
    properties: {
        remoteVirtualNetwork: {
            id: hub_vnet.id
        }
        allowVirtualNetworkAccess: true
        allowForwardedTraffic: true
        remoteAddressSpace: {
            addressPrefixes: [
                '10.1.0.0/16'
            ]
        }
    }
}

resource spoke_hub_vnet_peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-11-01' = {
    name: '${spoke_vnet.name}/spoke-hub'
    properties: {
        remoteVirtualNetwork: {
            id: hub_vnet.id
        }
        allowVirtualNetworkAccess: true
        allowForwardedTraffic: true
        remoteAddressSpace: {
            addressPrefixes: [
                '10.1.0.0/16'
            ]
        }
    }
}

/* ****************************
Azure Bastion
**************************** */

resource hub_bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
    name: '${hubNamePrefix}bastion'
    location: location
    tags: tags
    sku: {
        name: 'Standard'
    }
    properties: {
        ipConfigurations: [
            {
                name: 'IpConf'
                properties: {
                    privateIPAllocationMethod: 'Dynamic'
                    publicIPAddress: {
                        id: hub_bastion_public_ip.id
                    }
                    subnet: {
                        id: '${hub_vnet.id}/subnets/AzureBastionSubnet'
                    }
                }
            }
        ]
    }

}

resource hub_bastion_public_ip 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
    name: '${hubNamePrefix}bastion-pip'
    location: location
    tags: tags
    sku: {
        name: 'Standard'
        tier: 'Regional'
    }
    properties: {
        publicIPAddressVersion: 'IPv4'
        publicIPAllocationMethod: 'Static'
    }
}

/* ****************************
On-premises Workload VM
**************************** */

resource onprem_workload_nic 'Microsoft.Network/networkInterfaces@2021-03-01' = {
    name: '${onpremWorkloadVMNamePrefix}nic'
    location: location
    tags: tags
    properties: {
        ipConfigurations: [
            {
                name: 'ipconfig1'
                properties: {
                    publicIPAddress: {
                        id: '${onprem_workload_public_ip.id}'
                    }
                    subnet: {
                        id: '${onprem_vnet.id}/subnets/default'
                    }
                    privateIPAllocationMethod: 'Dynamic'
                }
            }
        ]
        networkSecurityGroup: {
            id: onprem_workload_nsg.id
        }
    }
}

resource onprem_workload_public_ip 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
    name: '${onpremWorkloadVMNamePrefix}pip'
    location: location
    tags: tags
    sku: {
        name: 'Standard'
        tier: 'Regional'
    }
    properties: {
        publicIPAddressVersion: 'IPv4'
        publicIPAllocationMethod: 'Static'
    }
}

resource onprem_workload_nsg 'Microsoft.Network/networkSecurityGroups@2019-02-01' = {
    name: '${onpremWorkloadVMNamePrefix}nsg'
    location: location
    tags: tags
    properties: {
        securityRules: [
            {
                name: 'SSH'
                properties: {
                    protocol: 'TCP'
                    sourcePortRange: '*'
                    destinationPortRange: '22'
                    sourceAddressPrefix: '*'
                    destinationAddressPrefix: '*'
                    access: 'Allow'
                    priority: 100
                    direction: 'Inbound'
                }
            }
            {
                name: 'MySQL'
                properties: {
                    protocol: 'TCP'
                    sourcePortRange: '*'
                    destinationPortRange: '3306'
                    sourceAddressPrefix: '*'
                    destinationAddressPrefix: '*'
                    access: 'Allow'
                    priority: 200
                    direction: 'Inbound'
                }
            }
            {
                name: 'HTTP'
                properties: {
                    protocol: 'TCP'
                    sourcePortRange: '*'
                    destinationPortRange: '80'
                    sourceAddressPrefix: '*'
                    destinationAddressPrefix: '*'
                    access: 'Allow'
                    priority: 300
                    direction: 'Inbound'
                }
            }
        ]
    }
}

resource onprem_workload_vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
    name: '${onpremWorkloadVMNamePrefix}vm'
    location: location
    tags: tags
    properties: {
        hardwareProfile: {
            vmSize: 'Standard_D4s_v5'
        }
        storageProfile: {
            osDisk: {
                osType: 'Linux'
                createOption: 'fromImage'
            }
            imageReference: {
                publisher: 'RedHat'
                offer: 'RHEL'
                sku: '90-gen2'
                version: 'latest'
            }
        }
        networkProfile: {
            networkInterfaces: [
                {
                    id: onprem_workload_nic.id
                }
            ]
        }
        osProfile: {
            computerName: '${onpremWorkloadVMNamePrefix}vm'
            adminUsername: labUsername
            adminPassword: labPassword
            linuxConfiguration: {
                disablePasswordAuthentication: false
            }
        }
    }
}

resource onprem_workload_vm_ext_installscript 'Microsoft.Compute/virtualMachines/extensions@2019-03-01' = {
    name: '${onprem_workload_vm.name}/InstallScript'
    location: location
    tags: tags
    dependsOn: [
        onprem_workload_vm
    ]
    properties: {
        publisher: 'Microsoft.Azure.Extensions'
        type: 'CustomScript'
        typeHandlerVersion: '2.1'
        autoUpgradeMinorVersion: true
        settings: {
            fileUris: [
                WorkloadInstallScriptURL
            ]
            commandToExecute: 'sh ${WorkloadInstallScriptFileName}'
        }
    }
}
