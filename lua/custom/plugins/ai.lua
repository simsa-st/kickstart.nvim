return {
  {
    'carderne/pi-nvim',
    opts = {
      -- Only use the <leader>ap* mappings below.
      set_default_keymaps = false,
    },
    cmd = { 'Pi', 'PiSend', 'PiSendFile', 'PiSendSelection', 'PiSendBuffer', 'PiPing', 'PiSessions' },
    keys = {
      { '<leader>apd', ':Pi<CR>', mode = { 'n', 'v' }, desc = 'Pi Dialog' },
      { '<leader>app', ':PiSend<CR>', desc = 'Pi Send' },
      { '<leader>apf', ':PiSendFile<CR>', desc = 'Pi Send File' },
      { '<leader>aps', ':PiSendSelection<CR>', mode = 'v', desc = 'Pi Send Selection' },
      { '<leader>apb', ':PiSendBuffer<CR>', desc = 'Pi Send Buffer' },
      { '<leader>api', ':PiPing<CR>', desc = 'Pi Ping' },
    },
  },
}
