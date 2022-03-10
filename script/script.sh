# == MY ARCH SETUP INSTALLER == #
#part1
printf '\033c'
echo "Welcome to bugswriter's arch installer script"
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
pacman --noconfirm -Sy archlinux-keyring
loadkeys us
timedatectl set-ntp true
lsblk
echo "Enter the drive: "
read drive
cfdisk $drive 
echo "Enter the linux partition: "
read partition
mkfs.ext4 $partition 
read -p "Did you also create efi partition? [y/n]" answer
if [[ $answer = y ]] ; then
  echo "Enter EFI partition: "
  read efipartition
  mkfs.vfat -F 32 $efipartition
fi
mount $partition /mnt 
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' `basename $0` > /mnt/arch_install2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt ./arch_install2.sh
exit 

#part2
printf '\033c'
pacman -S --noconfirm sed
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
mkinitcpio -P
passwd
pacman --noconfirm -S grub efibootmgr os-prober
echo "Enter EFI partition: " 
read efipartition
mkdir /boot/efi
mount $efipartition /boot/efi 
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
sed -i 's/quiet/pci=noaer/g' /etc/default/grub
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S --noconfirm xorg-server xorg-xinit xorg-xkill xorg-xsetroot xorg-xbacklight xorg-xprop \
     noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono ttf-joypixels ttf-font-awesome \
     podman mpv zathura zathura-pdf-mupdf ffmpeg imagemagick  \
     fzf man-db i3-wm kitty gvfs udisks lxqt-polickykit feh youtube-dl xclip maim \
     zip unzip unrar p7zip edk2-ovmf papirus-icon-theme tmux brightnessctl  \
     dosfstools qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ntfs-3g git pipewire pipewire-pulse xorg-xrandr wget \
     neovim ebtables iptables libguestfs arc-gtk-theme firefox \
     libnotify dunst  \
     dhcpcd networkmanager pamixer i3lock \
     xdg-user-dirs i3status-rust

systemctl enable NetworkManager.service 
systemctl enable libvirtd.service
rm /bin/sh
ln -s dash /bin/sh


# User
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "unix_sock_group = "libvirt"" >> /etc/libvirt/libvirtd.conf
echo "unix_sock_rw_perms = "0770"" >> /etc/libvirt/libvirtd.conf
echo "Enter Username: "
read username
useradd -m -G wheel -s /bin/bash $username
usermod -a -G libvirt $username
passwd $username

ai3_path=/home/$username/arch_install3.sh
sed '1,/^#part3$/d' arch_install2.sh > $ai3_path
chown $username:$username $ai3_path
chmod +x $ai3_path
su -c $ai3_path -s /bin/sh $username
exit

#part3
printf '\033c'
cd $HOME

## Apparmor
sudo echo "GRUB_CMDLINE_LINUX_DEFAULT="quiet splash lsm=apparmor"" >> /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo systemctl enable apparmor.service
sudo echo "write-cache" >> /etc/apparmor/parser.conf

## Setting up wm and others
git clone https://github.com/SinghDaljeet/Arch-i3.git
cd Arch-i3
mv bashrc .bashrc && mv .bashrc /home/$(whoami) && mv X11 i3 i3rust kitty tmux zathura mimeapps.list ~/.config
ln -s ~/.config/tmux/tmux.conf .tmux.conf
ln -s ~/.config/x11/xinitrc .xinitrc
exit

