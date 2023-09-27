#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
source /usr/share/nvm/init-nvm.sh

alias ls='eza'
alias ll='eza -la'

alias cat='bat'

alias vpn='$HOME/tools/netextender/netExtender -u cbatten -d localdomain mlhq2.microlise.com'

# bun
export BUN_INSTALL='$HOME/.bun'
export PATH=$BUN_INSTALL/bin:$PATH

eval "$(oh-my-posh init bash --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/material.omp.json')"
eval "$(oh-my-posh init bash --config '/home/charlie/repos/configs/oh-my-posh/material-edit.omp.json')"
