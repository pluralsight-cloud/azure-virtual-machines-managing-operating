@secure()
param extensions_enablevmAccess_username string

@secure()
param extensions_enablevmAccess_password string

@secure()
param extensions_enablevmAccess_ssh_key string

@secure()
param extensions_enablevmAccess_reset_ssh string

@secure()
param extensions_enablevmAccess_remove_user string

@secure()
param extensions_enablevmAccess_expiration string
param virtualMachines_vm_debian1_name string = 'vm-debian1'
param disks_vm_debian1_OsDisk_1_d0893f025b7346c79e2ad89a8454f588_externalid string = '/subscriptions/ae0a3f35-4031-4939-b11b-74b0127c3ab6/resourceGroups/RG_VMS1/providers/Microsoft.Compute/disks/vm-debian1_OsDisk_1_d0893f025b7346c79e2ad89a8454f588'
param networkInterfaces_vm_debian1856_z1_externalid string = '/subscriptions/ae0a3f35-4031-4939-b11b-74b0127c3ab6/resourceGroups/rg_VMs1/providers/Microsoft.Network/networkInterfaces/vm-debian1856_z1'

resource virtualMachines_vm_debian1_name_resource 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: virtualMachines_vm_debian1_name
  location: 'centralus'
  zones: [
    '1'
  ]
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ats_v2'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'debian'
        offer: 'debian-12'
        sku: '12-gen2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_vm_debian1_name}_OsDisk_1_d0893f025b7346c79e2ad89a8454f588'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: disks_vm_debian1_OsDisk_1_d0893f025b7346c79e2ad89a8454f588_externalid
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm_debian1_name
      adminUsername: 'azureuser'
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/azureuser/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDuu8Wy/hrcFC00VgOF5Agq9U6377zWQjoOzUzt68oqvRURYNvru8cKEweESvB75tP0C+KnOFOSWoexv8N4Or7Cwz91uEbwZHCuh4BaKy1F9QCVByq8pHTuCAjbFFqdrSQ/AnPptIahGPH2S31YA/LPI9kqIHTn019uwOtQ+ROxMCeODF2+ieD5BM6L4HSyPeSEcBJsCzy2iFKyRvrlnD1SaTymaXLTj/sbW62+/8Y4EQ/JDNDvWOXLWrz+jbLGDFTwJcZcW0x6lnYeQ4I4dxgPgzIjr605qnXoeT/AnKK50Q/W7L9LSzbAMVFwd59QV92BzGEPeQV4TllExX8V3uVV0XMpU1eKGElNK64Cm8G7zX5bcheUgskLtE1abBqawuDhM3yKA1ZlmlDctFiYgqUaGxOKCzyWRhHUyHWj7EwDVbANjiS22uSMBkyLE7et3gZLUj43hhXsu3dYym80S7ofDKKOLyICO/VFQCX4LQK2Pz25ukd7QJJGZPB7YZm7i40= generated-by-azure'
            }
          ]
        }
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_debian1856_z1_externalid
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualMachines_vm_debian1_name_enablevmAccess 'Microsoft.Compute/virtualMachines/extensions@2025-04-01' = {
  parent: virtualMachines_vm_debian1_name_resource
  name: 'enablevmAccess'
  location: 'centralus'
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.OSTCExtensions'
    type: 'VMAccessForLinux'
    typeHandlerVersion: '1.5'
    settings: {}
    protectedSettings: {
      username: extensions_enablevmAccess_username
      password: extensions_enablevmAccess_password
      ssh_key: extensions_enablevmAccess_ssh_key
      reset_ssh: extensions_enablevmAccess_reset_ssh
      remove_user: extensions_enablevmAccess_remove_user
      expiration: extensions_enablevmAccess_expiration
    }
  }
}
