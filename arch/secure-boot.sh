#!/bin/bash

#------------------------------------------------------------
# SBCTL
#------------------------------------------------------------

echo "Creating Secure Boot keys"

sudo sbctl create-keys

echo "Enrolling Microsoft Keys"

sudo sbctl enroll-keys --microsoft

echo "Signing ('/boot/vmlinuz-linux', '/boot/EFI/BOOT/BOOTX64.EFI', '/boot/EFI/systemd/systemd-bootx64.efi', '/boot/shellx64.efi')"

sudo sbctl sign -s /boot/vmlinuz-linux
sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
sudo sbctl sign -s /boot/EFI/systemd/systemd-bootx64.efi
sudo sbctl sign -s /boot/shellx64.efi

echo "Enabling & Starting systemd-boot-update.service for automatically signs after kernel update"

sudo systemctl enable systemd-boot-update.service
sudo systemctl start systemd-boot-update.service

echo "Dumping Secure Boot signed files"

sudo sbctl verify
