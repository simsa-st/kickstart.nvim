-- Highlight, edit, and navigate code
return {
  {
    -- Old configuration - no updates but stable for now
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'git_rebase',
        'gitcommit',
        'html',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'vim',
        'vimdoc',
        'yaml',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- Currently maintained version, did not work out of the box for me
    -- 'nvim-treesitter/nvim-treesitter',
    -- branch = 'main',
    -- lazy = false,
    -- build = ':TSUpdate',
    -- config = function()
    --   local languages = {
    --     'bash',
    --     'c',
    --     'diff',
    --     'git_rebase',
    --     'gitcommit',
    --     'html',
    --     'json',
    --     'lua',
    --     'luadoc',
    --     'markdown',
    --     'markdown_inline',
    --     'python',
    --     'query',
    --     'vim',
    --     'vimdoc',
    --     'yaml',
    --   }
    --   require('nvim-treesitter').install(languages)
    --   vim.api.nvim_create_autocmd('FileType', {
    --     pattern = languages,
    --     callback = function()
    --       vim.treesitter.start()
    --       vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    --       vim.wo.foldmethod = 'expr'
    --       vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    --     end,
    --   })
    -- end,
    --
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
