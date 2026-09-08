local M = {}

local function report(level, msg)
  vim.health[ level == "ok" and "ok" or level == "warn" and "warn" or "error" ](msg)
end

function M.check()
  local prereqs = require("config.prereqs")

  vim.health.start("Neovim version")
  if vim.fn.has("nvim-0.12") == 1 then
    report("ok", "Neovim 0.12+")
  else
    report("error", "Neovim 0.12+ is required (vim.pack, vim.lsp.config)")
  end

  vim.health.start("Required tools (vim.pack)")
  for _, cmd in ipairs({ "git", "curl", "tar" }) do
    if vim.fn.executable(cmd) == 1 then
      report("ok", cmd .. " is available")
    else
      report("error", cmd .. " is missing")
    end
  end

  vim.health.start("Treesitter")
  if vim.fn.executable("tree-sitter") == 1 then
    report("ok", "tree-sitter CLI is available")
  else
    report("warn", "tree-sitter CLI is missing; syntax highlighting via treesitter is disabled")
  end
  if vim.fn.executable("cc") == 1
    or vim.fn.executable("gcc") == 1
    or vim.fn.executable("clang") == 1
    or vim.fn.executable("zig") == 1
  then
    report("ok", "C compiler is available")
  else
    report("warn", "no C compiler found; treesitter parser builds will fail")
  end

  vim.health.start("Snacks picker")
  for _, cmd in ipairs({ "rg", "fd" }) do
    if vim.fn.executable(cmd) == 1 then
      report("ok", cmd .. " is available")
    else
      report("warn", cmd .. " is missing; snacks picker search is disabled")
    end
  end

  vim.health.start("Mason language servers")
  if vim.fn.has("linux") == 1 then
    if vim.fn.executable("npm") == 1 then
      report("ok", "npm is available for bash/ansible language servers")
    else
      report("warn", "npm is missing; only lua_ls will be installed via mason")
    end
  elseif vim.fn.has("win32") == 1 then
    report("ok", "powershell_es is installed via mason on Windows")
  else
    report("ok", "platform-specific mason servers are not configured")
  end

  local missing = prereqs.missing_required()
  if #missing > 0 then
    vim.health.start("Summary")
    report("error", "required prerequisites are missing; plugins were not loaded")
    return
  end

  local features = vim.g.nvim_features
  if features then
    vim.health.start("Active feature flags")
    for name, enabled in pairs(features) do
      if enabled then
        report("ok", name)
      else
        report("warn", name .. " is disabled")
      end
    end
  end
end

return M
