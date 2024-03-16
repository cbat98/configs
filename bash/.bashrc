#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If running in tty1, start Hyprland
if [ "$(tty)" = "/dev/tty1" ] && which Hyprland > /dev/null 2>&1; then
    exec Hyprland
fi

alias grep='grep --color=auto'

alias ls='eza'
alias ll='eza -la'

alias cat='bat'

alias lg='lazygit'

# oh my posh
eval "$(oh-my-posh init bash --config '/home/charlie/repos/configs/oh-my-posh/material-edit.omp.json')"
source /usr/share/nvm/init-nvm.sh
