# configs

Personal dotfiles: Neovim, PowerShell, oh-my-posh, Vimium.

```
neovim/      Neovim config (native vim.pack, LSP, treesitter)
powershell/  PowerShell profile + scripts added to PATH
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
| C compiler | compiles treesitter parsers | `base-devel` | `scoop install zig` (nvim-treesitter picks it up) |
| **tree-sitter CLI** | treesitter `main` branch builds parsers with it | `tree-sitter-cli` | `npm i -g tree-sitter-cli` or `scoop install tree-sitter` |
| Node.js + npm | mason installs the language servers (bash / ansible) | `nodejs npm` | `winget install OpenJS.NodeJS` |
| `ripgrep`, `fd` | `snacks.picker` grep / file search | `ripgrep fd` | `winget install BurntSushi.ripgrep.MSVC sharkdp.fd` |
| A Nerd Font | icons in the picker / statusline | any Nerd Font | any Nerd Font |

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

- PowerShell 7+ (`pwsh`)
- [`oh-my-posh`](https://ohmyposh.dev) — `winget install JanDeDobbeleer.OhMyPosh` / `yay -S oh-my-posh-bin`
- `eza` — used by the `ll` / `lt` helpers
- `git`
- A Nerd Font (the prompt theme uses glyphs)

### Install

Point your `$PROFILE` at the relevant script. Adjust the path to wherever this repo is cloned:

```powershell
# in $PROFILE  (run `notepad $PROFILE`)
. "$HOME\repos\configs\powershell\home.ps1"     # home machine
# or
. "$HOME\repos\configs\powershell\work.ps1"     # work machine
```

Each script:

- adds `powershell/path/` to `PATH` (the `*.ps1` helpers become commands),
- initialises oh-my-posh with `oh-my-posh/rainbow.omp.json`,
- defines aliases (`gs`, `g`, `lt`, `tw`, …).

`home.ps1` and `work.ps1` differ only in machine-specific paths.

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
