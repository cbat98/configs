#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'

alias ls='eza'
alias ll='eza -la'

alias cat='bat'

alias lg='lazygit'

# oh my posh
eval "$(oh-my-posh init bash --config '/home/charlie/repos/configs/oh-my-posh/material-edit.omp.json')"
