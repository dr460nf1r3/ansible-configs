## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low


## Environment setup
# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end


## Starship prompt
if status --is-interactive
   source ("/usr/bin/starship" init fish --print-full-init | psub)
end


## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end


## Useful aliases
# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles

# Replace some more things with better alternatives
#alias cat='bat --style header --style rules --style snip --style changes --style header'

# Common use
alias ......='cd ../../../../..'
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB (expac must be installed)
alias dir='dir --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias grubup="doas grub-mkconfig -o /boot/grub/grub.cfg"
alias hw='hwinfo --short'                                   # Hardware Info
alias ip='ip --color'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias psmem='ps auxf | sort -nr -k 4'
alias rmpkg="sudo pacman -Rdd"
alias sudo='doas'
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias vdir='vdir --color=auto'
alias wget='wget -c '

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Youtube to MP3 and videos to MP4
alias ytmp3="youtube-dl --output '~/Music/Downloaded/%(title)s.%(ext)s' --extract-audio --audio-format mp3"
alias vidtomp4="youtube-dl --output '~/Videos/Downloaded/%(title)s.%(ext)s' -f 'mp4'"

# Journalctl logs
alias jlogs='journalctl -b -p 4..1'

# Git aliases
alias gclone='git clone'
alias gcommit='git commit -m'
alias gpr='git pull --rebase'
alias gpull='git pull'
alias gpush='git push'

# Arch Linux
alias alct="sudo systemd-nspawn -D /var/lib/machines/arch"
alias alshell='machinectl shell nico@arch'

# Check kernel version
alias kernels='curl --no-progress-meter https://www.kernel.org | grep "<td><strong>" | cut -d "<" -f3 | cut -d ">" -f2'

# Gentoo
alias arch-run="xhost +local:; sudo machinectl login arch; xhost -;"
alias flags='equery uses'
alias keyw='doas micro /etc/portage/package.accept_keywords/gentoo'
alias makec='doas micro /etc/portage/make.conf'
alias prov='e-file'
alias rebuild='revdep-rebuild -v'
alias unl='doas cryptsetup luksOpen /dev/sda3 arch && doas mount /dev/mapper/arch /mnt/arch'
alias upd='doas emerge --sync && doas emerge -auUvD @world && doas smart-live-rebuild && doas eix-update && fish_update_completions && doas updatedb'
alias updlive='doas smart-live-rebuild'
alias uses='doas micro /etc/portage/package.use/flags'
alias watchc='doas watch genlop -unc'
alias watchd='sudo tail -f /var/log/emerge-fetch.log'

# Arch maintenance
alias makepkg='conty.sh makepkg'

## Run paleofetch if session is interactive
if status --is-interactive
   neofetch
end
