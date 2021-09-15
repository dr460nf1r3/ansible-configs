#!/bin/bash
# BTRFS stuff
sudo btrfs quota disable /
sudo chattr +C /var/lib/machines
mkdir "~/VirtualBox VMs"
sudo chattr +C "~/VirtualBox VMs"

# CachyOS repo
wget https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-4-1-any.pkg.tar.zst
sudo pacman -U cachyos-v3-mirrorlist-4-1-any.pkg.tar.zst
sudo pacman-key --recv-keys 882DCFE48E2051D48E2562ABF3B607488DB35A47
sudo pacman-key --lsign-key 882DCFE48E2051D48E2562ABF3B607488DB35A47

# Put configs in place
sudo cp ./etc/{makepkg.conf,mkinitcpio.conf,pacman.conf} /etc/
sudo cp ./etc/default/grub /etc/default/grub

# Install needed applications & remove bloat
sudo pacman -S --needed gimp-git fastfetch-git acpi_call-dkms ananicy-cpp-git ananicy-rules-git android-tools ansible aura-git bottom duperemove electronmail-bin fish-git gitkraken hunspell-en_gb hunspell-de hyperfine hyphen-de hyphen-en ideapad-cm jdk8-openjdk kdenlive krdc krfb libreoffice-fresh-de libreoffice-fresh-en-gb libreoffice-fresh libinput-gestures linux-cacule-rdb linux-cacule-rdb-headers lutris makedeb mcfly mangohud-git movit opensnitch-git openssh-hpn proton-ge-custom revolt-desktop-git ripgrep-git signal-desktop-beta spotify starship-git steam sudo-git thunderbird-appmenu tigervnc vscodium-git whoogle-git wireplumber-git  lib32-mangohud-git zenmonitor-git zram-generator-git wine-meta teams exa-git htop-git pipewire-common-alsa-git pipewire-common-git pipewire-common-pulse-git pipewire-common-zeroconf-git vulkan-icd-loader-git memavaild-git prelockd-git vulkan-headers-tkg-git
sudo pacman -Rns cronie b43-fwcutter candy-icons-git neofetch-git  fwupd gnome-firmware ipw2100-fw  ipw2200-fwlockdown-ms mkinitcpio-nfs-utils  mkinitcpio-openswap noto-fonts-cjk plasma-thunderbolt plasma-firewall plymouth-git plymouth-theme-dr460nized ttf-liberation ttf-opensans pamac-aur alpm_octopi_utils octopi lua autorandr networkmanager-support input-devices-support garuda-boot-options garuda-video-linux-config garuda-gamer garuda-network-assistant linux-zen linux-zen-headers sddm sddm-kcm ufw
sudo pacman -S --needed linux-cacule-rdb linux-cacule-rdb-headers linux-lqx linux-lqx-headers octopi-dev xf86-video-amdgpu mesa-tkg-git lib32-mesa-tkg-git

# AUR applications
paru -S spotify-adblock-git 

# Autologin without DM
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo cp ./systemd/system/getty@tty1.service.d /etc/systemd/system/getty@tty1.service.d

# Systemctl services (system & user)
sudo systemctl mask lvm2-lvmpolld.service
sudo systemctl mask lvm2-lvmpolld.socket
sudo systemctl mask lvm2-monitor.service
sudo systemctl mask NetworkManager-wait-online.service
sudo systemctl disable --now bluetooth-autoconnect.service
sudo systemctl disable --now ModemManager.service
sudo systemctl disable --now remote-fs.target

sudo systemctl enable --now ananicy-cpp.service
sudo systemctl enable --now opensnitchd.service

sudo hblock
sudo systemctl enable --now hblock.timer

systemctl --user disable --now pipewire-media-session.service
systemctl --user disable --now pulseaudio-bluetooth-autoconnect.service
systemctl --user enable --now wireplumber

# Plasma systemd startup
kwriteconfig5 --file startkderc --group General --key systemdBoot true
