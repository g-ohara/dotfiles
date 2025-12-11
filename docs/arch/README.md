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

### Configure the system

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

## Setup

### Creating User

1. Create a new user with its home directory:
   ```sh
   useradd -m <username>
   ```
1. Set password for the new user:
   ```sh
   passwd <username>
   ```
1. Add the new user to group `wheel`:
   ```sh
   usermod -aG wheel <username>
   ```
1. Install `sudo` and editor:
   ```sh
   pacman -Syu && pacman -S sudo vi
   ```
1. Allow users in `wheel` to execute `sudo`.
   1. Open `/etc/sudoers`:
      ```sh
      visudo
      ```
   1. Uncomment this line (Don't delete `%`):
      ```
      %wheel ALL=(ALL:ALL) ALL
      ```

### Connecting to Network [^3]

1. Start NetworkManager:
   ```sh
   systemctl start NetworkManager
   ```
1. Check the list of SSID:
   ```sh
   nmcli device wifi
   ```
1. Connect to WiFi:
   ```sh
   nmcli device wifi connect {SSID} password {password}
   ```
1. Set IP address and default gateway and reconnect (only when not using DHCP) [^4]:
   ```sh
   nmcli connection modify {SSID} ipv4.addresses "{IP address}/{length of subnet mask}"
   nmcli connection modify {SSID} ipv4.gateway "{gateway address}"
   nmcli connection down {SSID}
   nmcli connection up {SSID}
   ```
1. Check connection:
   ```sh
   ping ping.archlinux.org
   ```

### Update Pacman Mirror List

1. Install essential packages (It may take for a while):
   ```sh
   pacman -Syu && pacman -S reflector
   ```
1. Update a mirror list:
   ```
   reflector --country <your-country> --age 24 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
   ```

### Git [^5]

1. Install essential packages:
   ```sh
   pacman -Syu
   pacman -S git openssh
   ```
1. Generate SSH key:
   ```sh
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
1. Copy your public key (`~/.ssh/id_ed25519.pub`) and add it to your GitHub account.

### Docker

1. Install essential packages:
   ```sh
   pacman -Syu
   pacman -S docker docker-compose docker-buildx
   ```
1. Start Docker daemon and set it to start on boot:
   ```sh
   systemctl start docker
   systemctl enable docker
   ```
1. Add a normal user to group `docker`:
   ```sh
   usermod -aG docker <username>
   ```
   
### Bluetooth [^6]

1. Install required packages:
   ```sh
   pacman -S bluez bluez-utils
   ```
1. Start Bluetooth daemon and set it to start on boot:
   ```sh
   systemctl start bluetooth
   systemctl enable bluetooth
   ```
1. Start interactive system:
   ```sh
   bluetoothctl
   ```
1. Scan your devices:
   ```sh
   [bluetooth]# scan on
   ```
1. Do the pairing with your target device:
   ```sh
   [bluetooth]# pair {MAC adress}
   ```

[^1]: https://wiki.archlinux.org/title/USB_flash_installation_medium#Using_basic_command_line_utilities
[^2]: https://wiki.archlinux.org/title/Iwd#iwctl
[^3]: https://zenn.dev/ama_nenee/articles/6d7d145044b035
[^4]: https://qiita.com/mtn_kt/items/633bd5e3e00732af564e
[^5]: https://docs.github.com/en/authentication/connecting-to-github-with-ssh
[^6]: https://wiki.archlinux.jp/index.php/Bluetooth
