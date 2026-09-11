# Custom functions and aliases (sourced from ~/.bashrc)

# Interactive shells (local or SSH): attach to tmux session "default", or create it.
# Skip if already inside tmux, tmux is missing, the terminal cannot run it, or SKIP_TMUX is set (e.g. SKIP_TMUX=1 ssh host).
if [[ $- == *i* ]] &&
	[[ -z "${TMUX:-}" ]] &&
	[[ -z "${SKIP_TMUX:-}" ]] &&
	command -v tmux &>/dev/null &&
	[[ "${TERM:-}" != dumb ]]
then
	exec tmux new-session -A -s default
fi

shopt -s expand_aliases

tfa() {
    terraform apply --auto-approve --parallelism="${1:-5}"
}

lt() {
    local depth="${1:-2}"
    # Shift args to pass to eza
    shift $(( $# > 0 ? 1 : 0 ))
    eza --tree --level="$depth" "$@"
}

waitfor() {
  local wait date_wait run_time
  wait=$1
  if [[ -z $wait ]]; then
    echo "usage: waitfor <duration> (e.g. 30, 1m, 2h)" >&2
    return 1
  fi

  date_wait=$(echo "$wait" | sed -E 's/([0-9]+)s?$/\1 seconds/; s/([0-9]+)m$/\1 minutes/; s/([0-9]+)h$/\1 hours/; s/([0-9]+)d$/\1 days/')
  run_time=$(date -d "+$date_wait" +"%H:%M:%S")

  echo "Waiting until: $run_time ($date_wait from now)"
  sleep "$wait"
}

gl() {
    git log --oneline -n "${1:-10}"
}

alias gs='git status'
alias ll='ls -alF --color=auto'

OMP_CONFIG="${HOME}/repos/configs/oh-my-posh/rainbow.omp.json"
if command -v oh-my-posh &>/dev/null && [[ -f "$OMP_CONFIG" ]]; then
	eval "$(oh-my-posh init bash --config "$OMP_CONFIG")"
fi

if [[ ! ${BASH_COMPLETION_VERSINFO:-} ]] && [[ -f /usr/share/bash-completion/bash_completion ]]
then
    . /usr/share/bash-completion/bash_completion
fi

bind 'set bell-style none'

if [[ -f "/usr/share/nvm/init-nvm.sh" ]]; then
    source /usr/share/nvm/init-nvm.sh
fi
