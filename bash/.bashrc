#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias lg='lazygit'
alias ff='fastfetch -c all.jsonc'

# oh my posh
eval "$(oh-my-posh init bash --config '/home/charlie/Repos/configs/oh-my-posh/material-edit.omp.json')"
source /usr/share/nvm/init-nvm.sh
