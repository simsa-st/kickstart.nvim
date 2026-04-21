return {
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'npm install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
    config = function()
      require('mcphub').setup()
    end,
  },
  {
    'olimorris/codecompanion.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'ravitemer/mcphub.nvim',
      -- 'ravitemer/codecompanion-history.nvim',
    },
    config = function()
      require('codecompanion').setup {
        default_adapter = 'personal_openai_gpt5',
        adapters = {
          http = {
            personal_openai_gpt5 = function()
              return require('codecompanion.adapters').extend('openai', {
                schema = {
                  model = {
                    default = 'gpt-5-nano',
                    choices = {
                      ['gpt-5'] = { opts = { has_vision = true, can_reason = true } },
                      ['gpt-5-mini'] = { opts = { has_vision = true, can_reason = true } },
                      ['gpt-5-nano'] = { opts = { has_vision = true, can_reason = true } },
                    },
                  },
                },
                env = {
                  api_key = 'PERSONAL_OPENAI_API_KEY',
                },
              })
            end,
          },
        },
        interactions = {
          chat = { adapter = 'personal_openai_gpt5' },
          inline = { adapter = 'personal_openai_gpt5' },
          cmd = { adapter = 'personal_openai_gpt5' },
        },
        strategies = {
          chat = {
            keymaps = {
              toggle_autoscroll = {
                modes = { n = '<leader>as' },
                callback = function()
                  local config = require 'codecompanion.config'
                  config.display.chat.auto_scroll = not config.display.chat.auto_scroll
                  local status = config.display.chat.auto_scroll and 'enabled' or 'disabled'
                  vim.notify('CodeCompanion autoscroll ' .. status, vim.log.levels.INFO)
                end,
                description = 'Toggle CodeCompanion autoscroll',
              },
            },
          },
        },
        extensions = {
          mcphub = {
            callback = 'mcphub.extensions.codecompanion',
            opts = {
              show_result_in_chat = true,
              make_vars = true,
              make_slash_commands = true,
              make_tools = true,
              format_tool = function(display_name, tool)
                local info_parts = {}
                if tool and tool.args then
                  local formatted_args = {}
                  local processed_keys = {}
                  local priority_keys = { 'server_name', 'uri', 'tool_name', 'tool_input' }
                  local function format_arg(key, value)
                    if type(value) == 'string' then
                      return string.format('%s="%s"', key, value)
                    else
                      local inspected = vim.inspect(value)
                      if key == 'tool_input' then
                        -- Convert multiline output to single line for tool_input
                        inspected = inspected:gsub('\n%s*', ' '):gsub('%s+', ' ')
                      end
                      return string.format('%s=%s', key, inspected)
                    end
                  end

                  for _, key in ipairs(priority_keys) do
                    if tool.args[key] ~= nil then
                      table.insert(formatted_args, format_arg(key, tool.args[key]))
                      processed_keys[key] = true
                    end
                  end
                  -- Process remaining keys that weren't in the priority list
                  for key, value in pairs(tool.args) do
                    if not processed_keys[key] then
                      table.insert(formatted_args, format_arg(key, value))
                    end
                  end

                  if #formatted_args > 0 then
                    table.insert(info_parts, table.concat(formatted_args, ', '))
                  end
                else
                  table.insert(info_parts, 'no-args')
                end

                local suffix = #info_parts > 0 and (' [' .. table.concat(info_parts, ' | ') .. ']') or ''
                return display_name .. suffix
              end,
            },
          },
          -- history = {
          --   enabled = true,
          -- },
        },
        vim.keymap.set({ 'n', 'v' }, '<LocalLeader>aa', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true }),
        vim.keymap.set({ 'n', 'v' }, '<LocalLeader>at', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true }),
        vim.keymap.set('v', 'ga', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true }),
        -- Expand 'cc' into 'CodeCompanion' in the command line
        vim.cmd [[cab cc CodeCompanion]],
      }
    end,
  },
  -- {
  --   'ravitemer/codecompanion-history.nvim',
  --   dependencies = {
  --     'olimorris/codecompanion.nvim',
  --   },
  --   opts = {
  --     -- Keymap to open history from chat buffer (default: gh)
  --     keymap = 'gh',
  --     -- Save directory for history files
  --     save_dir = '/mnt/shared/stepan.simsa/codecompanion-history',
  --     -- Enable automatic saving of chats
  --     auto_save = true,
  --     -- Picker interface ("telescope" or "snacks" or "fzf-lua")
  --     picker = 'telescope',
  --     -- Automatically generate titles for chats
  --     auto_generate_title = true,
  --     -- On chat exited event
  --     on_chat_exited = function(chat) end,
  --   },
  -- },
}
