local M = {
  "gisketch/triforce.nvim",
  dependencies = { 'nvzone/volt' },
  opts = {},
}

function M.config()
require('triforce').setup({
  xp_rewards = {
    char = 2,  -- Less XP for characters
    line = 5,    -- More XP for new lines
    save = 25,  -- Reward file saves heavily
  },
  level_progression = {
    tier_1 = { min_level = 1, max_level = 15, xp_per_level = 200 },
    tier_2 = { min_level = 16, max_level = 30, xp_per_level = 400 },
    tier_3 = { min_level = 31, max_level = math.huge, xp_per_level = 800 },
  },
})
end

return M
