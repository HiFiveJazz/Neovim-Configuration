local M = {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    {
      -- "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
      "nvim-neotest/nvim-nio"
    },
  },
}
function M.config()

  local dap = require("dap")
  local ui = require("dapui")
  require("dapui").setup()

  -- Python
  dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
      ---@diagnostic disable-next-line: undefined-field
      local port = (config.connect or config).port
      ---@diagnostic disable-next-line: undefined-field
      local host = (config.connect or config).host or '127.0.0.1'
      cb({
        type = 'server',
        port = assert(port, '`connect.port` is required for a python `attach` configuration'),
        host = host,
        options = {
          source_filetype = 'python',
        },
      })
    else
      cb({
        type = 'executable',
        command = '/home/jazz/.local/share/nvim/mason/packages/debugpy/venv/bin/python',
        -- command = 'path/to/virtualenvs/debugpy/bin/python',
        args = { '-m', 'debugpy.adapter' },
        options = {
          source_filetype = 'python',
        },
      })
    end
  end

  dap.configurations.python = {
    {
      -- The first three options are required by nvim-dap
      type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = 'launch';
      name = "Launch file";

      -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

      program = "${file}"; -- This configuration will launch the current file if used.
      pythonPath = function()
        -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
          return cwd .. '/venv/bin/python'
        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        else
          return '/usr/bin/python'
        end
      end;
    },
  }

  -- C language
  dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
  }

  dap.configurations.c = {
    {
      name = "Launch",
      type = "gdb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
    },
    {
      name = "Select and attach to process",
      type = "gdb",
      request = "attach",
      program = function()
         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      pid = function()
         local name = vim.fn.input('Executable name (filter): ')
         return require("dap.utils").pick_process({ filter = name })
      end,
      cwd = '${workspaceFolder}'
    },
    {
      name = 'Attach to gdbserver :1234',
      type = 'gdb',
      request = 'attach',
      target = 'localhost:1234',
      program = function()
         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}'
    },
  }

  -- Rust Language
  local mason = vim.fn.stdpath("data") .. "/mason"
  local codelldb = mason .. "/bin/codelldb"  -- Mason shim

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = codelldb,
      args = { "--port", "${port}" },
    },
  }

  -- Helper: build Cargo project and return path to produced executable
  local function cargo_build_and_get_exe()
    -- Build quietly and emit machine-readable JSON
    local cmd = { "cargo", "build", "--message-format=json", "-q" }
    local lines = vim.fn.systemlist(table.concat(cmd, " "))
    local exe
    for _, line in ipairs(lines) do
      -- Many lines aren't JSON; ignore decode errors
      local ok, j = pcall(vim.fn.json_decode, line)
      if ok and j and j.reason == "compiler-artifact" then
        -- For binaries only, j.executable is present
        if j.executable and #j.executable > 0 then
          exe = j.executable
        end
      end
    end
    return exe
  end

  -- Helper: build current single Rust file with rustc and return path
  local function rustc_build_current_file()
    local file = vim.fn.expand("%:p")                 -- /path/to/main.rs
    local out  = vim.fn.expand("%:p:r") .. ".out"     -- /path/to/main.out
    -- Debug info + no opts for clean stepping
    local result = vim.fn.system({
      "rustc", "-g", "-C", "opt-level=0", "-C", "debuginfo=2",
      "-C", "force-frame-pointers=yes",
      file, "-o", out
    })
    if vim.v.shell_error ~= 0 then
      vim.notify("rustc build failed:\n" .. result, vim.log.levels.ERROR)
      return nil
    end
    return out
  end

  dap.configurations.rust = {
    {
      name = "Rust (Cargo) – auto build & run",
      type = "codelldb",
      request = "launch",
      program = function()
        -- Build and auto-detect the binary
        local exe = cargo_build_and_get_exe()
        if not exe or exe == "" then
          -- Fallback to manual pick if detection failed
          vim.notify("Could not detect Cargo binary; pick it manually.", vim.log.levels.WARN)
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end
        return exe
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      setupCommands = {
        { text = "settings set target.x86-disassembly-flavor intel" },
      },
      -- args = { },  -- put your program args here if needed
    },
    {
      name = "Rust (single file via rustc)",
      type = "codelldb",
      request = "launch",
      program = function()
        local exe = rustc_build_current_file()
        if not exe then
          -- If rustc build failed, let user choose something manually
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end
        return exe
      end,
      cwd = function()
        return vim.fn.expand("%:p:h")
      end,
      stopOnEntry = false,
      setupCommands = {
        { text = "settings set target.x86-disassembly-flavor intel" },
      },
    },
  }
  local wk = require "which-key"
  wk.add {
    { "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run To Cursor" },
    { "<leader>dU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = "Toggle UI" },
    { "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", desc = "Step Back" },
    { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
    { "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", desc = "Disconnect" },
    { "<leader>dg", "<cmd>lua require'dap'.session()<cr>", desc = "Get Session" },
    { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
    { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
    { "<leader>dp", "<cmd>lua require'dap'.pause()<cr>", desc = "Pause" },
    { "<leader>dq", "<cmd>lua require'dap'.close()<cr>", desc = "Quit" },
    { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle Repl" },
    { "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", desc = "Start" },
    { "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
    { "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
  }
end

return M
