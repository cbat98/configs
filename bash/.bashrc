#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'

alias ls='eza'
alias ll='eza -la'

alias cat='bat'

alias vpn='$HOME/tools/netextender/netExtender -u cbatten -d localdomain mlhq2.microlise.com'

alias lg='lazygit'

# bun
export BUN_INSTALL='$HOME/.bun'
export PATH=$BUN_INSTALL/bin:$PATH

# oh my posh
eval "$(oh-my-posh init bash --config '/home/charlie/repos/configs/oh-my-posh/material-edit.omp.json')"
