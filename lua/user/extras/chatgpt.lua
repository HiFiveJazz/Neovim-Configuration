local M = {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
}

function M.config()

  require("chatgpt").setup({
    api_key_cmd= "pass show open_ai_api_key",
    openai_params = {
      model = "gpt-4o",
      frequency_penalty = 0,
      presence_penalty = 0,
      max_tokens = 4095,
      temperature = 0.2,
      top_p = 0.1,
      n = 1,
    }
  })


end

return M
