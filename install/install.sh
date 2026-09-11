#!/usr/bin/env bash
# Symlinks everything in links.tsv (linux column) into place.
# Safe to re-run: correct links are left alone, real files/dirs in the way are
# backed up with a .bak-<timestamp> suffix rather than overwritten.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="$repo_root/install/links.tsv"
stamp="$(date +%Y%m%d%H%M%S)"

while IFS=$'\t' read -r source linux _windows; do
	[[ -z "$source" || "$source" == \#* ]] && continue
	[[ "$linux" == "-" ]] && continue

	src="$repo_root/$source"
	dest="${linux/#\~/$HOME}"

	if [[ ! -e "$src" ]]; then
		echo "skip: $source (source missing)" >&2
		continue
	fi

	if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
		echo "ok:   $dest -> $source"
		continue
	fi

	mkdir -p "$(dirname "$dest")"

	if [[ -e "$dest" || -L "$dest" ]]; then
		echo "backup: $dest -> $dest.bak-$stamp"
		mv "$dest" "$dest.bak-$stamp"
	fi

	ln -s "$src" "$dest"
	echo "linked: $dest -> $source"
done < "$manifest"
