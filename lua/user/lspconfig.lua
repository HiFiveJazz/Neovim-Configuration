-- lua/user/lspconfig.lua
local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
}

-- =========================
-- Buffer keymaps for LSP
-- =========================
local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap

  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "<CR>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

  -- Nice hover that yields to ufo fold preview if present
  vim.keymap.set("n", "K", function()
    local ok, ufo = pcall(require, "ufo")
    if ok then
      local winid = ufo.peekFoldedLinesUnderCursor()
      if winid then return end
    end
    vim.lsp.buf.hover()
  end, { buffer = bufnr, silent = true })

  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

-- =========================
-- Inlay-hint helpers (0.10/0.11 compatible)
-- =========================
local ih = vim.lsp.inlay_hint

local function ih_enable(bufnr)
  if ih.enable then ih.enable(true, { bufnr = bufnr }) else ih(bufnr, true) end
end

local function ih_disable(bufnr)
  if ih.enable then ih.enable(false, { bufnr = bufnr }) else ih(bufnr, false) end
end

local function ih_is_enabled(bufnr)
  if ih.is_enabled then return ih.is_enabled({ bufnr = bufnr }) end
  return true -- best-effort on older API
end

-- =========================
-- Exported: attach, toggle, capabilities
-- =========================
M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  -- Rust-specific: semantic tokens collide with inlay-hint extmarks on line inserts
  if client.name == "rust_analyzer" then
    client.server_capabilities.semanticTokensProvider = nil
  end

  -- Enable & safely refresh inlay hints for servers that support them
  if client.supports_method("textDocument/inlayHint") then
    pcall(ih_enable, bufnr)

    -- Hide during insert (columns shift), re-show after edits to avoid extmark "col out of range"
    vim.api.nvim_create_autocmd("InsertEnter", {
      buffer = bufnr,
      callback = function()
        if ih_is_enabled(bufnr) then pcall(ih_disable, bufnr) end
      end,
    })

    vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "TextChangedI" }, {
      buffer = bufnr,
      callback = function()
        pcall(ih_disable, bufnr)
        pcall(ih_enable, bufnr)
      end,
    })
  end
end

M.toggle_inlay_hints = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local enabled = ih_is_enabled(bufnr)
  if ih.enable then ih.enable(not enabled, { bufnr = bufnr }) else ih(bufnr, not enabled) end
end

function M.common_capabilities()
  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  return capabilities
end

-- =========================
-- Plugin config
-- =========================
function M.config()
  -- Which-key registrations
  local ok_wk, wk = pcall(require, "which-key")
  if ok_wk then
    wk.add({
      { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>", desc = "Format" },
      { "<leader>lh", "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>", desc = "Hints" },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
      { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
      { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
      { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
      { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
    })
    wk.add({
      { "<leader>la", group = "LSP" },
      { "<leader>laa", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", mode = "v" },
    })
  end

  -- Diagnostics look & feel
  local icons = require("user.icons")
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN]  = icons.diagnostics.Warning,
        [vim.diagnostic.severity.HINT]  = icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO]  = icons.diagnostics.Information,
      },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      header = "",
      prefix = "",
    },
  })

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

  -- Border for lspconfig UI windows
  local ok_ui, lspui = pcall(require, "lspconfig.ui.windows")
  if ok_ui then lspui.default_options.border = "rounded" end

  -- Servers to configure here (skip rust_analyzer → rustaceanvim owns it)
  local servers = {
    "asm_lsp",
    "lua_ls",
    "pyright",
    "cssls",
    "html",
    "ts_ls",
    "eslint",
    "tailwindcss",
    "jsonls",
    "bashls",
    "matlab_ls",
    "csharp_ls",
    "zls",
    "texlab",
    "vale_ls",
    "vimls",
    "gopls",
    "templ",
    "biome",
    "nginx_language_server", -- correct lspconfig key (snake_case)
  }

  local lspconfig = require("lspconfig")
  for _, server in ipairs(servers) do
    if server ~= "rust_analyzer" then
      local opts = {
        on_attach = M.on_attach,
        capabilities = M.common_capabilities(),
      }

      -- Per-server overrides (optional files in lua/user/lspsettings/)
      local ok_local, local_opts = pcall(require, "user.lspsettings." .. server)
      if ok_local then
        opts = vim.tbl_deep_extend("force", opts, local_opts)
      end

      -- Setup
      if lspconfig[server] then
        lspconfig[server].setup(opts)
      else
        vim.schedule(function()
          vim.notify(("lspconfig: server '%s' not found"):format(server), vim.log.levels.WARN)
        end)
      end
    end
  end
end

return M

