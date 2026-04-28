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
    event = 'VeryLazy',
    config = function()
      require('presence').setup {}
    end,
  },

  -- ActivityWatch time tracker
  {
    'lowitea/aw-watcher.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- AI assistant (local qwen by default, plus Claude and OpenAI)
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false,
    build = 'make',
    config = function(_, opts)
      require('avante').setup(opts)

      -- Avante merges our custom providers with its built-in defaults. Prune the
      -- merged list so the switcher/model picker only shows the providers we use.
      local Config = require 'avante.config'
      Config._options.providers = {
        claude = Config.providers.claude,
        openai = Config.providers.openai,
        local_llm = Config.providers.local_llm,
      }

      if not Config._options.providers[Config._options.provider] then Config._options.provider = 'local_llm' end
    end,
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      input = {
        -- Work around avante.nvim issue #2994: the built-in native provider
        -- incorrectly calls vim.ui.select during Claude subscription auth.
        provider = function(input)
          vim.ui.input({
            prompt = input.title,
            default = input.default,
            completion = input.completion,
          }, input.on_submit)
        end,
      },
      provider = 'local_llm',
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
        openai = {
          endpoint = 'https://api.openai.com/v1',
          model = 'gpt-4o',
          -- Reuse OpenCode's cached OpenAI OAuth access token.
          api_key_name = "cmd:jq -er '.openai.access' \"$HOME/.local/share/opencode/auth.json\"",
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 8192,
          },
        },
        -- Local model via llama-swap (OpenAI-compatible, port 11434)
        -- Switch to it with :AvanteSwitchProvider local_llm
        local_llm = {
          __inherited_from = 'openai',
          endpoint = 'http://127.0.0.1:11434/v1',
          model = 'qwen3.6-35b',
          api_key_name = '',
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
