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

  -- ActivityWatch
  {
    'lowitea/aw-watcher.nvim',
    opts = { -- required, but can be empty table: {}
      -- add any options here
      -- for example:
      aw_server = {
        host = '127.0.0.1',
        port = 5600,
      },
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
