local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
}

local STATE_FILE = vim.fn.stdpath("data") .. "/harpoon-line-marks.json"
local SIGN_NAME = "HarpoonMarkSign"
local SIGN_GROUP = "HarpoonMarkGroup"

-- path -> { bufnr = ..., row = ... }
M.line_marks = {}
-- path -> row
M.saved_rows = {}

local function normalize(path)
  return vim.fn.fnamemodify(path, ":p")
end

local function load_state()
  local ok, lines = pcall(vim.fn.readfile, STATE_FILE)
  if not ok or not lines or vim.tbl_isempty(lines) then
    M.saved_rows = {}
    return
  end

  local ok_decode, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
  if ok_decode and type(decoded) == "table" then
    M.saved_rows = decoded
  else
    M.saved_rows = {}
  end
end

local function save_state()
  local ok_encode, encoded = pcall(vim.json.encode, M.saved_rows)
  if not ok_encode then
    return
  end
  pcall(vim.fn.writefile, { encoded }, STATE_FILE)
end

local function find_in_list(list, path)
  local target = normalize(path)

  for i, item in ipairs(list.items or {}) do
    if item and item.value and normalize(item.value) == target then
      return i
    end
  end

  return nil
end

local function clear_mark(path, bufnr)
  local existing = M.line_marks[path]

  if existing and vim.api.nvim_buf_is_valid(existing.bufnr) then
    pcall(vim.fn.sign_unplace, SIGN_GROUP, { buffer = existing.bufnr })
  end

  if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
    pcall(vim.fn.sign_unplace, SIGN_GROUP, { buffer = bufnr })
  end

  M.line_marks[path] = nil
end

local function place_mark(bufnr, path, row)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local line_count = vim.api.nvim_buf_line_count(bufnr)
  row = math.max(0, math.min(row or 0, line_count - 1))

  clear_mark(path, bufnr)

  vim.fn.sign_place(
    0,
    SIGN_GROUP,
    SIGN_NAME,
    bufnr,
    { lnum = row + 1, priority = 6 }
  )

  M.line_marks[path] = {
    bufnr = bufnr,
    row = row,
  }
end

local function restore_mark_for_buf(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local harpoon = require("harpoon")
  local list = harpoon:list()
  local path = vim.api.nvim_buf_get_name(bufnr)

  if path == "" then
    return
  end

  path = normalize(path)

  if not find_in_list(list, path) then
    clear_mark(path, bufnr)
    M.saved_rows[path] = nil
    save_state()
    return
  end

  -- already restored for this live buffer; don't place again
  local existing = M.line_marks[path]
  if existing and existing.bufnr == bufnr and vim.api.nvim_buf_is_valid(existing.bufnr) then
    return
  end

  local row = M.saved_rows[path] or 0
  place_mark(bufnr, path, row)
end

function M.config()
  local harpoon = require("harpoon")
  harpoon:setup({})

  load_state()

  vim.api.nvim_set_hl(0, "HarpoonSign", { link = "TelescopePromptPrefix" })

  vim.fn.sign_define(SIGN_NAME, {
    text = "󱡅",
    texthl = "HarpoonSign",
  })

  vim.opt.signcolumn = "yes:1"

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  keymap("n", "<S-m>", function()
    require("user.extras.harpoon").mark_file()
  end, opts)

  keymap("n", "<Tab>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, opts)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "harpoon",
    callback = function()
      vim.cmd([[highlight link HarpoonBorder TelescopeBorder]])
    end,
  })

  -- only restore when a file is actually read/opened
  vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
      restore_mark_for_buf(args.buf)
    end,
  })
end

function M.mark_file()
  local harpoon = require("harpoon")
  local list = harpoon:list()
  local bufnr = vim.api.nvim_get_current_buf()
  local path = vim.api.nvim_buf_get_name(bufnr)

  if path == "" then
    vim.notify("Cannot harpoon an unnamed buffer", vim.log.levels.WARN)
    return
  end

  path = normalize(path)
  local existing_index = find_in_list(list, path)

  if existing_index then
    if list.remove_at then
      list:remove_at(existing_index)
    elseif list.removeAt then
      list:removeAt(existing_index)
    else
      table.remove(list.items, existing_index)
    end

    clear_mark(path, bufnr)
    M.saved_rows[path] = nil
    save_state()
    vim.notify(" Unmarked File")
    return
  end

  local row = vim.api.nvim_win_get_cursor(0)[1] - 1

  list:add()
  M.saved_rows[path] = row
  save_state()
  place_mark(bufnr, path, row)

  vim.notify("󱡅  Marked File")
end

return M
