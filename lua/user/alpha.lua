local M = {
  "goolord/alpha-nvim",
  -- event = "VimEnter",
}

function M.config()
  local dashboard = require "alpha.themes.dashboard"
  local icons = require "user.icons"

  local function button(sc, txt, keybind, keybind_opts)
    local b = dashboard.button(sc, txt, keybind, keybind_opts)
    b.opts.hl_shortcut = "Function"
    return b
  end

  dashboard.section.header.val = {
    [[       .;:;:;;::....:::;::;;:;;;;:;:::;;;;++xXxXXxxx+x;      ]], 
    [[      .:;;:;;;:........::.:;;;;;;:::::;:;;;+;xxxXXxxxx;      ]], 
    [[      .:;:;;;...:x:;;;;;+;;.;;;;::;;++xx+x++;+xxXxXXXx+:     ]], 
    [[      .:+;x:.;X$XXXxxXX$Xxx;x++;:+xXX$XXxXxXX$$xxXXXXxx;     ]], 
    [[      .;++;;$X$$XXXXxXXXXx;;+:;;XX$$$$$$XXXXXxx+;xXXXx+;     ]], 
    [[      :;;+.+XX$XXXXxX$X$$x;;.::+Xx$X$$$$$Xxx+;;;;;XxXxx:     ]], 
    [[      .;;;.;xXXxxxx+xx$$$;+:;.:;xXX$$$$$$xx;;;;;:;XxXx+      ]], 
    [[       ;+:..xXXXxxx++xX;;;.:.XXx$XXX$X$$Xx+;;;+..+Xxxx;      ]], 
    [[       :;.:..+XX$$$xxxx...:.XxXXXXXxx;;xxx+XXx::;xXX+x       ]], 
    [[       ::..:.....:.;....::.$X$$$x$;x++;;;;;+::;+xXXXxx+      ]], 
    [[       .;....;;;;;+x;;;;:.xx$$X$$+;Xx+;xX;x++xx;xxXXxx       ]], 
    [[         ;:.::;;;;;;;;;;:;$x$$+$$+Xx+xxxx;+;;;;;xxXx:        ]], 
    [[         .:x+xxxx;::;;;::;+$$$+x&&;xxx+x++xxXxxxXXx;         ]], 
    [[           ;+;;xxxx::;.;:.:::.:+;;;;xxxxxXXxxXX$Xx;          ]], 
    [[            +;;x;  ;::.;.....::::+;;+xxXxX   X$xx;           ]], 
  }

  dashboard.section.buttons.val = {
    button("f", icons.ui.Files .. "  Find file", ":Telescope find_files <CR>"),
    button("n", icons.ui.NewFile .. "  New file", ":ene <BAR> startinsert <CR>"),
    -- button("s", icons.ui.SignIn .. " Load session", ":lua require('persistence').load()<CR>"),
    button("p", icons.git.Repo .. "  Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
    button("r", icons.ui.History .. "  Recent files", ":Telescope oldfiles <CR>"),
    button("t", icons.ui.Text .. "  Find text", ":Telescope live_grep <CR>"),
    button("c", icons.ui.Gear .. "  Config", ":e ~/.config/nvim/init.lua <CR>"),
    button("q", icons.ui.SignOut .. "  Quit", ":qa<CR>"),
  }
  local function footer()
    return "HiFiveJazz"
  end

  dashboard.section.footer.val = footer()

  dashboard.section.header.opts.hl = "Function"
  dashboard.section.buttons.opts.hl = "Type"
  dashboard.section.footer.opts.hl = "@keyword.return"

  dashboard.opts.opts.noautocmd = true
  require("alpha").setup(dashboard.opts)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = "Loaded " .. stats.count .. " plugins in " .. ms .. "ms"
      pcall(vim.cmd.AlphaRedraw)
    end,
  })

  vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
      vim.cmd [[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
    end,
  })
end

return M
