#!/bin/bash

clear
echo "================================================"
echo "     Azure VM SKU Resizer"
echo "================================================"
echo

# Prompt for inputs
read -rp "Enter Resource Group Name: " RG
read -rp "Enter VM Name (e.g. vm-debian1): " VM
read -rp "Enter New SKU (e.g. Standard_B2ls_v2): " NEW_SIZE

echo
echo "You are about to resize:"
echo "  Resource Group : $RG"
echo "  VM Name        : $VM"
echo "  New SKU        : $NEW_SIZE"
echo

# Confirmation
read -rp "Type YES to continue (case sensitive): " CONFIRM

if [[ "$CONFIRM" != "YES" ]]; then
    echo "Operation cancelled by user."
    exit 1
fi

echo
echo "Starting resize process for $VM..."
echo

# Step 1: Deallocate the VM
echo "[1/3] Deallocating VM..."
az vm deallocate --resource-group "$RG" --name "$VM"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to deallocate the VM."
    read -rp "Press Enter to exit..."
    exit 1
fi

# Step 2: Resize the VM
echo "[2/3] Resizing VM to $NEW_SIZE..."
az vm resize --resource-group "$RG" --name "$VM" --size "$NEW_SIZE"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to resize the VM."
    echo "You may need to check if the new size is available in your region."
    read -rp "Press Enter to exit..."
    exit 1
fi

# Step 3: Start the VM
echo "[3/3] Starting VM..."
az vm start --resource-group "$RG" --name "$VM"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to start the VM."
    read -rp "Press Enter to exit..."
    exit 1
fi

echo
echo "================================================"
echo "SUCCESS: VM $VM has been resized to $NEW_SIZE and started."
echo "================================================"
echo

read -rp "Press Enter to exit..."