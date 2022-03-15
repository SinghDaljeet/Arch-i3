#!/bin/bash


sudo pacman -S --noconfirm xorg-server xorg-xinit xorg-xkill xorg-xsetroot xorg-xbacklight xorg-xprop noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono ttf-joypixels ttf-font-awesome podman mpv zathura zathura-pdf-mupdf ffmpeg imagemagick  fzf man-db i3-wm kitty gvfs udisks lxqt-polickykit feh youtube-dl xclip maim zip unzip unrar p7zip edk2-ovmf papirus-icon-theme tmux brightnessctl dosfstools qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ntfs-3g git pipewire pipewire-pulse xorg-xrandr wget neovim ebtables iptables firejail libguestfs arc-gtk-theme firefox libnotify dunst ufw dhcpcd networkmanager pamixer i3lock xdg-user-dirs i3status-rust

sudo systemctl enable NetworkManager.service 
sudo systemctl enable ufw.service
sudo systemctl enable libvirtd.service


echo (" Setting up Apparmor")
sudo echo "GRUB_CMDLINE_LINUX_DEFAULT="quiet splash lsm=apparmor"" >> /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo systemctl enable apparmor.service
sudo echo "write-cache" >> /etc/apparmor/parser.conf
