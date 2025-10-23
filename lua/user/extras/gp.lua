return {
  "robitx/gp.nvim",
  lazy = false,  -- ensure our setup runs before gp.nvim creates its defaults
  config = function()
    require("gp").setup({
      providers = {
        openai  = { disable = true },
        copilot = { disable = true },
        ollama  = {
          endpoint = "http://127.0.0.1:11434/api/chat", -- native Ollama chat API
        },
      },

      agents = {
        {
          name = "Ollama-QwenCoder",
          provider = "ollama",
          chat = true,
          command = true,
          -- IMPORTANT: pass model as a table for Ollama
          model = { model = "qwen3-coder:30b" },
          -- gp.nvim expects a system_prompt on chat agents; keep it simple
          system_prompt = "You are a helpful local coding assistant running via Ollama.",
          -- optional per-agent params:
          -- temperature = 0.2,
          -- top_p = 0.9,
        },
      },

      default_chat_agent = "Ollama-QwenCoder",
      default_command_agent = "Ollama-QwenCoder",
    })

    -- your keymaps
    local wk = require "which-key"
    wk.add({
      { "<leader>aa", "<cmd>GpChatToggle vsplit<cr>", desc = "Toggle Chat" },
      { "<leader>an", "<cmd>GpChatNew vsplit<cr>",    desc = "New Chat" },
      { "<leader>af", "<cmd>GpChatFinder<cr>",        desc = "Find Chat" },
      { "<leader>ar", "<cmd>GpChatRespond<cr>",       desc = "Respond" },
      { "<leader>aw", "<cmd>GpRewrite<cr>",           desc = "Rewrite", mode = { "n", "v" } },
      { "<leader>ap", "<cmd>GpAppend<cr>",            desc = "Append",  mode = { "n", "v" } },
    })
  end,
}

