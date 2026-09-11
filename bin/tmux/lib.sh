# Sourced by ~/bin/tmux/* wrappers — not meant to be executed directly.
#
# If the tmux session already exists, only switch-client/attach is performed;
# per-window CMDS are not run again.

tmux_launch_multi_window_session() {
	local session_name=$1
	local -n _dirs=$2
	local -n _cmds=$3
	local focus_index="${4:-0}"
	local split_targets_ref="${5:-}"
	local split_dirs_ref="${6:-}"
	local split_cmds_ref="${7:-}"

	if ((${#_dirs[@]} < 1)); then
		echo "error: at least one directory is required" >&2
		return 1
	fi
	if ((focus_index < 0 || focus_index >= ${#_dirs[@]})); then
		echo "error: FOCUS_INDEX ($focus_index) must be between 0 and $((${#_dirs[@]} - 1))" >&2
		return 1
	fi

	# Match tmux window numbering (e.g. set -g base-index 1 in ~/.tmux.conf).
	local base_index
	base_index=$(tmux show -gqv base-index 2>/dev/null || true)
	[[ -z "$base_index" ]] && base_index=0

	local d
	for d in "${_dirs[@]}"; do
		if [[ ! -d "$d" ]]; then
			echo "warning: directory missing, window will use \$HOME: $d" >&2
		fi
	done

	if tmux has-session -t "$session_name" 2>/dev/null; then
		echo "tmux session '$session_name' already exists; switching to it." >&2
		if [[ -n "${TMUX:-}" ]]; then
			tmux switch-client -t "$session_name"
		else
			tmux attach -t "$session_name"
		fi
		return 0
	fi

	local -a resolved=()
	local i
	for ((i = 0; i < ${#_dirs[@]}; i++)); do
		local path="${_dirs[i]}"
		if [[ -d "$path" ]]; then
			resolved+=("$path")
		else
			resolved+=("$HOME")
		fi
	done

	tmux new-session -d -s "$session_name" -c "${resolved[0]}"

	for ((i = 1; i < ${#resolved[@]}; i++)); do
		tmux new-window -t "$session_name:" -c "${resolved[i]}"
	done

	for ((i = 0; i < ${#_dirs[@]}; i++)); do
		local cmd="${_cmds[i]:-}"
		if [[ -n "$cmd" ]]; then
			local twin=$((base_index + i))
			tmux send-keys -t "$session_name:$twin" -l "$cmd"
			tmux send-keys -t "$session_name:$twin" C-m
		fi
	done

	if [[ -n "$split_targets_ref" && -n "$split_dirs_ref" && -n "$split_cmds_ref" ]]; then
		local -n _split_targets=$split_targets_ref
		local -n _split_dirs=$split_dirs_ref
		local -n _split_cmds=$split_cmds_ref

		if ((${#_split_targets[@]} != ${#_split_dirs[@]} || ${#_split_targets[@]} != ${#_split_cmds[@]})); then
			echo "error: split arrays must have equal length" >&2
			return 1
		fi

		for ((i = 0; i < ${#_split_targets[@]}; i++)); do
			local target_offset="${_split_targets[i]}"
			local split_dir="${_split_dirs[i]}"
			local split_cmd="${_split_cmds[i]}"

			if [[ ! "$target_offset" =~ ^[0-9]+$ ]]; then
				echo "error: split target index must be numeric: $target_offset" >&2
				return 1
			fi

			local target_window=$((base_index + target_offset))
			local split_cwd="$split_dir"
			if [[ ! -d "$split_cwd" ]]; then
				echo "warning: split directory missing, pane will use \$HOME: $split_cwd" >&2
				split_cwd="$HOME"
			fi

			local pane_id
			pane_id=$(tmux split-window -h -P -F "#{pane_id}" -t "$session_name:$target_window" -c "$split_cwd")
			if [[ -n "$split_cmd" ]]; then
				tmux send-keys -t "$pane_id" -l "$split_cmd"
				tmux send-keys -t "$pane_id" C-m
			fi
		done
	fi

	tmux select-window -t "$session_name:$((base_index + focus_index))"

	if [[ -n "${TMUX:-}" ]]; then
		tmux switch-client -t "$session_name"
	else
		tmux attach -t "$session_name"
	fi
}
