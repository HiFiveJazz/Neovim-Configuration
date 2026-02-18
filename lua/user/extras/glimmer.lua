local M = {
  "rachartier/tiny-glimmer.nvim",
  event = "VeryLazy",
  priority = 10
  priority = 10
  priority = 10
  priority = 10
  priority = 10
}

-- local function get_cursorline_bg()
--   local hl = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
--   if hl.bg then
--     return string.format("#%06x", hl.bg)
--   end
--   return nil
-- end

function M.config()
  require("tiny-glimmer").setup({


    enabled = true, -- Enable/disable the plugin
    disable_warnings = true, -- Disable warnings for debugging highlight issues
    -- transparency_color = get_cursorline_bg(),
    transparency_color =  "#292e42", -- color of the CursorLine,  
    -- transparency_color =  bg, -- color of the CursorLine,  
    autoreload = false, -- Automatically reload highlights when colorscheme changes

    -- Animation refresh rate in milliseconds
    refresh_interval_ms = 8,

    -- Timeout in milliseconds to wait after the last edit before processing animations
    -- This uses a debouncing approach: the timer restarts on each edit, and only fires
    -- when edits stop for this duration. This properly handles multi-location atomic
    -- edits from surround plugins and similar tools (default: 50)
    text_change_batch_timeout_ms = 50,

    -- Automatic keybinding overwrites
    overwrite = {

    -- Automatic keybinding overwrites
    overwrite = {
        -- Automatically map keys to overwrite operations
        -- Set to false if you have custom mappings or prefer manual API calls
        auto_map = true,
        -- Yank operation animation
        -- Yank operation animation
yank = {
    enabled = true,
    default_animation = {
      name = "fade",
      settings = {
        from_color = "#7aa2f7", -- bright blue
        to_color = "#292e42",
        max_duration = 500,
        min_duration = 450,
        easing = "inOutQuad",

      },
    },
  },
        -- Paste operation animation
paste = {
    enabled = true,
    default_animation = {
      name = "fade",
      settings = {
        from_color = "#3b4261", -- illuminate color
        to_color = "#292e42",
        max_duration = 500,
        min_duration = 400,
        easing = "inOutQuad",
      },
    },
    paste_mapping = "p",
    Paste_mapping = "P",
  },
        -- Undo operation animation

undo = {
    enabled = true,
    default_animation = {
      name = "fade",
      settings = {
        from_color = "#f7768e", -- bright red
        to_color = "#292e42",
        max_duration = 750,
        min_duration = 550,
        easing = "inOutQuad",
      },
    },
    undo_mapping = "u",
  },

redo = {
    enabled = true,
    default_animation = {
      name = "fade",
      settings = {
        from_color = "#9ece6a", -- bright green
        to_color = "#292e42",
        max_duration = 650,
        min_duration = 450,
        easing = "inOutQuad",
      },
    },
    redo_mapping = "<c-r>",
  },
        -- Search navigation animation
        search = { enabled = false },
    },

    -- Third-party plugin integrations
    support = {
        -- Support for gbprod/substitute.nvim
        -- Usage: require("substitute").setup({
        --     on_substitute = require("tiny-glimmer.support.substitute").substitute_cb,
        --     highlight_substituted_text = { enabled = false },
        -- })
        substitute = {
            enabled = false,
            default_animation = "fade",
        },
    },

    -- Special animation presets
    presets = {
        -- Pulsar-style cursor highlighting on specific events
        pulsar = {
            enabled = false,
            on_events = { "CursorMoved", "CmdlineEnter", "WinEnter" },
            default_animation = {
                name = "fade",
                settings = {
                    max_duration = 1000,
                    min_duration = 1000,
                    from_color = "DiffDelete",
                    to_color = "Normal",
                },
            },
        },
    },

    -- Override background color for animations (for transparent backgrounds)
    -- transparency_color = "#1a1b26",

    -- Animation configurations
    animations = {
        fade = {
            from_color = "Visual",           -- Start color (highlight group or hex)
            to_color = "Normal",             -- End color (highlight group or hex)
            max_duration = 300,              -- Maximum animation duration in ms
            min_duration = 240,              -- Minimum animation duration in ms
            easing = "outQuad",              -- Easing function
            chars_for_max_duration = 12,     -- Character count for max duration
            font_style = {},                 -- Additional font styling (e.g. { bold = true }, see `:h nvim_set_hl`)
        },
        reverse_fade = {
            max_duration = 380,
            min_duration = 280,
            easing = "outBack",
            chars_for_max_duration = 10,
            from_color = "Visual",
            to_color = "Normal",
            font_style = {},
        },
        bounce = {
            max_duration = 500,
            min_duration = 400,
            chars_for_max_duration = 20,
            oscillation_count = 1,          -- Number of bounces
            from_color = "Visual",
            to_color = "Normal",
            font_style = {},
        },
        left_to_right = {
            max_duration = 350,
            min_duration = 350,
            min_progress = 0.85,
            chars_for_max_duration = 25,
            lingering_time = 50,            -- Time to linger after completion
            from_color = "Visual",
            to_color = "Normal",
            font_style = {},
        },
        pulse = {
            max_duration = 600,
            min_duration = 400,
            chars_for_max_duration = 15,
            pulse_count = 2,                -- Number of pulses
            intensity = 1.2,                -- Pulse intensity
            from_color = "Visual",
            to_color = "Normal",
            font_style = {},
        },
        rainbow = {
            max_duration = 600,
            min_duration = 350,
            chars_for_max_duration = 20,
            -- Note: Rainbow animation does not use from_color/to_color
            font_style = {},
        },

        -- Custom animation example
        custom = {
            max_duration = 350,
            chars_for_max_duration = 40,
            color = "#ff0000",  -- Custom property

            -- Custom effect function
            -- @param self table - The effect object with settings
            -- @param progress number - Animation progress [0, 1]
            -- @return string color - Hex color or highlight group
            -- @return number progress - How much of the animation to draw
            effect = function(self, progress)
                return self.settings.color, progress
            end,
        },
    },

    -- Filetypes to disable hijacking/overwrites
    hijack_ft_disabled = {
        "alpha",
    },

    -- Virtual text display priority
    virt_text = {
        priority = 50000,  -- Higher values appear above other plugins
    },

  })
end

return M
