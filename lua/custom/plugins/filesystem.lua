return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    -- dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
      require('oil').setup {
        keymaps = {
          ['gS'] = {
            callback = function()
              local oil = require 'oil'
              local config = require 'oil.config'
              local has_size = false

              -- Check if size is already in columns
              for _, col in ipairs(config.columns) do
                if type(col) == 'string' and col == 'size' then
                  has_size = true
                  break
                end
              end

              -- Toggle the size column
              if has_size then
                oil.set_columns { 'icon' } -- Minimal view
              else
                oil.set_columns { 'icon', 'permissions', 'size', 'mtime' } -- Detailed view
              end
            end,
            desc = 'Toggle file detail view',
          },
        },
      }
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
}
