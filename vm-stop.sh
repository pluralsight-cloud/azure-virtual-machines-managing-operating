#!/bin/bash

clear
echo "================================================"
echo "     Azure VM Stop + Deallocate"
echo "================================================"
echo

# Prompt for inputs
read -rp "Enter Resource Group Name: " RG
read -rp "Enter VM Name (e.g. vm-debian1): " VM

echo
echo "You are about to STOP and DEALLOCATE:"
echo "  Resource Group : $RG"
echo "  VM Name        : $VM"
echo
echo "This will stop billing for compute resources."
echo

echo "Stopping and deallocating $VM..."

# Run the Azure CLI command
az vm deallocate --resource-group "$RG" --name "$VM"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to stop/deallocate the VM."
    read -rp "Press Enter to exit..."
    exit 1
fi

echo
echo "================================================"
echo "SUCCESS: VM $VM has been stopped and deallocated."
echo "You are no longer being charged for compute."
echo "================================================"
echo

read -rp "Press Enter to exit..."