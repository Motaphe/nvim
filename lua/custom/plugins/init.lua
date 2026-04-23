-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Discord Presence
---@module 'lazy'
---@type LazySpec
return {
  {
    'andweeb/presence.nvim',
    config = function()
      require('presence').setup {}
    end,
  },

  -- Highlight TODO/FIXME/NOTE/HACK comments and search them via Telescope
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  -- ActivityWatch time tracker
  {
    'lowitea/aw-watcher.nvim',
    opts = {},
  },

  -- AI assistant (Claude via subscription, local qwen3.6-35b via llama-swap)
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false,
    build = 'make',
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'claude',
      providers = {
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-20250514',
          auth_type = 'max', -- uses Claude Pro/Max subscription, no API key needed
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 20480,
          },
        },
        -- Local model via llama-swap (OpenAI-compatible, port 11434)
        -- Switch to it with :AvanteSwitchProvider local_llm
        local_llm = {
          __inherited_from = 'openai',
          endpoint = 'http://127.0.0.1:11434/v1',
          model = 'qwen3.6-35b',
          api_key = 'sk-dummy-key',
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },

  -- Catppuccin Theme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        mini = {
          enabled = true,
        },
        telescope = {
          enabled = true,
        },
      },
    },
    -- Activate catppuccin as the colorscheme
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
