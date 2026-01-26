local M = {
  "nosduco/remote-sshfs.nvim",
  cmd = {
    "RemoteSSHFSConnect",
    "RemoteSSHFSDisconnect",
    "RemoteSSHFSList",
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
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

return M

