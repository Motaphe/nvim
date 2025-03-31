-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Discord Presence
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
}
