@description('The prefix base used to name resources created.')
param resourceNameBase string = 'tailspin'

@description('The Id of the Azure AD User')
param azureAdUserId string
@description('The Login of the Azure AD User (ex: username@domain.onmicrosoft.com)')
param azureAdUserLogin string

var location = 'northcentralus' /* resourceGroup().location */

var onpremNamePrefix = '${resourceNameBase}-onprem-'
var hubNamePrefix = '${resourceNameBase}-hub-'
var spokeNamePrefix = '${resourceNameBase}-spoke-'
var sqlmiPrefix = '${resourceNameBase}-sqlmi'
var sqlmiStorageName = '${resourceNameBase}sqlmistorage'

var onpremSQLVMNamePrefix = '${onpremNamePrefix}sql-'
var onpremHyperVHostVMNamePrefix = '${onpremNamePrefix}hyperv-'

var GitHubScriptRepo = 'microsoft/MCW-Building-the-business-migration-case-with-Windows-Server-and-SQL-Server'
var GitHubScriptRepoBranch = 'main'
var GitHubScriptRepoBranchURL = 'https://raw.githubusercontent.com/${GitHubScriptRepo}/${GitHubScriptRepoBranch}/Hands-on lab/resources/deployment/'

var HyperVHostConfigArchiveFileName = 'create-vm.zip'
var HyperVHostConfigArchiveScriptName = 'create-vm.ps1'
var HyperVHostConfigURL = '${GitHubScriptRepoBranchURL}onprem/${HyperVHostConfigArchiveFileName}'

var HyperVHostInstallHyperVScriptFolder = '.'
var HyperVHostInstallHyperVScriptFileName = 'install-hyper-v.ps1'
var HyperVHostInstallHyperVURL = '${GitHubScriptRepoBranchURL}onprem/${HyperVHostInstallHyperVScriptFileName}'

var SQLVMConfigFileName = 'sql-vm-config.zip'
var SQLVMConfigScriptName = 'sql-vm-config.ps1'
var SQLVMConfigURL = '${GitHubScriptRepoBranchURL}onprem/${SQLVMConfigFileName}'

