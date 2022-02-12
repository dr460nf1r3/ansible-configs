#!/bin/bash
# BTRFS stuff
sudo btrfs quota disable /
sudo chattr +C /var/lib/machines
sudo chattr +C /var/lib/libvirt

# CachyOS repo
wget https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-8-1-any.pkg.tar.zst
sudo pacman -U cachyos-v3-mirrorlist-8-1-any.pkg.tar.zst
sudo pacman-key --recv-keys 882DCFE48E2051D48E2562ABF3B607488DB35A47
sudo pacman-key --lsign-key 882DCFE48E2051D48E2562ABF3B607488DB35A47

# Put configs in place
sudo cp ./etc/{makepkg.conf,mkinitcpio.conf,pacman.conf} /etc/

# Install needed applications & remove bloat
sudo pacman -S --needed gimp-git fastfetch-git acpi_call-dkms ananicy-cpp-git ananicy-rules-git android-tools ansible aura-git bottom duperemove electronmail-bin fish-git gitkraken hunspell-en_gb hunspell-de hyperfine hyphen-de hyphen-en ipman jdk8-openjdk kdenlive krdc krfb libreoffice-fresh-de libreoffice-fresh-en-gb libreoffice-fresh libinput-gestures lutris mangohud-git movit ufw-git openssh-hpn proton-ge-custom ripgrep-git signal-desktop-beta spotify starship-git steam sudo-git thunderbird-appmenu vscodium-git whoogle-git wireplumber-git lib32-mangohud-git zenmonitor-git zram-generator-git wine-meta teams exa-git btop pipewire-common-alsa-git pipewire-common-git pipewire-common-pulse-git hugo-git pipewire-common-zeroconf-git vulkan-icd-loader-git memavaild-git speedcrunch prelockd-git vulkan-headers-tkg-git breeze-grub spotify-adblock-git jamesdsp-git nextcloud-client-git modprobed-db kotatogram-dev-git spicetify-cli-git spicetify-themes-git
sudo pacman -Rns b43-fwcutter candy-icons-git neofetch-git fwupd gnome-firmware ipw2100-fw  ipw2200-fw lockdown-ms systemd-guest-user mkinitcpio-nfs-utils  mkinitcpio-openswap noto-fonts-cjk plasma-thunderbolt plymouth-git plymouth-theme-dr460nized ttf-liberation ttf-opensans alpm_octopi_utils octopi autorandr networkmanager-support input-devices-support garuda-boot-options garuda-video-linux-config garuda-gamer garuda-network-assistant linux-zen linux-zen-headers sddm sddm-kcm
sudo pacman -S --needed linux-tkg-cfs-generic_v3 linux-tkg-cfs-headers-generic_v3 octopi-git xf86-video-amdgpu mesa-tkg-git lib32-mesa-tkg-git

# Install DNSCrypt-proxy
git clone https://github.com/BL4CKH47H4CK3R/Hardened-Anonymized-DNSCrypt-Proxy.git && cd Hardened-Anonymized-DNSCrypt-Proxy
makepkg -Cris && sudo pacman -U *.pkg.tar.zst && cd .. && sudo rm -r Hardened-Anonymized-DNSCrypt-Proxy

# Autologin without DM
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo cp ./systemd/system/getty@tty1.service.d/override.conf /etc/systemd/system/getty@tty1.service.d

# Configs
cp ./.config/starship.toml ~/.config/starship.toml
cp ./.config/modprobed.db ~/.config/modprobed.db

# Setup custom .desktops & autostart
rm -r ~/.config/autostart && rm -r ~/.local/share/applications
cp -r ./.config/autostart ~/.config/ && cp ./local/share/applications ~/.local/share/

# Systemctl services (system & user)
sudo systemctl mask lvm2-lvmpolld.service
sudo systemctl mask lvm2-lvmpolld.socket
sudo systemctl mask lvm2-monitor.service
sudo systemctl mask NetworkManager-wait-online.service
sudo systemctl disable --now bluetooth-autoconnect.service
sudo systemctl disable --now ModemManager.service
sudo systemctl disable --now remote-fs.target

sudo systemctl enable --now ananicy-cpp.service
sudo systemctl enable --now ufw

sudo hblock
sudo systemctl enable --now hblock.timer

systemctl --user disable --now pipewire-media-session.service
systemctl --user disable --now pulseaudio-bluetooth-autoconnect.service
systemctl --user enable --now wireplumber
systemctl --user enable --now modprobed-db

# Plasma systemd startup
kwriteconfig5 --file startkderc --group General --key systemdBoot true
