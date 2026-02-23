-- hover your cursor over a file name in quotations and press "gd" to teleport to the config file
require "user.launch"         -- Defines spec function used in this file for LazyVim 
require "user.options"        -- Neovim settings, such as relative line numbers, etc.
require "user.keymaps"        -- Basic, general, keybindings
require "user.autocmds"       -- General functions
spec "user.colorscheme"       -- Where permanent ColorScheme is initalized
spec "user.miniicons"         -- Adds many different icons used for filetypes, GitHub, etc. Referenced in many different plugins
spec "user.treesitter"        -- Enables better syntax highlighting using LSPs
spec "user.mason"             -- Easily install binaries, such as LSPs, Linters, etc.
spec "user.schemastore"       -- Shown as wrench in autocomplete, Gives .json, .yaml schemas and provides autocompletes for those things
spec "user.lspconfig"         -- LSP configurations
-- spec "user.navic"          -- Navigation Icons
-- spec "user.breadcrumbs"    -- Works with NavIc to provide context of code
spec "user.null-ls"           -- Use for injecting LSPs into Neovim
spec "user.illuminate"        -- Enables highlighting entire word on cursor hover
spec "user.telescope"         -- Fuzzy Finder, "_ff", Buffers, "_bb", Colorscheme, "_fc"
-- spec "user.telescope-tabs" -- use "_aa for opening telescope in a tab format"
-- spec "user.neotree"        -- use "_e to open up file explorer on the side"
spec "user.yazi"              -- use "_e to open up file explorer on the side" requires yazi package to be installed
spec "user.flash"             -- enhanced f, F, t, and T keybindings! use zf or ; for super 
spec "user.lualine"           -- Makes Line at bottom look better, uses devicons.lua
spec "user.whichkey"          -- Typing "_" shows most of the keybindings
spec "user.dap"               -- Debug Adapter Protocol, used for python3
spec "user.autotag"           -- Automatically update both HTML tags when editing one of them
spec "user.cmp"               -- Adds in cool autocompletion
spec "user.autopairs"         -- Autocomplete pairs for (),{},& [], $$ for LaTex files, < > for html, and React.js
spec "user.comment"           --In Visual Mode, "_/" comments out all lines"
spec "user.gitsigns"          -- Shows green, red, and blue lines on the left side in git files
spec "user.indentline"        -- Adds in indent lines on the left side for functions and whatnot
spec "user.alpha"             -- Adds in nice screen when running "nvim" in terminal
spec "user.project"           -- Open up recent projects via telescope using "Ctrl-p", moving up and down with "Ctrl-j" and "Ctrl-k"
spec "user.toggleterm"        -- Adds in terminal using "Alt-1","Alt-2","Alt-3", and "Ctrl-\"
spec "user.bufdelete"         -- Delete current buffer by pressing "Q"
-- spec "user.luarocks"
-- spec "user.neodev" -- Haven't used this plugin, remove?
spec "user.image"             -- allows using neovim to glance at images
spec "user.csv"               -- allows using neovim to edit csv files
spec "user.peek"              -- When in a Markdown File, use "_m" to open a live preview of the markdown file you are editing 
spec "user.markdown-render"   -- Renders Markdown files inside of Neovim in normal mode, only doesn't when in insert mode
spec "user.neocomposer"       -- Used for macros, press  
                              -- "mr" toggle recording and finishing a macro, 
                              -- "mm" to open the macro menu,
                              -- "mp" to play macro, "ms" to stop a macro!  
-- Extras
spec "user.extras.smear"      -- Animation for cursor, good for lectures! 
spec "user.extras.glimmer"    -- Animation for yanking, pasting, undo, redo; good for lectures/screensharing code!
spec "user.extras.screenkey"  -- Screenkey for neovim, good for lectures/screensharing code!
spec "user.extras.urlview"    -- Allows for opening urls in the browser quickly
spec "user.extras.colorizer"  -- Colors hex color codes
spec "user.extras.neoscroll"  -- Scroll through files using "Ctrl-J" and "Ctrl-K"
spec "user.extras.modicator"  -- Bolds the line number you are currently on
spec "user.extras.bqf"        --"Ctrl-q" while in telescope to add files to harpoon easily
spec "user.extras.nui"        -- UI components library used in many other plugins
spec "user.extras.ufo"        -- Toggle fold with "za",open all folds with "zR", close all folds "zM" 
-- spec "user.extras.linux-style"-- Toggle fold with "za",open all folds with "zR", close all folds "zM" 
-- spec "user.extras.dressing"   -- When creating files in nvim-tree, shows dialog box at the top
spec "user.extras.surround"   -- Helps with HTML tags!
                              -- ssi for custom tags!
                              -- sst for HTML tags!
                              -- ssb for ()
                              -- SS for an entire line
                              -- ds to delete the surrounding tags
                              -- cs to change the tags to something different

                              -- spec "user.extras.notify"
spec "user.extras.eyeliner"   -- Highlights characters when using "f" and "F" commands in Neovim for faster jumping
spec "user.extras.numb"       -- Linepeeker that doesn't force you to move all the way down to the line, if you want to peek line 356, type ":356" for example
spec "user.extras.jaq"        -- Use "Alt-r" to run code quickly! Opens up output on the side!
spec "user.extras.noice"      -- Visually enchances the Neovim commandline bar! 
spec "user.extras.fidget"     -- Shows language server loading in top right on file open!
spec "user.extras.neotab"     -- Always creation of other tabs!
spec "user.extras.tabby"      -- Creates tabs for switching between split files, open using "_;"
spec "user.extras.various-textobjs" -- replaces ciw, works on text object rather than whole line! 
spec "user.extras.harpoon"    -- Enables harpooning, "Tab" in Normal mode, "Shift-M" to mark a file 
spec "user.extras.harpoon-lualine"    -- Enables harpoon visually showing the lualine!
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
-- spec "user.extras.trouble" -- Jump through errors with keybindings!
spec "user.extras.rustacean"  -- Lots of Rust Language integration
spec "user.extras.crates"     -- Shows updates for Rust Crates
-- spec "user.extras.wrapped"    -- Spotify wrapped, but for Nvim, run :NvimWrapped  
-- AI Components
-- spec "user.extras.gp"
-- spec "user.extras.chatgpt"
--Latex Documents
-- spec "user.extras.vimtex"      -- Allows continous compilation of latex document and neovim editing
-- spec "user.extras.ultisnips"   -- Adds in many different latex shortcuts
-- spec "user.extras.tex-conceal" -- Conceals latex text in Neovim, making it appear like it would in a latex document
require "user.lazy"           -- Adds in LazyVim Plugin manager, can set colorscheme in there
