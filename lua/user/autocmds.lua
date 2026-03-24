local api = vim.api

local group = api.nvim_create_augroup("UserAutocmds", { clear = true })

-- Don't auto-insert comment leaders on new lines
api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Close certain "utility" buffers with q, and don't list them
api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "query",
  },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true })
  end,
})

-- If you accidentally open the command-line window, just quit it
api.nvim_create_autocmd("CmdWinEnter", {
  group = group,
  callback = function()
    vim.cmd("quit")
  end,
})

-- Equalize splits when the terminal is resized
api.nvim_create_autocmd("VimResized", {
  group = group,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Follow Linux Kernel Rust Indentation Rules
api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 8
  end,
})

-- Follow Linux Kernel C Indentation Rules
api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 8

    -- kernel style prefers simpler indentation logic
    vim.opt_local.cindent = true
    vim.opt_local.smartindent = false

    -- optional: avoid wrapping comments weirdly
    vim.opt_local.textwidth = 80
  end,
})
-- Check if files changed on disk when you focus a window
api.nvim_create_autocmd({ "BufWinEnter", "FocusGained" }, {
  group = group,
  callback = function()
    vim.cmd("checktime")
  end,
})

-- Set titlestring to current directory name
api.nvim_create_autocmd({ "BufWinEnter", "DirChanged" }, {
  group = group,
  callback = function()
    local dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    vim.opt.titlestring = dirname
  end,
})

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 40 })
  end,
})

-- Wrap + spell in commit messages / markdown
api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Luasnip: unlink current snippet on CursorHold (your existing behavior)
api.nvim_create_autocmd("CursorHold", {
  group = group,
  callback = function()
    local ok, luasnip = pcall(require, "luasnip")
    if not ok then return end
    if luasnip.expand_or_jumpable() then
      pcall(function()
        luasnip.unlink_current()
      end)
    end
  end,
})

-- Aerc pager highlighting for mail buffers opened in Neovim
api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
  group = group,
  pattern = { "*", "mail", "text", "markdown" },
  callback = function(ev)
    local buf = ev.buf
    local bt = vim.bo[buf].buftype
    local ft = vim.bo[buf].filetype

    if bt ~= "" then
      return
    end

    if ft ~= "" and ft ~= "mail" and ft ~= "text" and ft ~= "markdown" then
      return
    end

    vim.api.nvim_set_hl(0, "AercUrl", { underline = true, fg = "#9ece6a" })
    vim.api.nvim_set_hl(0, "AercQuote", { italic = true, fg = "#7c7c7c" })

    pcall(vim.fn.matchadd, "AercUrl", "https\\?://[^[:space:]]\\+")
    pcall(vim.fn.matchadd, "AercQuote", "^>.*$")
  end,
})
