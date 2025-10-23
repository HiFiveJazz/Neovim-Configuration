-- hover your cursor over a file name in quotations and press "gd" to teleport to the config file
require "user.launch"-- Defines spec function used in this file for LazyVim 
require "user.options"-- General, Neovim settings, such as relative line numbers, etc.
require "user.keymaps"-- Basic, general, keybindings
require "user.autocmds"
spec "user.colorscheme"-- Where permanent ColorScheme is initalized
-- spec "user.devicons"-- Adds many different icons used for filetypes, GitHub, etc. Referenced in many different plugins
spec "user.miniicons"-- Adds many different icons used for filetypes, GitHub, etc. Referenced in many different plugins
spec "user.treesitter"-- Enables better syntax highlighting using LSPs
spec "user.mason"-- Easily install binaries, such as LSPs, Linters, etc.
spec "user.schemastore"--Shown as wrench in autocomplete, Gives .json, .yaml schemas and provides autocompletes for those things
-- spec "user.lspconfig"--issue with hints on part with on attach
spec "user.navic" -- Navigation Icons
spec "user.breadcrumbs" -- Works with NavIc to provide context of code
spec "user.null-ls" -- Use for injecting LSPs into Neovim
spec "user.illuminate" -- Enables highlighting entire word on cursor hover
spec "user.telescope" -- Fuzzy Finder, "_ff", Buffers, "_bb", Colorscheme, "_fc"
spec "user.telescope-tabs" -- use "_aa for opening telescope in a tab format"
spec "user.neotree" -- use "_e to open up file explorer on the side"
spec "user.lualine" -- Makes Line at bottom look better, uses devicons.lua
spec "user.whichkey" --Typing "_" shows most of the keybindings
spec "user.dap" --Debug Adapter Protocol, used for python3
spec "user.autotag" -- Automatically update both HTML tags when editing one of them
spec "user.cmp" --adds in cool autocompletion
spec "user.autopairs" --Autocomplete pairs for (),{},& [], $$ for LaTex files, < > for html, and React.js
spec "user.comment" --In Visual Mode, "_/" comments out all lines"
spec "user.gitsigns" --shows green, red, and blue lines on the left side in git files
spec "user.indentline" --Adds in indent lines on the left side for functions and whatnot
spec "user.alpha" --Adds in nice screen when running "nvim" in terminal
spec "user.netrw" -- Dependency for other packages, specifically for file managing
spec "user.project" -- Open up recent projects via telescope using "Ctrl-p", moving up and down with "Ctrl-j" and "Ctrl-k"
spec "user.toggleterm" -- Adds in terminal using "Alt-1","Alt-2","Alt-3", and "Ctrl-\"
spec "user.bufdelete" -- Delete current buffer by pressing "Q"
spec "user.luarocks"
spec "user.image"
spec "user.peek" -- When in a Markdown File, use "_m" to open a live preview of the markdown file you are editing 
-- spec "user.markdown" -- When in a Markdown File, use "_m" to open a live preview of the markdown file you are editing 
spec "user.neocomposer" -- Used for macros, press "mr" toggle recording and finishing a macro, "mm" to open the macro menu  
-- Extras
spec "user.extras.colorizer" --Colors hex color codes
spec "user.extras.neoscroll" -- Scroll through files using "Ctrl-J" and "Ctrl-K"
spec "user.extras.modicator" --Bolds the line number you are currently on
-- spec "user.extras.rainbow"
spec "user.extras.bqf" --"Ctrl-q" while in telescope to add files to harpoon easily
spec "user.extras.nui" -- UI components library used in many other plugins
spec "user.extras.ufo" --Toggle fold with "za",open all folds with "zR", close all folds "zM" 
spec "user.extras.dressing" --When creating files in nvim-tree, shows dialog box at the top
spec "user.extras.surround" -- Helps with HTML tags!
-- ssi for custom tags!
-- sst for HTML tags!
-- ssb for ()
-- SS for an entire line
-- ds to delete the surrounding tags
-- cs to change the tags to something different
-- spec "user.extras.notify"
spec "user.extras.eyeliner" --Highlights characters when using "f" and "F" commands in Neovim for faster jumping
spec "user.extras.numb" -- Linepeeker that doesn't force you to move all the way down to the line, if you want to peek line 356, type ":356" for example
spec "user.extras.jaq" -- Use "Alt-r" to run code quickly! Opens up output on the side!
spec "user.extras.navbuddy" -- Opens yazi file explorer, using "Space-o". Use "Alt-s" or "Alt-o" for code exploration!
spec "user.extras.oil" --Enables mass creating files with "-" in Normal Mode
spec "user.extras.noice" --Experimental plugin that replaces the command line of neovim, making it look very clean
spec "user.extras.fidget" --shows language server loading in bottom right on file open
spec "user.extras.neotab"
-- spec "user.extras.cmp-tabnine"--AI autocompletions (shown as purple robot)
spec "user.extras.tabby"-- Creates tabs for switching between split files, open using "_;"
spec "user.extras.various-textobjs"
-- spec "user.extras.spider"
spec "user.extras.harpoon" -- Enables harpooning, "Tab" in Normal mode, "Shift-M" to mark a file 
spec "user.extras.package-info"
spec "user.extras.todo-comments" -- Adds in various comments, such as the following below 
-- TODO:
-- HACK:
-- WARN: 
-- WARNING:
-- XXX:
-- PERF:
-- PERFORMANCE:
-- OPTIMIZE:
-- INFO:
-- NOTE:
-- TEST:
-- PASSED:
-- FAILED:
-- TESTING:
spec "user.extras.trouble"
spec "user.extras.rustacean"
spec "user.extras.crates"
-- AI Components
-- spec "user.extras.gp"
-- spec "user.extras.chatgpt"
--Latex Documents
spec "user.extras.vimtex" -- Allows continous compilation of latex document and neovim editing
-- spec "user.extras.ultisnips" -- Adds in many different latex shorrcuts
spec "user.extras.tex-conceal" -- Conceals latex text in neovim, making it appear like it would in a latex document
require "user.lazy"--Adds in LazyVim Plugin manager, can set colorscheme in there

