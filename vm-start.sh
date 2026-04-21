#!/bin/bash

clear
echo "================================================"
echo "     Azure VM Start"
echo "================================================"
echo

# Prompt for inputs
read -p "Enter Resource Group Name: " RG
read -p "Enter VM Name (e.g. vm-debian1): " VM

echo
echo "You are about to START:"
echo "  Resource Group : $RG"
echo "  VM Name        : $VM"
echo

echo "Starting VM $VM..."

# Run the Azure CLI command
az vm start --resource-group "$RG" --name "$VM"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to start the VM."
    read -p "Press Enter to exit..."
    exit 1
fi

echo
echo "================================================"
echo "SUCCESS: VM $VM has been started."
echo "================================================"
echo

read -p "Press Enter to exit..."