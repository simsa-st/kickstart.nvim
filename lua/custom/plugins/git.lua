return {
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  {
    'sindrets/diffview.nvim',
    -- The remaining Diffview* commands are only reachable once a view is open.
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  },
}
