#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'

alias lg='lazygit'

# oh my posh
eval "$(oh-my-posh init bash --config '/home/charlie/repos/configs/oh-my-posh/material-edit.omp.json')"
source /usr/share/nvm/init-nvm.sh
