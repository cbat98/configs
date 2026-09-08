# configs

Personal dotfiles: Neovim, PowerShell, oh-my-posh, Vimium.

```
neovim/      Neovim config (native vim.pack, LSP, treesitter)
powershell/  PowerShell profiles (common.ps1 + per-machine) + scripts added to PATH
oh-my-posh/  prompt themes (rainbow.omp.json is the active one)
vimium/      Vimium browser-extension settings to import by hand
old/         archived NixOS config, no longer used
```

Everything is used on both Linux and Windows unless noted.

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

Symlink the `neovim/` directory to Neovim's config location:

```sh
# Linux
ln -s "$PWD/neovim" ~/.config/nvim

# Windows (PowerShell, as admin or with Developer Mode on)
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim" -Target "$PWD\neovim"
```

Then start `nvim`. First launch will:

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

Symlink `$PROFILE` to the relevant machine script. Adjust the target to wherever
this repo is cloned:

```powershell
# as admin or with Developer Mode on
New-Item -ItemType SymbolicLink -Path $PROFILE -Force `
    -Target "$HOME\repos\configs\powershell\home.ps1"   # or work.ps1
```

`$PROFILE` may not exist yet — create its parent first if needed:
`New-Item -ItemType Directory -Force -Path (Split-Path $PROFILE)`.

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

## oh-my-posh

`oh-my-posh/rainbow.omp.json` is the active theme (referenced by the PowerShell
profiles). The other `*.omp.json` files are alternatives kept for reference.

On Linux the shell that loads it lives outside this repo — init it yourself:

```sh
eval "$(oh-my-posh init bash --config ~/repos/configs/oh-my-posh/rainbow.omp.json)"
```

---

## Vimium

Open the Vimium extension options and paste:

- `vimium/keymaps.txt` → **Custom key mappings**
- `vimium/exclusions.txt` → **Excluded URLs and keys**

There is no sync; re-import after changes.
