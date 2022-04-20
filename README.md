# Dr460nf1r3's dotfiles & Ansible configs

## Ansible

- The Ansible configuration is used to quickly perform reproducable environments after reinstallations. It is split in servers and workstations.

## T470_gentoo

- These are old configurations from the time when I was using Gentoo. I don't use them anymore, but I keep them here for reference.
- [GentooLTO](https://github.com/InBetweenNames/gentooLTO) portage config: most packages compiled with LTO and -O3 optimisations
- Systemd-nspawn containers with access to X server for running Arch packages on Gentoo such as the [Firedragon browser](https://github.com/dr460nf1r3/firedragon-browser)
- Kernel adapted for Lenovo T470, stripped down & with patches to use the CacULE scheduler & misc stuff are taken from [here](https://github.com/ptr1337/linux-cacule-aur)
- Approximately half of the packages is build from master branch using live ebuilds, because the more bleeding edge the better. Smart-live-rebuild for the win!

<img src=https://github.com/dr460nf1r3/dotfiles/raw/master/neofetch.png/>
