require ("jazz.launch") -- Defines spec function used in this file for LazyVim 
require ("jazz.options") -- General, Neovim settings, such as relative line numbers, etc.
require ("jazz.keymaps") -- Basic, general, keybindings
require ("jazz.autocmds")
spec ("jazz.colorscheme") -- Where permanent ColorScheme is initalized
spec ("jazz.devicons") -- Adds many different icons used for filetypes, GitHub, etc. Referenced in many different plugins
spec ("jazz.treesitter") -- Enables better syntax highlighting using LSPs
spec ("jazz.mason") -- Easily install binaries, such as LSPs, Linters, etc.
spec ("jazz.schemastore") --Shown as wrench in autocomplete, Gives .json, .yaml schemas and provides autocompletes for those things
spec ("jazz.lspconfig") --issue with hints on part with on attach
spec ("jazz.cmp") -- adds in cool autocompletion
spec ("jazz.telescope") -- Fuzzy Finder, "_ff", Buffers, "_bb", Colorscheme, "_fc"
spec ("jazz.none-ls")
spec ("jazz.whichkey") -- Typing "_" shows most of the keybindings
spec ("jazz.nvimtree") -- "_e" opens File Tree on side to explore.
spec ("jazz.comment") -- In Visual Mode, "_/" comments out all lines"
spec ("jazz.lualine") -- Makes Line at bottom look better, uses devicons.lua
spec ("jazz.navic")
spec ("jazz.breadcrumbs")
spec ("jazz.harpoon") -- Enables harpooning, "Tab" in Normal mode, "Shift-M" to mark a file 
spec ("jazz.illuminate") -- Enables highlighting entire word on cursor hover
spec ("jazz.neotest")
spec ("jazz.gitsigns") --shows green, red, and blue lines on the left side in git files
spec ("jazz.autopairs") -- Autocomplete pairs for (),{},& [], $$ for LaTex files, < > for html, and React.js
spec ("jazz.neogit")
spec ("jazz.alpha") -- Adds in nice screen when running "nvim" in terminal
spec ("jazz.indentline") -- Adds in indent lines on the left side for functions and whatnot
spec ("jazz.toggleterm") -- Adds in terminal using "Alt-1","Alt-2","Alt-3", and "Ctrl-\"
spec ("jazz.bqf") --"Ctrl-q" while in telescope to add files to harpoon easily
spec ("jazz.dap")
--Extras--
-- spec ("jazz.extras.copilot") -- Adds Github Copilot (requires subscription)
spec ("jazz.extras.tabby") -- Creates tabs for switching between split files
spec ("jazz.extras.neoscroll") -- Scroll through files using "Ctrl-J" and "Ctrl-K"
spec ("jazz.extras.oil") --Enables mass creating files with "-" in Normal Mode
spec ("jazz.extras.ufo") --Fold "za",open all folds with "zR", close all folds "zM" 
spec ("jazz.extras.eyeliner") --Highlights ....
spec ("jazz.extras.neotab") -- ...
spec ("jazz.extras.tabnine") --AI autocompletions (shown as purple robot)
spec ("jazz.extras.dressing") --When creating files in nvim-tree, shows dialog box at the top
spec ("jazz.extras.modicator") --Bolds the line number you are currently on
spec ("jazz.extras.fidget") --shows language server loading in bottom right on file open
spec ("jazz.extras.vimtex")
-- spec ("jazz.extras.codeium")
-- spec ("jazz.project")
require ("jazz.lazy") --Adds in LazyVim Plugin manager, can set colorscheme in there

