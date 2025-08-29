# Arch Linux

## Installation

The instructions below are almost following [official installation guide](https://wiki.archlinux.org/title/Installation_guide).

### Pre-installation

#### Acquire an installation image

1. Visit the [Download](https://archlinux.org/download/) page and download the ISO file `archlinux-YYYY.MM.DD-x86_64.iso`.

#### Prepare an installation medium [^1]

1. Check your USB flash drive name:
   ```sh
   ls -l /dev/disk/by-id/usb-*
   ```
1. Write the ISO to your USB flash drive:
   ```sh
   cat path/to/archlinux-version-x86_64.iso > /dev/disk/by-id/usb-My_flash_drive
   ```

#### Boot the live environment

1. Reboot your system.
1. Select `Arch Linux install medium` and press Enter to enter the installation environment.

#### Connect to the internet

##### For WiFi [^2]

1. Start an interactive prompt:
   ```sh
   iwctl
   ```
1. List all WiFi devices and check the device name:
   ```
   [iwd]# device list
   ```
1. Scan for networks:
   ```
   [iwd]# station {device name} scan
   ```
1. Connect to the network:
   ```
   [iwd]# station {device name} connect {SSID}
   ```
1. Exit interaction then test the connection:
   ```sh
   ping ping.archlinux.org
   ```

#### Partition the disks [^3]

1. Check your device name:
   ```sh
   lsblk
   ```
1. Partition the disk:
   ```sh
   parted /dev/sda --script mklabel gpt
   parted /dev/sda --script mkpart ESP fat32 1MiB 513MiB
   parted /dev/sda --script set 1 esp on
   parted /dev/sda --script mkpart primary btrfs 513MiB 102913MiB
   parted /dev/sda --script mkpart primary btrfs 102913MiB 100%
   ```

#### Format the partitions [^3]

1. Run:
   ```sh
   mkfs.fat -F32 /dev/sda1
   mkfs.btrfs /dev/sda2
   mkfs.btrfs /dev/sda3
   ```

#### Mount the file systems [^3]

1. Run:
   ```sh
   mount /dev/sda2 /mnt
   mkdir /mnt/boot
   mkdir /mnt/home
   mount /dev/sda1 /mnt/boot
   mount /dev/sda3 /mnt/home
   ```

### Installation

#### Install essential packages [^3]

1. Run:
   ```sh
   pacstrap -K /mnt base linux linux-firmware btrfs-progs
   ```

#### Fstab

1. Generate an fstab file:
   ```sh
   genfstab -U /mnt >> /mnt/etc/fstab
   ```

#### Chroot

1. Change root into the new system:
   ```sh
   arch-chroot /mnt
   ```

#### Network configuration [^3]

1. Set up Network Manager:
   ```sh
   pacman -S networkmanager
   systemctl enable NetworkManager
   ```

#### Root password

1. Set a secure password for the root:
   ```sh
   passwd
   ```

#### Boot loader [^3]

1. Install boot loader:
   ```sh
   pacman -S intel-ucode # Intel
   pacman -S amd-ucode   # AMD
   ```

1. Set up `systemd-boot`:
   ```sh
   bootctl --path=/boot install
   systemctl enable systemd-boot-update
   ```

### Reboot

1. Unmount all partitions and reboot:
   ```sh
   exit
   umount -R /mnt
   reboot
   ```

### Configure the system

[^1]: https://wiki.archlinux.org/title/USB_flash_installation_medium#Using_basic_command_line_utilities
[^2]: https://wiki.archlinux.org/title/Iwd#iwctl
[^3]: https://zenn.dev/ama_nenee/articles/6d7d145044b035
