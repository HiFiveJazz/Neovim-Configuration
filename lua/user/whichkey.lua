local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

function M.config()
  local mappings = {
    { "<leader>a", group = "Tab" },
    { "<leader>b", group = "Buffers" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "LSP" },
    { "<leader>p", group = "Plugins" },
    { "<leader>T", group = "Treesitter" },
    { "<leader>t", group = "Test" },
    { "<leader>ah", "<cmd>-tabmove<cr>", desc = "Move Left" },
    { "<leader>al", "<cmd>+tabmove<cr>", desc = "Move Right" },
    { "<leader>aN", "<cmd>tabnew %<cr>", desc = "New Tab" },
    { "<leader>an", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
    { "<leader>ao", "<cmd>tabonly<cr>", desc = "Only" },
    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "NOHL" },
    { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
    { "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
    { "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "Terminal" },
  }

  local which_key = require "which-key"
  which_key.setup {
    preset = "helix",
    sort = { "manual", "local", "alphanum", "mod" },
    triggers = {
      { "<auto>", mode = "nixsotc" },
      { "m", mode = "n" },
      { "s", mode = "n" },
      { "c", mode = "n" },
      { "d", mode = "n" },
      { "y", mode = "n" },
    },
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
-- check to ensure that changing window to helix is appropiate, cannot see differences
    win = {
      border = "rounded",
      no_overlap = false,
      padding = { 1, 2},
      title = false,
      title_pos = "center",
      zindex = 1000,
    },
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  local wk = require "which-key"
 
  -- icon colors
  -- azure, blue, cyan, green, grey, orange, purple, red, yellow

  wk.add {
    { "<leader>a", group = "AI", icon = { icon = " ", color = "blue" } },
    { "<leader>b", group = "Buffers" },
    { "<leader>c", group = "Cargo", desc="Rust", icon = { icon = " ", color = "red" } },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find", icon = { icon = " ", color = "yellow" } },
    { "<leader>g", group = "Git" },
    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "NOHL", hidden = true },
    { "<leader>l", group = "LSP", icon = { icon = " ", color = "blue" }},
    { "m", group = "Macros", icon = { icon = " ", color = "green" } },
    { "<leader>p", group = "Plugins", icon = { icon = " ", color = "blue" } },
    { "<leader>o", function() vim.ui.open(vim.fn.expand("<cfile>")) end, desc = "Open URL/File", icon = { icon = " ", color = "blue" } },
    { "<leader>e", desc = "File Explorer", icon = { icon = "" } },
    { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
    { "<leader>T", name = "Treesitter" },
    { "<leader>v", "<cmd>vsplit<CR>", desc = "Split", icon = { icon = "󰖲", color = "cyan",} },
    { "<leader>w", "<cmd>lua vim.wo.wrap = not vim.wo.wrap<CR>", desc = "Toggle Wrap", icon = { icon = "󰖶 ", color = "cyan" } },
    { "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "Terminal", icon = { icon = " ", color = "green" } },


    { "g", group = "Go to" },
    { "gd", desc = "Go to Definition", icon = { icon = "󰗚 " } },
    { "gg", desc = "Go to Top of File", icon = { icon = "󰘣 " } },
    { "gm", desc = "Go to Middle of Line", icon = { icon = "󰘞 " } },
    { "gx", desc = "Go to File/URL", icon = { icon = "󰏋 " } },

    { "c", group = "Change" },
    { "caw", desc = "Change around Word"},
    { "ciw", desc = "Change inside Word"},
    { "cs", desc = "Change Surround" },
    { "ct", desc = "Change Surrounding HTML Tag", icon = { icon = " " }, },

    { "d", group = "Delete" },
    { "ds", desc = "Delete Surround" },
    { "dt", desc = "Delete Surrounding HTML Tag", icon = { icon = " " }, },

    { "y", group = "Yank" },
    { "ys", desc = "Yank Surround" },

    { "s",  group = "Surround" },
    { "sb", desc = "Surround with ()", icon = { icon = "󰅲 " }, },
    { "s{", desc = "Surround with {}", icon = { icon = " " }, },


      -- { "S",  desc = "Surround (newline)", mode = "n" },
      -- { "SS", desc = "Surround line (newline)", mode = "n" },
      -- { "dt", group = "Delete Surround", mode = "n" },
      -- { "ct", group = "Change Surround", mode = "n" },
      -- { "dt", desc = "Delete tag (dst)", mode = "n" },
      -- { "ct", desc = "Change tag (cst)", mode = "n" },
      -- { "cT", desc = "Change tag (csT)", mode = "n" },

    { "g0", hidden = true },
    { "gj", hidden = true },
    { "gk", hidden = true },
    { "g~", hidden = true },
    { "gu", hidden = true },
    { "gU", hidden = true },
    { "gD", hidden = true },
    { "gI", hidden = true },
    { "gO", hidden = true },
    { "gl", hidden = true },
    { "gr", hidden = true },
    { "gb", hidden = true },
    { "gnn", hidden = true },
    { "g'", hidden = true },
    { "g`", hidden = true },
    { "g_", hidden = true },
    { "g*", hidden = true },
    { "g#", hidden = true },
    { "gc", hidden = true },
    { "g%", hidden = true },
    { "cf", hidden = true },
    { "cF", hidden = true },
    { "ct", hidden = true },
    { "cT", hidden = true },
    { "cH", hidden = true },
    { "cL", hidden = true },
    { "c[%", hidden = true },
    { "c]%", hidden = true },
    -- { "ca", hidden = true },

    { "z=", hidden = true },
    { "<leader>oi", hidden = true },
  }
end

return M
