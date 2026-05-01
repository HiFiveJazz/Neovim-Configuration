local M = {
  "nosduco/remote-sshfs.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "folke/which-key.nvim",
  },
}

function M.config()
  require("remote-sshfs").setup({
    connections = {
      ssh_configs = {
        vim.fn.expand("$HOME/.ssh/config"),
        "/etc/ssh/ssh_config",
      },
      ssh_known_hosts = vim.fn.expand("$HOME/.ssh/known_hosts"),
      sshfs_args = {
        "-o reconnect",
        "-o ConnectTimeout=5",
      },
    },
    mounts = {
      base_dir = vim.fn.expand("$HOME/.sshfs/"),
      unmount_on_exit = true,
    },
    handlers = {
      on_connect = {
        change_dir = true,
      },
      on_disconnect = {
        clean_mount_folders = false,
      },
      on_edit = {},
    },
    ui = {
      select_prompts = false,
      confirm = {
        connect = true,
        change_dir = false,
      },
    },
    log = {
      enabled = false,
      truncate = false,
      types = {
        all = false,
        util = false,
        handler = false,
        sshfs = false,
      },
    },
  })
end

local wk = require "which-key"
wk.add {
    { "<leader>rc", "<cmd>RemoteSSHFSConnect<CR>", desc = "Connect", icon = { icon = "󰌘", color = "green"} },
    { "<leader>rd", "<cmd>RemoteSSHFSDisconnect<CR>", desc = "Disconnect", icon = { icon = "󰌙", color = "green"} },
    { "<leader>rl", "<cmd>RemoteSSHFSList<CR>", desc = "List Connections", icon = { icon = "󰋁", color = "green"} },
}

return M
