local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  -- If you actually want treesitter features (folding, etc.), add this:
  -- dependencies = { "nvim-treesitter/nvim-treesitter" },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<CR>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

  vim.keymap.set("n", "K", function()
    local ok, ufo = pcall(require, "ufo")
    if ok then
      local winid = ufo.peekFoldedLinesUnderCursor()
      if winid then
        return
      end
    end
    vim.lsp.buf.hover()
  end, opts)

  -- Optional: quick import-fix keybind (works great for Go)
  vim.keymap.set("n", "<leader>oi", function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
  end, { desc = "Organize Imports", buffer = bufnr, silent = true })
end

-- Organize imports helper (used in gopls on_attach)
local function organize_imports(bufnr)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }

  local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
  for _, res in pairs(result or {}) do
    for _, action in pairs(res.result or {}) do
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, "utf-16")
      elseif action.command then
        vim.lsp.buf.execute_command(action.command)
      end
    end
  end
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  -- Inlay hints
  if client.supports_method and client:supports_method("textDocument/inlayHint") then
    -- Neovim 0.10/0.11 compatible-ish: try both call shapes
    pcall(function()
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end)
    pcall(function()
      vim.lsp.inlay_hint.enable(bufnr, true)
    end)
  end

  -- ✅ Go: auto-add / organize imports on save (adds fmt, removes unused, sorts)
  if client.name == "gopls" then
    local group = vim.api.nvim_create_augroup("GoImports_" .. bufnr, { clear = true })

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      buffer = bufnr,
      callback = function(args)
        -- 1) organize imports (adds missing like fmt)
        organize_imports(args.buf)
        -- 2) then format (gofmt/gofumpt, etc.)
        vim.lsp.buf.format({ bufnr = args.buf })
      end,
      desc = "Go: organize imports + format on save",
    })
  end
end

M.toggle_inlay_hints = function()
  -- Try multiple APIs across 0.10/0.11
  local ok = pcall(function()
    local enabled = vim.lsp.inlay_hint.is_enabled({})
    vim.lsp.inlay_hint.enable(not enabled, {})
  end)
  if ok then
    return
  end

  pcall(function()
    local enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(not enabled)
  end)
end

function M.common_capabilities()
  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    local caps = cmp_nvim_lsp.default_capabilities()
    caps.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
    return caps
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
  return capabilities
end

function M.config()
  local wk = require("which-key")
  wk.add({
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    {
      "<leader>lf",
      "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      desc = "Format",
    },
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

  local icons = require("user.icons")

  -- NOTE: These names must match nvim-lspconfig server names.
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
    "nginx_language_server",
  }

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
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

  -- Configure each server using Neovim 0.11+ APIs
  for _, server in ipairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }

    local ok, settings = pcall(require, "user.lspsettings." .. server)
    if ok then
      opts = vim.tbl_deep_extend("force", opts, settings)
    end

    -- This is the new recommended way (no require("lspconfig") needed)
    vim.lsp.config(server, opts)
  end

  -- Enable all configured servers
  vim.lsp.enable(servers)
end

return M
