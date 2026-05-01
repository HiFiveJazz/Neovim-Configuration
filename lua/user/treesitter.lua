local M = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
}

local ensure_installed = {
  -- Web Dev
  "typescript",
  "html",
  "css",
  "markdown",
  "markdown_inline",
  -- High Level
  "go",
  "lua",
  "python",
  -- Low Level
  "rust",
  "c",
  --Other
  "json",
  "bash",
  "vim",
  "dockerfile",
  "gitignore",
}

function M.init()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("JazzTreesitterStart", { clear = true }),
    callback = function(args)
      local file = vim.api.nvim_buf_get_name(args.buf)

      if file ~= "" then
        local ok, stats = pcall(vim.uv.fs_stat, file)
        if ok and stats and stats.size > 100 * 1024 then
          return
        end
      end

      pcall(vim.treesitter.start, args.buf)

      local ft = vim.bo[args.buf].filetype
      if ft ~= "yaml" then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })
end

function M.config()
  local ok, treesitter = pcall(require, "nvim-treesitter")

  if not ok then
    vim.notify(
      "Failed to load nvim-treesitter:\n" .. tostring(treesitter),
      vim.log.levels.ERROR,
      { title = "nvim-treesitter" }
    )
    return
  end

  local config_ok, ts_config = pcall(require, "nvim-treesitter.config")
  if config_ok then
    local installed = ts_config.get_installed()
    local missing = vim
      .iter(ensure_installed)
      :filter(function(parser)
        return not vim.tbl_contains(installed, parser)
      end)
      :totable()

    if #missing > 0 then
      treesitter.install(missing)
    end
  else
    vim.notify(
      "Failed to load nvim-treesitter.config:\n" .. tostring(ts_config),
      vim.log.levels.WARN,
      { title = "nvim-treesitter" }
    )
  end
end

return M
