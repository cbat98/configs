local M = {}

local function executable(name)
  return vim.fn.executable(name) == 1
end

local function has_c_compiler()
  return executable("cc")
    or executable("gcc")
    or executable("clang")
    or executable("zig")
end

local function neovim_version_ok()
  return vim.fn.has("nvim-0.12") == 1
end

local is_windows = vim.fn.has("win32") == 1
local is_linux = vim.fn.has("linux") == 1

local hints = {
  neovim = is_windows and "winget install Neovim.Neovim" or "install neovim 0.12+",
  git = is_windows and "winget install Git.Git" or "install git",
  curl = is_windows and "ships with Windows 10+" or "install curl",
  tar = is_windows and "ships with Windows 10+" or "install tar",
  cc = is_windows and "winget install zig.zig" or "install base-devel / a C compiler",
  tree_sitter = is_windows and "npm i -g tree-sitter-cli" or "install tree-sitter-cli",
  npm = is_windows and "winget install OpenJS.NodeJS" or "install nodejs npm",
  rg = is_windows and "winget install BurntSushi.ripgrep.MSVC" or "install ripgrep",
  fd = is_windows and "winget install sharkdp.fd" or "install fd",
}

local function notify(title, lines, level)
  vim.notify(table.concat(lines, "\n"), level, { title = title })
end

--- Hard requirements for vim.pack and first-time setup.
function M.missing_required()
  local missing = {}

  if not neovim_version_ok() then
    missing[#missing + 1] = {
      name = "Neovim 0.12+",
      why = "vim.pack and vim.lsp.config need Neovim 0.12 or newer",
      hint = hints.neovim,
    }
  end

  for _, cmd in ipairs({ "git", "curl", "tar" }) do
    if not executable(cmd) then
      missing[#missing + 1] = {
        name = cmd,
        why = "vim.pack clones and extracts plugins",
        hint = hints[cmd],
      }
    end
  end

  return missing
end

--- Soft requirements: missing tools disable specific features only.
function M.feature_flags()
  local features = {
    treesitter = true,
    mason_npm_lsps = true,
    snacks_picker = true,
  }
  local warnings = {}

  local function warn(feature, name, why)
    features[feature] = false
    warnings[#warnings + 1] = {
      name = name,
      why = why,
      hint = hints[name:gsub("-", "_")] or hints[name] or ("install " .. name),
    }
  end

  if not executable("tree-sitter") then
    warn("treesitter", "tree-sitter", "treesitter parser builds use the tree-sitter CLI")
  elseif not has_c_compiler() then
    warn("treesitter", "cc", "treesitter parser builds need a C compiler")
  end

  if not executable("rg") then
    warn("snacks_picker", "rg", "snacks file grep search needs ripgrep")
  end
  if not executable("fd") then
    warn("snacks_picker", "fd", "snacks file search needs fd")
  end

  if is_linux and not executable("npm") then
    warn("mason_npm_lsps", "npm", "mason installs bash/ansible language servers via npm")
  end

  return features, warnings
end

function M.run()
  local missing = M.missing_required()
  if #missing > 0 then
    local lines = { "Neovim config stopped before loading plugins.", "", "Missing:" }
    for _, item in ipairs(missing) do
      lines[#lines + 1] = ("  • %s — %s (%s)"):format(item.name, item.why, item.hint)
    end
    lines[#lines + 1] = ""
    lines[#lines + 1] = "Fix the items above, then restart Neovim. Run :checkhealth nvim-config for details."
    notify("nvim-config prerequisites", lines, vim.log.levels.ERROR)
    return false
  end

  local features, warnings = M.feature_flags()
  vim.g.nvim_features = features

  if #warnings > 0 then
    local lines = { "Some features are disabled until these tools are installed:", "" }
    for _, item in ipairs(warnings) do
      lines[#lines + 1] = ("  • %s — %s (%s)"):format(item.name, item.why, item.hint)
    end
    lines[#lines + 1] = ""
    lines[#lines + 1] = "Run :checkhealth nvim-config to review prerequisites."
    notify("nvim-config prerequisites", lines, vim.log.levels.WARN)
  end

  return true
end

return M