var labUsername = 'demouser'
var labPassword = 'demo!pass123'
var labSqlMIPassword = 'demo!pass1234567'

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
            {
                name: 'AzureSQLMI'
                properties: {
                    addressPrefix: '10.2.1.0/24'
                    networkSecurityGroup: {
                        id: sqlmi_subnet_nsg.id
                    }
                    routeTable: {
                        id: sqlmi_subnet_routetable.id
                    }
                    delegations: [
                        {
                            name: 'AzureSQLMI'
                            properties: {
                                serviceName: 'Microsoft.Sql/managedInstances'
                            }
                            type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
                        }
                    ]
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
Azure SQL Managed Instance
**************************** */

resource sqlmi_storage 'Microsoft.Storage/storageAccounts@2022-05-01' = {
    name: sqlmiStorageName
    location: location
    sku: {
        name: 'Standard_RAGRS'
    }
    kind: 'StorageV2'
    properties: {
        accessTier: 'Hot'
    }
}

resource sqlmi_storage_container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-05-01' = {
    name: '${sqlmi_storage.name}/default/sql-backup'
    properties: {
        publicAccess: 'None'
    }
}


resource sqlmi 'Microsoft.Sql/managedInstances@2021-05-01-preview' = {
    name: sqlmiPrefix
    location: location
    dependsOn: [
        sqlmi_subnet_nsg
    ]
    sku: {
        name: 'GP_Gen5'
        tier: 'GeneralPurpose'
    }
    identity: {
        type: 'SystemAssigned'
    }
    properties: {
        subnetId: '${spoke_vnet.id}/subnets/AzureSQLMI'
        storageSizeInGB: 64
        vCores: 8
        licenseType: 'LicenseIncluded'
        hardwareFamily: 'Gen5'
        zoneRedundant: false
        minimalTlsVersion: '1.2'
        requestedBackupStorageRedundancy: 'Geo'
        administratorLogin: labUsername
        administratorLoginPassword: labSqlMIPassword
        administrators: {
            administratorType: 'ActiveDirectory'
            principalType: 'User'
            login: azureAdUserLogin
            sid: azureAdUserId
            tenantId: subscription().tenantId
            azureADOnlyAuthentication: false
        }
    }
}


resource sqlmi_subnet_routetable 'Microsoft.Network/routeTables@2022-01-01'= {
    name: '${sqlmiPrefix}-rt'
    location: location
    properties: {
        routes: [
            {
                name: 'SqlManagement_0'
                properties: {
                    addressPrefix: '65.55.188.0/24'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_1'
                properties: {
                    addressPrefix: '207.68.190.32/27'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_2'
                properties: {
                    addressPrefix: '13.106.78.32/27'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_3'
                properties: {
                    addressPrefix: '13.106.174.32/27'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_4'
                properties: {
                    addressPrefix: '13.106.4.96/27'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_5'
                properties: {
                    addressPrefix: '104.214.108.80/32'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_6'
                properties: {
                    addressPrefix: '52.179.184.76/32'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_7'
                properties: {
                    addressPrefix: '52.187.116.202/32'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_8'
                properties: {
                    addressPrefix: '52.177.202.6/32'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_9'
                properties: {
                    addressPrefix: '23.98.55.75/32'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_10'
                properties: {
                    addressPrefix: '23.96.178.199/32'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_11'
                properties: {
                    addressPrefix: '52.162.107.128/27'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_12'
                properties: {
                    addressPrefix: '40.74.254.227/32'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_13'
                properties: {
                    addressPrefix: '23.96.185.63/32'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_14'
                properties: {
                    addressPrefix: '65.52.59.57/32'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'SqlManagement_15'
                properties: {
                    addressPrefix: '168.62.244.242/32'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_subnet-10-2-1-0-24-to-vnetlocal'
                properties: {
                    addressPrefix: '10.2.1.0/24'
                    nextHopType: 'VnetLocal'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-Storage'
                properties: {
                    addressPrefix: 'Storage'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-SqlManagement'
                properties: {
                    addressPrefix: 'SqlManagement'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-AzureMonitor'
                properties: {
                    addressPrefix: 'AzureMonitor'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-CorpNetSaw'
                properties: {
                    addressPrefix: 'CorpNetSaw'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-CorpNetPublic'
                properties: {
                    addressPrefix: 'CorpNetPublic'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-AzureActiveDirectory'
                properties: {
                    addressPrefix: 'AzureActiveDirectory'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-AzureCloud.northcentralus'
                properties: {
                    addressPrefix: 'AzureCloud.northcentralus'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-AzureCloud.southcentralus'
                properties: {
                    addressPrefix: 'AzureCloud.southcentralus'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-Storage.northcentralus'
                properties: {
                    addressPrefix: 'Storage.northcentralus'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-Storage.southcentralus'
                properties: {
                    addressPrefix: 'Storage.southcentralus'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-EventHub.northcentralus'
                properties: {
                    addressPrefix: 'EventHub.northcentralus'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-EventHub.southcentralus'
                properties: {
                    addressPrefix: 'EventHub.southcentralus'
                    nextHopType: 'Internet'
                    hasBgpOverride: false
                }
            }
        ]
    }
}


resource sqlmi_subnet_nsg 'Microsoft.Network/networkSecurityGroups@2022-01-01' = {
    name: '${sqlmiPrefix}-nsg'
    location: location
    properties: {
        securityRules: [
            {
                name: 'allow_tds_inbound'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow access to data via TDS'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '1433'
                    sourceAddressPrefix: 'VirtualNetwork'
                    destinationAddressPrefix: '10.2.1.0/24'
                    access: 'Allow'
                    priority: 1000
                    direction: 'Inbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'allow_redirect_inbound'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow inbound TDS redirect traffic to Managed Instance inside the virtual network'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '11000-11999'
                    sourceAddressPrefix: 'VirtualNetwork'
                    destinationAddressPrefix: '10.2.1.0/24'
                    access: 'Allow'
                    priority: 1100
                    direction: 'Inbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'allow_geodr_inbound'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow inbound GeoDR traffic inside the virtual network'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '5022'
                    sourceAddressPrefix: 'VirtualNetwork'
                    destinationAddressPrefix: '10.2.1.0/24'
                    access: 'Allow'
                    priority: 1200
                    direction: 'Inbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'deny_all_inbound'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Deny all other inbound traffic'
                    protocol: '*'
                    sourcePortRange: '*'
                    destinationPortRange: '*'
                    sourceAddressPrefix: '*'
                    destinationAddressPrefix: '*'
                    access: 'Deny'
                    priority: 4096
                    direction: 'Inbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'allow_linkedserver_outbound'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow outbound linked server traffic inside the virtual network'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '1433'
                    sourceAddressPrefix: '10.2.1.0/24'
                    destinationAddressPrefix: 'VirtualNetwork'
                    access: 'Allow'
                    priority: 1000
                    direction: 'Outbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'allow_redirect_outbound'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow outbound TDS redirect traffic from Managed Instance inside the virtual network'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '11000-11999'
                    sourceAddressPrefix: '10.2.1.0/24'
                    destinationAddressPrefix: 'VirtualNetwork'
                    access: 'Allow'
                    priority: 1100
                    direction: 'Outbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'allow_geodr_outbound'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow outbound GeoDR traffic inside the virtual network'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '5022'
                    sourceAddressPrefix: '10.2.1.0/24'
                    destinationAddressPrefix: 'VirtualNetwork'
                    access: 'Allow'
                    priority: 1200
                    direction: 'Outbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'allow_privatelink_outbound'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow outbound Private Link traffic inside the virtual network'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '443'
                    sourceAddressPrefix: '10.2.1.0/24'
                    destinationAddressPrefix: 'VirtualNetwork'
                    access: 'Allow'
                    priority: 1300
                    direction: 'Outbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'allow_azurecloud_outbound'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow outbound traffic to Azure Cloud, port 443'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '443'
                    sourceAddressPrefix: '10.2.1.0/24'
                    destinationAddressPrefix: 'VirtualNetwork'
                    access: 'Allow'
                    priority: 1400
                    direction: 'Outbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'deny_all_outbound'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Deny all other outbound traffic'
                    protocol: '*'
                    sourcePortRange: '*'
                    destinationPortRange: '*'
                    sourceAddressPrefix: '*'
                    destinationAddressPrefix: '*'
                    access: 'Deny'
                    priority: 4096
                    direction: 'Outbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-sqlmgmt-in-10-2-1-0-24-v10'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow MI provisioning Control Plane Deployment and Authentication Service'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    sourceAddressPrefix: 'SqlManagement'
                    destinationAddressPrefix: '10.2.1.0/24'
                    access: 'Allow'
                    priority: 100
                    direction: 'Inbound'
                    sourcePortRanges: []
                    destinationPortRanges: [
                        '9000'
                        '9003'
                        '1438'
                        '1440'
                        '1452'
                    ]
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-corpsaw-in-10-2-1-0-24-v10'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow MI Supportability'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    sourceAddressPrefix: 'CorpNetSaw'
                    destinationAddressPrefix: '10.2.1.0/24'
                    access: 'Allow'
                    priority: 101
                    direction: 'Inbound'
                    sourcePortRanges: []
                    destinationPortRanges: [
                        '9000'
                        '9003'
                        '1440'
                    ]
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-corppublic-in-10-2-1-0-24-v10'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow MI Supportability through Corpnet ranges'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    sourceAddressPrefix: 'CorpNetPublic'
                    destinationAddressPrefix: '10.2.1.0/24'
                    access: 'Allow'
                    priority: 102
                    direction: 'Inbound'
                    sourcePortRanges: []
                    destinationPortRanges: [
                        '9000'
                        '9003'
                    ]
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-healthprobe-in-10-2-1-0-24-v10'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow Azure Load Balancer inbound traffic'
                    protocol: '*'
                    sourcePortRange: '*'
                    destinationPortRange: '*'
                    sourceAddressPrefix: 'AzureLoadBalancer'
                    destinationAddressPrefix: '10.2.1.0/24'
                    access: 'Allow'
                    priority: 103
                    direction: 'Inbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-internal-in-10-2-1-0-24-v10'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow MI internal inbound traffic'
                    protocol: '*'
                    sourcePortRange: '*'
                    destinationPortRange: '*'
                    sourceAddressPrefix: '10.2.1.0/24'
                    destinationAddressPrefix: '10.2.1.0/24'
                    access: 'Allow'
                    priority: 104
                    direction: 'Inbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-services-out-10-2-1-0-24-v10'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow MI services outbound traffic over https'
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    sourceAddressPrefix: '10.2.1.0/24'
                    destinationAddressPrefix: 'AzureCloud'
                    access: 'Allow'
                    priority: 100
                    direction: 'Outbound'
                    sourcePortRanges: []
                    destinationPortRanges: [
                        '443'
                        '12000'
                    ]
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
            {
                name: 'Microsoft.Sql-managedInstances_UseOnly_mi-internal-out-10-2-1-0-24-v10'
                type: 'Microsoft.Network/networkSecurityGroups/securityRules'
                properties: {
                    description: 'Allow MI internal outbound traffic'
                    protocol: '*'
                    sourcePortRange: '*'
                    destinationPortRange: '*'
                    sourceAddressPrefix: '10.2.1.0/24'
                    destinationAddressPrefix: '10.2.1.0/24'
                    access: 'Allow'
                    priority: 101
                    direction: 'Outbound'
                    sourcePortRanges: []
                    destinationPortRanges: []
                    sourceAddressPrefixes: []
                    destinationAddressPrefixes: []
                }
            }
        ]
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
        name: 'Basic'
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
On-premises Hyper-V Host VM
**************************** */

resource onprem_hyperv_nic 'Microsoft.Network/networkInterfaces@2021-03-01' = {
    name: '${onpremHyperVHostVMNamePrefix}nic'
    location: location
    tags: tags
    properties: {
        ipConfigurations: [
            {
                name: 'ipconfig1'
                properties: {
                    subnet: {
                        id: '${onprem_vnet.id}/subnets/default'
                    }
                    privateIPAllocationMethod: 'Dynamic'
                }
            }
        ]
        networkSecurityGroup: {
            id: onprem_hyperv_nsg.id
        }
    }
}

resource onprem_hyperv_nsg 'Microsoft.Network/networkSecurityGroups@2019-02-01' = {
    name: '${onpremHyperVHostVMNamePrefix}nsg'
    location: location
    tags: tags
    properties: {
        securityRules: [
            {
                name: 'RDP'
                properties: {
                    protocol: 'TCP'
                    sourcePortRange: '*'
                    destinationPortRange: '3389'
                    sourceAddressPrefix: '*'
                    destinationAddressPrefix: '*'
                    access: 'Allow'
                    priority: 100
                    direction: 'Inbound'
                }
            }
        ]
    }
}

resource onprem_hyperv_vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
    name: '${onpremHyperVHostVMNamePrefix}vm'
    location: location
    tags: tags
    properties: {
        hardwareProfile: {
            vmSize: 'Standard_D4s_v5'
        }
        storageProfile: {
            osDisk: {
                createOption: 'fromImage'
            }
            imageReference: {
                publisher: 'MicrosoftWindowsServer'
                offer: 'WindowsServer'
                sku: '2019-datacenter-gensecond'
                version: 'latest'
            }
        }
        networkProfile: {
            networkInterfaces: [
                {
                    id: onprem_hyperv_nic.id
                }
            ]
        }
        osProfile: {
            computerName: 'WinServer'
            adminUsername: labUsername
            adminPassword: labPassword
        }
    }
}

resource onprem_hyperv_vm_ext_installhyperv 'Microsoft.Compute/virtualMachines/extensions@2017-12-01' = {
    name: '${onprem_hyperv_vm.name}/InstallHyperV'
    location: location
    tags: tags
    properties: {
        publisher: 'Microsoft.Compute'
        type: 'CustomScriptExtension'
        typeHandlerVersion: '1.4'
        autoUpgradeMinorVersion: true
        settings: {
            fileUris: [
                HyperVHostInstallHyperVURL
            ]
            commandToExecute: 'powershell -ExecutionPolicy Unrestricted -File ${HyperVHostInstallHyperVScriptFolder}/${HyperVHostInstallHyperVScriptFileName}'
        }
    }
}

resource onprem_hyperv_vm_ext_createvm 'Microsoft.Compute/virtualMachines/extensions@2017-12-01' = {
    name: '${onprem_hyperv_vm.name}/CreateWinServerVM'
    location: location
    tags: tags
    dependsOn: [
        onprem_hyperv_vm_ext_installhyperv
    ]
    properties: {
        publisher: 'Microsoft.Powershell'
        type: 'DSC'
        typeHandlerVersion: '2.9'
        autoUpgradeMinorVersion: true
        settings: {
            configuration: {
                url: HyperVHostConfigURL
                script: HyperVHostConfigArchiveScriptName
                function: 'Main'
            }
        }
    }
}


/* ****************************
On-premises SQL VM
**************************** */

resource onprem_sqlvm_nic 'Microsoft.Network/networkInterfaces@2021-03-01' = {
    name: '${onpremSQLVMNamePrefix}nic'
    location: location
    tags: tags
    properties: {
        ipConfigurations: [
            {
                name: 'ipconfig1'
                properties: {
                    subnet: {
                        id: '${onprem_vnet.id}/subnets/default'
                    }
                    privateIPAllocationMethod: 'Dynamic'
                }
            }
        ]
        networkSecurityGroup: {
            id: onprem_sqlvm_nsg.id
        }
    }
}

resource onprem_sqlvm_nsg 'Microsoft.Network/networkSecurityGroups@2019-02-01' = {
    name: '${onpremSQLVMNamePrefix}nsg'
    location: location
    tags: tags
    properties: {
        securityRules: [
            {
                name: 'RDP'
                properties: {
                    protocol: 'TCP'
                    sourcePortRange: '*'
                    destinationPortRange: '3389'
                    sourceAddressPrefix: '*'
                    destinationAddressPrefix: '*'
                    access: 'Allow'
                    priority: 100
                    direction: 'Inbound'
                }
            }
        ]
    }
}

resource onprem_sqlvm_vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
    name: '${onpremSQLVMNamePrefix}vm'
    location: location
    tags: tags
    properties: {
        hardwareProfile: {
            vmSize: 'Standard_D4s_v5'
        }
        storageProfile: {
            osDisk: {
                createOption: 'fromImage'
            }
            imageReference: {
                publisher: 'MicrosoftSQLServer'
                offer: 'SQL2012SP4-WS2012R2'
                sku: 'Standard'
                version: 'latest'
            }
        }
        networkProfile: {
            networkInterfaces: [
                {
                    id: onprem_sqlvm_nic.id
                }
            ]
        }
        osProfile: {
            computerName: 'SQLServer'
            adminUsername: labUsername
            adminPassword: labPassword
        }
    }
}

resource onprem_sqlvm_vm_ext_sqlvmconfig 'Microsoft.Compute/virtualMachines/extensions@2017-12-01' = {
    name: '${onprem_sqlvm_vm.name}/SQLVMConfig'
    location: location
    tags: tags
    dependsOn: []
    properties: {
        publisher: 'Microsoft.Powershell'
        type: 'DSC'
        typeHandlerVersion: '2.9'
        autoUpgradeMinorVersion: true
        settings: {
            configuration: {
                url: SQLVMConfigURL
                script: SQLVMConfigScriptName
                function: 'Main'
            }
        }
    }
}
