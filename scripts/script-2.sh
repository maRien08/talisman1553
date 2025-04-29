ln -sf /usr/share/zoneinfo/Europe/Bucharest /etc/localtime
hwclock --systohc

reflector -c "Germany,Romania," -p https -a 3 --sort rate --save /etc/pacman.d/mirrorlist

pacman -Syy

pacman --noconfirm -S grub xdg-desktop-portal-wlr efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call dnsmasq openbsd-netcat ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font exa bat htop ranger zip unzip neofetch duf xorg xorg-xinit xclip grub-btrfs xf86-video-amdgpu xf86-video- nouveau xf86-video-intel xf86-video-qxl brightnessctl pacman-contrib lvm2 nano

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "FONT=ter-v18n" >> /etc/vconsole.conf
echo "KEYMAP=us" >> /etc/vconsole.conf

echo "faora" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
