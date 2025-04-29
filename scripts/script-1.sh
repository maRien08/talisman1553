ping -c4 www.archlinux.org

mkfs.fat -F 32 /dev/nvme0n1p2
mkfs.btrfs -f /dev/vgtotal/lvhome

mount /dev/vgtotal/lvhome /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots
btrfs su cr /mnt/@log
umount /mnt

mount -o compress=zstd:1,noatime,subvol=@ /dev/vgtotal/lvhome /mnt
mkdir -p /mnt/{boot/efi,home,.snapshots,var/{cache,log}}
mount -o compress=zstd:1,noatime,subvol=@cache /dev/vgtotal/lvhome /mnt/var/cache
mount -o compress=zstd:1,noatime,subvol=@home /dev/vgtotal/lvhome /mnt/home
mount -o compress=zstd:1,noatime,subvol=@log /dev/vgtotal/lvhome /mnt/var/log
mount -o compress=zstd:1,noatime,subvol=@snapshots /dev/vgtotal/lvhome /mnt/.snapshots
mount /dev/nvme0n1p2 /mnt/boot/efi

pacstrap -K /mnt base base-devel git linux linux-firmware vim openssh reflector rsync amd-ucode

genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
