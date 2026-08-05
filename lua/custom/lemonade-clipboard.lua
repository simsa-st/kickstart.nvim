-- Clipboard over the network via lemonade (https://github.com/lemonade-command/lemonade).
--
-- Useful when editing on a machine whose clipboard is not the one you paste into:
-- run `lemonade server` where the clipboard lives, and point Neovim at it from here.
--
-- Opt-in: without LEMONADE_HOST_IP nothing is changed and the native clipboard is
-- used, so this is inert unless something in the environment asks for it.
--
--   LEMONADE_HOST_IP  IP or hostname running `lemonade server`. Enables the provider.
--   LEMONADE_PORT     Port of that server. Defaults to lemonade's own default.
local M = {}

local DEFAULT_PORT = '2489'

--- Read an environment variable, treating an empty value as unset.
--- @param name string
--- @return string|nil
local function getenv(name)
  local value = os.getenv(name)
  if value == nil or value == '' then
    return nil
  end
  return value
end

function M.setup()
  local host = getenv 'LEMONADE_HOST_IP'
  if not host then
    return
  end

  if vim.fn.executable 'lemonade' ~= 1 then
    vim.notify('LEMONADE_HOST_IP is set but no lemonade binary was found; keeping the default clipboard', vim.log.levels.WARN)
    return
  end

  local cmd = string.format('lemonade --host=%s --port=%s', host, getenv 'LEMONADE_PORT' or DEFAULT_PORT)

  vim.g.clipboard = {
    name = 'lemonade',
    copy = {
      ['+'] = cmd .. ' copy',
      ['*'] = cmd .. ' copy',
    },
    paste = {
      ['+'] = cmd .. ' paste',
      ['*'] = cmd .. ' paste',
    },
    cache_enabled = 0,
  }
end

return M
