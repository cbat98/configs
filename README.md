# configs

Personal dotfiles: Neovim, PowerShell, bash, git, tmux, konsole, oh-my-posh, Vimium.

```
neovim/      Neovim config (native vim.pack, LSP, treesitter)
powershell/  PowerShell profiles (common.ps1 + per-machine) + scripts added to PATH
bash/        .bashrc + .bashrc.d/ (Linux only)
git/         .gitconfig (+ template for the gitignored .gitconfig.local)
tmux/        .tmux.conf (Linux only)
konsole/     konsolerc + profile for the Konsole terminal emulator (Linux only)
bin/         shell scripts symlinked onto PATH as ~/bin (Linux only)
oh-my-posh/  prompt themes (rainbow.omp.json is the active one)
vimium/      Vimium browser-extension settings to import by hand
install/     links.tsv manifest + install.sh / Install.ps1 (see below)
old/         archived NixOS config, no longer used
```

Everything is used on both Linux and Windows unless noted.

---

## Install

Everything in this repo that lives at a fixed path is symlinked into place —
nothing is copied — so editing the linked path edits the tracked file
directly. `install/links.tsv` is the single source of truth for what links
where; `-` in a column means "not linked on that OS".

```sh
# Linux
./install/install.sh

# Windows (PowerShell, as Administrator or with Developer Mode on)
.\install\Install.ps1              # links powershell/home.ps1 as $PROFILE
.\install\Install.ps1 -Profile work
```

Both scripts are idempotent: a link that's already correct is left alone, and
anything real in the way is renamed to `<path>.bak-<timestamp>` rather than
overwritten. To add a new linked file, add a row to `links.tsv` and re-run.

Not covered by the manifest, since neither can be symlinked:

