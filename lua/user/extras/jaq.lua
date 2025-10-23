local M = {
  "is0n/jaq-nvim",
  event = "VeryLazy",
}

function M.config()
  require("jaq-nvim").setup {
    cmds = {
      default = "term",

      external = {
        typescript = "bun %",
        javascript = "node %",
        python = "python3 %",
        -- rust = "rustc % && ./$fileBase && rm $fileBase",
        -- rust = 'OUT="$(mktemp -t rustbin.XXXXXX)"; rustc "%" -O -o "$OUT" && "$OUT"; code=$?; rm -f "$OUT"; exit $code',
        rust = 'OUT="$(mktemp -t rustbin.XXXXXX)"; rustc "%" -O -o "$OUT" && "$OUT"; ' ..
       'hyperfine -N --warmup 5000 --min-runs 10000 "$OUT"; ' ..
       'code=$?; rm -f "$OUT"; exit $code',

        -- rust = "cargo run -q",
        cpp = "g++ % -o $fileBase && ./$fileBase",
        go = "go run %",
        sh = "sh %",
      },

      internal = {},
    },

    behavior = {
      -- Default display type (choose: "terminal" | "float" | "quickfix")
      default = "float",

      startinsert = false,
      wincmd = false,
      autosave = false,
    },

    ui = {
      float = {
        border = "rounded",
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,
        border_hl = "FloatBorder",
        float_hl = "Normal",
        blend = 0,
      },

      terminal = {
        position = "bot", -- valid: "bot", "top", "left", "right"
        line_no = false,
        size = 15,
      },
    },
  }

  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_set_keymap

  -- <M-r> to run current file in floating window
  keymap("n", "<M-r>", ":silent write | silent only | Jaq<CR>", opts)

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "Jaq" },
    callback = function()
      vim.cmd [[
        nnoremap <silent> <buffer> <M-r> :close<CR>
        set nobuflisted
      ]]
    end,
  })
end

return M
