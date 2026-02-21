local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  -- If you actually want treesitter features (folding, etc.), add this:
  -- dependencies = { "nvim-treesitter/nvim-treesitter" },
}

-- Helper: install a buffer-local <leader>q that returns to origin and deletes this buffer
local function install_return_q(dest_buf, origin_buf)
  -- Tag destination buffer with where we came from
  vim.b[dest_buf].gd_return_buf = origin_buf

  vim.keymap.set("n", "<leader>q", function()
    local ret = vim.b.gd_return_buf
    local cur = vim.api.nvim_get_current_buf()

    -- Go back first
    if type(ret) == "number" and vim.api.nvim_buf_is_valid(ret) then
      vim.cmd("buffer " .. ret)
    else
      vim.cmd("bprevious")
    end

    -- Then delete the definition buffer
    local ok, bd = pcall(require, "bufdelete")
    if ok then
      bd.bufdelete(cur, false)
    else
      pcall(vim.api.nvim_buf_delete, cur, { force = false })
    end
  end, {
    buffer = dest_buf,
    silent = true,
    desc = "Close definition buffer and return",
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

  -- SMART gd:
  -- Call LSP definition, then (reliably) detect the destination buffer and
  -- install a buffer-local <leader>q that returns to the origin buffer.
  vim.keymap.set("n", "gd", function()
    local origin_buf = vim.api.nvim_get_current_buf()
    local origin_win = vim.api.nvim_get_current_win()

    vim.lsp.buf.definition()

    -- Retry until the buffer in the original window changes (async-safe).
    local tries = 0
    local max_tries = 25        -- ~25 * 20ms = 500ms worst-case
    local delay_ms = 20

    local function poll()
      tries = tries + 1
      if not vim.api.nvim_win_is_valid(origin_win) then return end

      local dest_buf = vim.api.nvim_win_get_buf(origin_win)

      if dest_buf ~= origin_buf then
        install_return_q(dest_buf, origin_buf)
        return
      end

      if tries < max_tries then
        vim.defer_fn(poll, delay_ms)
      end
    end

    vim.defer_fn(poll, 0)
  end, opts)

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

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("InitLuaSmartGd", { clear = true }),
  pattern = "*/nvim/init.lua", -- adjust if needed
  callback = function(ev)
    local function open_module_under_cursor_same_window()
      local s = vim.fn.expand("<cfile>")
      if not s or s == "" then return false end
      s = s:gsub([[^['"]+]], ""):gsub([[['"]+$]], "")

      -- only handle your init.lua modules
      if not s:match("^user%.") then return false end

      local rel1 = "lua/" .. s:gsub("%.", "/") .. ".lua"
      local rel2 = "lua/" .. s:gsub("%.", "/") .. "/init.lua"
      local found = vim.api.nvim_get_runtime_file(rel1, false)[1]
        or vim.api.nvim_get_runtime_file(rel2, false)[1]
      if not found or found == "" then return false end

      -- mark current spot so you can jump back (for <C-o>)
      vim.cmd("normal! m'")

      local origin_buf = ev.buf
      local origin_win = vim.api.nvim_get_current_win()

      -- edit in the same window (new buffer)
      vim.cmd("edit " .. vim.fn.fnameescape(found))

      -- install the same return behavior using <leader>q
      local dest_buf = vim.api.nvim_win_get_buf(origin_win)
      install_return_q(dest_buf, origin_buf)

      return true
    end

    vim.keymap.set("n", "gd", function()
      if not open_module_under_cursor_same_window() then
        vim.lsp.buf.definition()
      end
    end, { buffer = ev.buf, silent = true, desc = "init.lua: open module buffer / LSP definition" })
  end,
})

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

  vim.lsp.enable("rust_analyzer", false) -- rustaceanvim should own Rust LSP; do NOT start rust_analyzer via core LSP config.
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
    "asm-lsp",
    "lua_ls",
    "pyright",
    "cssls",
    "html",
    -- "ts_ls",
    -- "jsonls",
    "bashls",
    -- "matlab_ls",
    -- "csharp_ls",
    "texlab",
    "vale_ls",
    -- "vimls",
    "gopls",
    -- "biome",
    -- "nginx_language_server",
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