- **Vimium** — see the [Vimium](#vimium) section below, import by hand.
- **oh-my-posh** — referenced by path from the PowerShell profiles and the
  bash init line below; no separate linking needed.

---

## Neovim

### Requirements

| Need | Why | Linux (Arch) | Windows |
|------|-----|--------------|---------|
| Neovim **0.12+** | uses `vim.pack`, `vim.lsp.config`, treesitter `main` | `neovim` | `winget install Neovim.Neovim` |
| `git`, `curl`, `tar` | `vim.pack` clones, treesitter downloads | `git` (curl/tar in base) | `winget install Git.Git` (curl/tar ship with Win10+) |
| C compiler (`gcc`) | compiles treesitter parsers | `base-devel` | `winget install BrechtSanders.WinLibs.POSIX.UCRT` |
| **tree-sitter CLI** | treesitter `main` branch builds parsers with it | `tree-sitter-cli` | `npm i -g tree-sitter-cli` |
| Node.js + npm | mason installs the language servers (bash / ansible) | `nodejs npm` | `winget install OpenJS.NodeJS` |
| `ripgrep`, `fd` | `snacks.picker` grep / file search | `ripgrep fd` | `winget install BurntSushi.ripgrep.MSVC sharkdp.fd` |
| A Nerd Font | icons in the picker / statusline | any Nerd Font | `winget install DEVCOM.JetBrainsMonoNerdFont` |

Windows package installs prefer `winget`; `npm` is only used where winget has no package.

#### Treesitter parsers on Windows

The `tree-sitter` CLI (installed via npm) is built for MSVC, so by default it looks
for `cl.exe`. We use **MinGW-w64** (`gcc`) instead — smaller than Visual Studio
Build Tools and enough for compiling parsers.

1. Install WinLibs (adds `gcc` to `PATH`):

   ```powershell
   winget install BrechtSanders.WinLibs.POSIX.UCRT
   ```

   Any MinGW-w64 distribution works as long as `gcc` is on `PATH`; WinLibs is
   what we install via winget.

2. Start Neovim from a **new terminal** so it picks up the updated `PATH`.

`neovim/init.lua` sets these before plugins load when `gcc` is found:

- `TARGET=x86_64-pc-windows-gnu` — the MSVC-built `tree-sitter` binary otherwise
  targets MSVC and passes flags `gcc` cannot handle
- `CC=gcc`

If parser builds still fail, run `:checkhealth nvim-config` and confirm `gcc` is
listed under Treesitter. Rebuild parsers with `:TSUpdate`.

**Alternative:** install [Visual Studio Build Tools](https://visualstudio.microsoft.com/downloads/)
with the "Desktop development with C++" workload and remove the `TARGET`/`CC`
block from `init.lua` if you prefer the native MSVC toolchain.

Language servers are installed automatically by mason on first launch:

- **all hosts:** `lua_ls`
- **Linux only:** `ansible-language-server`, `bash-language-server`
- **Windows only:** `powershell-editor-services`

### Install

Linked by the [top-level installer](#install) (`neovim/` → `~/.config/nvim` on
Linux, `%LOCALAPPDATA%\nvim` on Windows). Then start `nvim`. First launch will:

1. clone all plugins (`vim.pack`),
2. compile treesitter parsers,
3. install the language servers via mason.

Give it a minute and restart once it settles.

### Updating

- **Plugins:** `<leader>pu` (runs `vim.pack.update()`) — opens a diff buffer; `:w` to apply, `:q` to cancel.
- **Treesitter parsers:** `:TSUpdate` (also runs automatically when the plugin updates).
- **Language servers:** `:Mason`.

Plugin revisions are recorded in `neovim/nvim-pack-lock.json`, which `vim.pack` manages itself.

---

## PowerShell

Used mainly on Windows; works under `pwsh` on Linux too.

### Requirements

- PowerShell 7+ (`pwsh`) — `winget install Microsoft.PowerShell`
- [`oh-my-posh`](https://ohmyposh.dev) — `winget install JanDeDobbeleer.OhMyPosh` (Linux: `yay -S oh-my-posh-bin`)
- `eza` — `winget install eza-community.eza` — used by the `ll` / `lt` helpers
- `git` — `winget install Git.Git`
- A Nerd Font (the prompt theme uses glyphs)

### Install

Linked by the [top-level installer](#install): `.\install\Install.ps1` links
`powershell/home.ps1` as `$PROFILE`; `.\install\Install.ps1 -Profile work`
links `work.ps1` instead. The installer creates `$PROFILE`'s parent directory
if it doesn't exist yet.

Structure:

- `home.ps1` / `work.ps1` set the machine-specific `$repos` / `$configs` paths
  (and, on work, an extra `PATH` entry plus an auto-generated shell-integration
  block), then dot-source `common.ps1`.
- `common.ps1` holds everything shared: it adds `powershell/path/` to `PATH` (the
  `*.ps1` helpers become commands), defines the shell shorthands (`ll`, `lt`,
  `gs`, `g`, `gitopen`, `tw`, `vim`, `npp`), and initialises oh-my-posh with
  `oh-my-posh/rainbow.omp.json`.

Because `$PROFILE` is the symlink, editing it edits the tracked repo file.

Where a helper lives follows one rule:

- **Alias** — only a new name for a single command, no logic (`npp`).
- **Function in `common.ps1`** — a terse shorthand you reach for most sessions,
  that is trivial or needs to touch the live session. Named short and lowercase.
- **Script in `path/`** — anything with real parameters, worth a `Get-Help`, or
  that runs fine as its own process. Named `Verb-Noun`. A shorthand may wrap one
  (`tw` → `Remove-TrailingWhitespace.ps1`).

### Secrets

`powershell/loose-files/` is git-ignored. `Update-CloudflareDNS.ps1` expects a
`cloudflarekey` file there; `Get-Creds` / `Set-Creds` manage local credentials.

---

## bash

Linux only. `bash/bashrc` → `~/.bashrc`, `bash/bashrc.d/` → `~/.bashrc.d/`
(everything in there gets sourced). `custom.sh` holds shell functions and
aliases, and also inits oh-my-posh (see below); `ansible.sh` sets
Ansible-related environment variables.

## git

`git/gitconfig` → `~/.gitconfig`. It includes `~/.gitconfig.local`, which is
git-ignored and per-machine — copy `git/gitconfig.local.template` there and
fill in `[user]`.

## tmux

Linux only. `tmux/tmux.conf` → `~/.tmux.conf`.

## konsole

Linux only. Settings for the [Konsole](https://konsole.kde.org) terminal
emulator: `konsole/konsolerc` → `~/.config/konsolerc`,
`konsole/data/Charlie.profile` → `~/.local/share/konsole/Charlie.profile`.

## bin

Linux only. Shell scripts linked as `~/bin`, which `.bashrc` puts on `PATH` —
each script becomes a command. `git-repos-fetch-status` and `tmux-helper` /
`tmux/` (`forti`, `lib.sh`, `virt`) back the `virt` tmux-session helper.

---

## oh-my-posh

`oh-my-posh/rainbow.omp.json` is the active theme (referenced by the
PowerShell profiles and, on Linux, `bash/bashrc.d/custom.sh`). The other
`*.omp.json` files are alternatives kept for reference.

```sh
eval "$(oh-my-posh init bash --config ~/repos/configs/oh-my-posh/rainbow.omp.json)"
```

---

## Vimium

Open the Vimium extension options and paste:

- `vimium/keymaps.txt` → **Custom key mappings**
- `vimium/exclusions.txt` → **Excluded URLs and keys**

There is no sync; re-import after changes.
