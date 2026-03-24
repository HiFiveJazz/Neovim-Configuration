local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = LAZY_PLUGIN_SPEC,
  install = {
    colorscheme = { "darkplus", "default" },
  },
  ui = {
    border = "rounded",
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
}

local wk = require "which-key"
wk.add {
    { "<leader>pc", "<cmd>Lazy clean<cr>", desc = "Clean",icon = { icon = "󰫩 ", color = "blue" }  },
    { "<leader>pd", "<cmd>Lazy debug<cr>", desc = "Debug",icon = { icon = "󱡴 ", color = "blue" }  },
    { "<leader>ph", "<cmd>Lazy<cr>", desc = "Home",icon = { icon = "󰋜 ", color = "blue" }  },
    { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install",icon = { icon = "󰇚 ", color = "blue" }  },
    { "<leader>pl", "<cmd>Lazy log<cr>", desc = "Log",icon = { icon = "󱖫 ", color = "blue" }  },
    { "<leader>pp", "<cmd>Lazy profile<cr>", desc = "Profile", icon = { icon = " ", color = "blue" } },
    { "<leader>pS", "<cmd>Lazy clear<cr>", desc = "Status",icon = { icon = " ", color = "blue" }  },
    { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync",icon = { icon = " ", color = "blue" }  },
    { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update",icon = { icon = "󰚰 ", color = "blue" }  },
}
