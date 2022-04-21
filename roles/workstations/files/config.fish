## Set values
# Hide welcome message
set -gx MCFLY_FUZZY true
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set fish_greeting

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low


## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end


## Starship prompt
if status --is-interactive
   source ("/usr/bin/starship" init fish --print-full-init | psub)
end


## Mcfly terminal search
mcfly init fish | source


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


## Useful aliases
# Replace ls with exa
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing

# Replace some more things with better alternatives
alias cat='bat --style header --style rules --style snip --style changes --style header'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Common use
alias ......='cd ../../../../..'
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
alias dir='dir --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'
alias grep='grep --color=auto'
alias grubup="sudo update-grub"
alias hw='hwinfo --short'
alias ip='ip --color=auto'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias psmem='ps auxf | sort -nr -k 4'
alias rmpkg="sudo pacman -Rdd"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias upd='/usr/bin/update'
alias vdir='vdir --color=auto'
alias wget='wget -c '

# Misc useful
alias chaotic='ssh -p 420 nico@89.58.13.188 chaotic'
alias dd='dd progress=status'
alias docker='podman'
alias htop='btop'
alias jctl="journalctl -p 3 -xb"
alias makepkg='makepkg -Ccirs'

# Git aliases
alias gclone='git clone'
alias gcommit='git commit -m'
alias gitlog='git log --oneline --graph --decorate --all'
alias gpr='git pull --rebase'
alias gpull='git pull'
alias gpush='git push'

# SSH hosts
alias b='ssh -p 4200 nico@89.58.13.188'
alias c='ssh -p 420 nico@89.58.13.188'
alias e='ssh nico@89.58.13.188'
alias g1='ssh -p 222 nico@65.108.140.36'
alias g2='ssh nico@216.158.66.108'
alias g3='ssh -p 224 nico@65.108.140.36'
alias g4='ssh nico@157.230.4.68'
alias g5='ssh -p 225 nico@65.108.140.36'
alias g6='ssh -p 223 nico@65.108.140.36'
alias w='ssh -p 666 nico@89.58.13.188'


## Run paleofetch if session is interactive
if status --is-interactive
   fastfetch --load-config neofetch -l gentoo
end
