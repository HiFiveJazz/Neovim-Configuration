local M = {
      "HiFiveJazz/linux-style.nvim",
      lazy = false,
      --event = "VeryLazy",
}

function M.config() require("linux-style").setup({
      --format_on_save = true,
      --prefer_kernel_script = false,
      -- --If you want extra args when using system clang -
          -- format : -- --clang_format_args = {"--style=file"},
      --checkpatch = true,
      --textwidth = 80,
      --colorcolumn = "81",
      --
}) end

return M
