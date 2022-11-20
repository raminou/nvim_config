local indent = 4
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = indent -- Size of an indent
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.tabstop = indent -- Number of spaces tabs count for
-- vim.opt.mouse = "a" -- Useful when browsing
vim.opt.clipboard = "unnamedplus" -- Put those yanks in my os clipboards
vim.opt.ignorecase = true -- Ignore case
vim.opt.incsearch = true -- Make search behave like modern browsers
vim.opt.cursorline = true -- Display the current line
vim.opt.scrolloff = 10 -- Lines of context
vim.opt.shiftround = true -- Round indent
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.termguicolors = true -- True color support
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest" -- Command-line completion mode
vim.opt.list = false -- Show some invisible characters (tabs...)
vim.opt.number = true -- Print line number
vim.opt.relativenumber = false -- Relative line numbers
vim.opt.wrap = true -- Enable line wrap
vim.opt.cmdheight = 2 -- More space to display messages
vim.opt.timeoutlen = 400 -- Don't wait more that 400ms for normal mode commands
vim.opt.updatetime = 700 -- CursorHold use this value to known for how long the cursor is being held
vim.opt.completeopt={'menu','menuone','noselect'}

vim.api.nvim_set_keymap('t', '<esc>', [[<C-\><C-n>]], {noremap = true})

vim.cmd [[ command CopyBufferName let @+ = expand('%:p') ]]
vim.cmd [[ command PrintBufferName echom expand('%:p') ]]
vim.cmd [[ map q <Esc> ]]

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'folke/tokyonight.nvim'

  -- Float terminal
  use 'voldikss/vim-floaterm'

  -- For hex color
  use 'norcalli/nvim-colorizer.lua'

  -- Buffer line
  use { 'akinsho/nvim-bufferline.lua',
      requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Status line
  use 'lambdalisue/nerdfont.vim'
  use { 'glepnir/galaxyline.nvim', requires = 'kyazdani42/nvim-web-devicons' }

  -- Make finding stuff easier
  use { 'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/popup.nvim',
                  'nvim-lua/plenary.nvim',
                  'nvim-telescope/telescope-fzy-native.nvim' }
  }

  -- Provide git signs
  use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- File explorer
  -- use { 'lambdalisue/fern.vim',
  --     requires = { 'lambdalisue/fern-renderer-nerdfont.vim',
  --                 'lambdalisue/nerdfont.vim',
  --                 'lambdalisue/fern-git-status.vim' }
  -- }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }

  -- Autocompletion plugin
  use 'hrsh7th/nvim-cmp'
  -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  -- For snippets
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'
  -- For buffer completion
  use 'hrsh7th/cmp-buffer'
  -- For path completion
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'L3MON4D3/LuaSnip'

  -- GDB
  use 'sakhnik/nvim-gdb'

  use {
    "AckslD/nvim-neoclip.lua",
    requires = {
      {'kkharji/sqlite.lua', module = 'sqlite'},
      -- you'll need at least one of these
      {'nvim-telescope/telescope.nvim'},
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require('neoclip').setup()
    end,
  }

  use {
	'LukasPietzschmann/telescope-tabs',
	requires = { 'nvim-telescope/telescope.nvim' }
  }

  use {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
        },
    }})
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
end)

-- LSP CONFIG
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'clangd', 'bashls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

-- nvim-cmp setup
local cmp = require 'cmp'
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local luasnip = require "luasnip"
cmp.setup {
  completion = { completeopt = "menu,menuone,noinsert", keyword_length = 2 },
  experimental = { native_menu = false, ghost_text = false },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  formatting = {
      format = function(entry, vim_item)
        vim_item.menu = ({
          buffer = "[Buffer]",
          luasnip = "[Snip]",
          nvim_lsp = "[Lsp]",
          path = "[path]",
        })[entry.source.name]
        return vim_item
      end,
    },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {
        "i",
        "s",
        "c",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
        "c",
      }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
  {
      { name = 'buffer' },
  }
}

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

--- THEME
require("tokyonight").setup({
  style = "night",
  terminal_colors = false,
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  on_colors = function(colors)
      colors.green = "#19A319"
  end
})
vim.cmd 'colorscheme tokyonight'

-- treesitter
local ts_config = require('nvim-treesitter.configs')

ts_config.setup {
    ensure_installed = {
        'javascript',
        'html',
        'css',
        'bash',
        'lua',
        'json',
        'python',
        'cpp',
        'c',
        'java'
    },
    highlight = {
        enable = true,
        use_languagetree = true
    }
}

require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
        },
        -- Example for a specific filetype.
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        --   rust = {
        --       'impl_item',
        --   },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
}

-- FLOAT TERM
vim.g.floaterm_width = 0.5
vim.g.floaterm_height = 0.6
vim.g.floaterm_position = 'topright'
vim.g.floaterm_keymap_new    = '<F7>'
vim.g.floaterm_keymap_prev   = '<F8>'
vim.g.floaterm_keymap_next   = '<F9>'
vim.g.floaterm_keymap_toggle = '<F12>'


-- TELESCOPE
require('telescope').setup{
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
        prompt_prefix = '> ',
        selection_caret = '> ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'descending',
        layout_strategy = 'horizontal',
        layout_config = {
            horizontal = {
            mirror = false,
            },
            vertical = {
            mirror = false,
            },
        },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        path_display = { "smart" },
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },

    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}
require('telescope').load_extension('fzy_native')

local actions = require "telescope.actions"
require("telescope").setup {
  pickers = {
    buffers = {
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
        }
      }
    }
  }
}

local M = {}

function M.find_nvim()
    require('telescope.builtin').git_files({
        prompt_title = '< Neovim >',
        cwd = '~/.config/nvim',
    })
end

local opts = { silent = true }
vim.api.nvim_set_keymap('n', 'ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
vim.api.nvim_set_keymap('n', 'fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
vim.api.nvim_set_keymap('n', 'fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
vim.api.nvim_set_keymap('n', 'fe', "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)
vim.api.nvim_set_keymap('n', 'fd', "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)
vim.api.nvim_set_keymap('n', 'gs', "<cmd>lua require('telescope.builtin').git_status()<cr>", opts)
vim.api.nvim_set_keymap('n', 'gm', "<cmd>lua require('telescope.builtin').git_commits()<cr>", opts)
vim.api.nvim_set_keymap('n', 'fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)

-- FERN
-- Press ? when you're in fern to see more features
--vim.cmd [[
--let g:fern#renderer = "nerdfont"
--let g:fern_renderer_devicons_loaded = 0
--let g:fern#disable_default_mappings = 1
--noremap <silent> <F2> :Fern . -drawer -reveal=% -toggle -width=30<CR><C-w>=
--noremap <silent> <Leader>E :Fern %:h -drawer -reveal=% -toggle -width=30<CR><C-w>=
--function! FernInit() abort
--  nmap <buffer><expr>
--        \ <Plug>(fern-my-open-expand-collapse)
--        \ fern#smart#leaf(
--        \   "\<Plug>(fern-action-open:select)",
--        \   "\<Plug>(fern-action-expand)",
--        \   "\<Plug>(fern-action-collapse)",
--        \ )
--  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
--  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
--  nmap <buffer> n <Plug>(fern-action-new-path)
--  nmap <buffer> d <Plug>(fern-action-remove)
--  nmap <buffer> c <Plug>(fern-action-copy)
--  nmap <buffer> m <Plug>(fern-action-move)
--  nmap <buffer> r <Plug>(fern-action-rename)
--  nmap <buffer> H <Plug>(fern-action-hidden:toggle)
--  nmap <buffer> R <Plug>(fern-action-reload)
--  nmap <buffer> M <Plug>(fern-action-mark:toggle)
--  nmap <buffer> b <Plug>(fern-action-open:split)
--  nmap <buffer> v <Plug>(fern-action-open:vsplit)
--  nmap <buffer><nowait> h <Plug>(fern-action-leave)
--  nmap <buffer><nowait> l <Plug>(fern-action-enter)
--  nmap <buffer> t <Plug>(fern-action-open:tabedit)
--  nmap <buffer> T <Plug>(fern-action-open:tabedit)gT
--endfunction
--augroup FernGroup
--  autocmd!
--  autocmd FileType fern call FernInit()
--augroup END
--]]

-- vsnip
-- vim.g.vsnip_snippet_dir = '~/.config/nvim/snippets'
-- vim.cmd [[
-- " pmenu and vim-vsnip
-- imap <expr> <Tab>   pumvisible() ? "<C-n>" : vsnip#jumpable(1)   ? "<Plug>(vsnip-jump-next)" : "<Tab>"
-- imap <expr> <S-Tab> pumvisible() ? "<C-p>" : vsnip#jumpable(-1)  ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"
-- " vim-vsnip
-- smap <expr> <Tab>   vsnip#jumpable(1)  ? "<Plug>(vsnip-jump-next)" : "<Tab>"
-- smap <expr> <S-Tab> vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"
-- ]]

-- galaxyline
local utils = {}

function utils.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function utils.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

local gl = require('galaxyline')
local condition = require('galaxyline.condition')

local gls = gl.section
gl.short_line_list = {'LuaTree','vista','dbui'}

local colors = {
  bg = '#282c34',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#afd700',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#d16d9e',
  grey = '#c0c0c0',
  blue = '#0087d7',
  red = '#ec5f67'
}


-- Local helper functions
local mode_color = function()
  local mode_colors = {
    n = colors.cyan,
    i = colors.green,
    c = colors.orange,
    V = colors.magenta,
    [''] = colors.magenta,
    v = colors.magenta,
    R = colors.red
  }

  local color = mode_colors[vim.fn.mode()]

  if color == nil then color = colors.red end

  return color
end
local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

gls.left[1] = {
  FirstElement = {
    provider = function() return '▋' end,
    highlight = {colors.blue,colors.yellow}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      local alias = {
        n = 'NORMAL',
        i = 'INSERT',
        c = 'COMMAND',
        V = 'VISUAL',
        [''] = 'VISUAL',
        v = 'VISUAL',
        R = 'REPLACE',
        t = 'TERMINAL'
      }
      vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color())
      local alias_mode = alias[vim.fn.mode()]
      if alias_mode == nil then alias_mode = vim.fn.mode() end
      return "  " .. alias_mode .. " "
    end,
    highlight = {colors.bg, colors.bg},
    separator = " ",
    separator_highlight = {colors.section_bg, colors.section_bg}
  }
}
gls.left[3] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.darkblue},
  },
}
gls.left[4] = {
  FileName = {
    provider = {'FileName','FileSize'},
    condition = buffer_not_empty,
    separator = '',
    separator_highlight = {colors.purple,colors.darkblue},
    highlight = {colors.magenta,colors.darkblue}
  }
}

gls.left[5] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = buffer_not_empty,
    highlight = {colors.orange,colors.purple},
  }
}
gls.left[6] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = buffer_not_empty,
    highlight = {colors.grey,colors.purple},
  }
}

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left[7] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.green,colors.purple},
  }
}
gls.left[8] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.orange,colors.purple},
  }
}
gls.left[9] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.red,colors.purple},
  }
}
gls.left[10] = {
  LeftEnd = {
    provider = function() return '' end,
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.purple,colors.purple}
  }
}
gls.left[11] = {
   DiagnosticError = {
     provider = 'DiagnosticError',
     icon = '  ',
     highlight = {colors.red,colors.bg}
   }
 }
gls.left[12] = {
  Space = {
    provider = function () return ' ' end
  }
}
gls.left[13] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
}
gls.right[1] = {
  ShowLspClient = {
    provider = 'GetLspClient',
    condition = function ()
      local tbl = {['dashboard'] = true,['']=true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = ' LSP:',
    highlight = {colors.cyan,colors.bg,'bold'}
  }
}
gls.right[2]= {
  FileFormat = {
    provider = 'FileFormat',
    separator = '',
    separator_highlight = {colors.bg,colors.purple},
    highlight = {colors.grey,colors.purple},
  }
}
gls.right[3] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {colors.darkblue,colors.purple},
    highlight = {colors.grey,colors.purple},
  },
}
gls.right[4] = {
  PerCent = {
    provider = 'LinePercent',
    separator = '',
    separator_highlight = {colors.darkblue,colors.purple},
    highlight = {colors.grey,colors.darkblue},
  }
}
gls.right[5] = {
  ScrollBar = {
    provider = 'ScrollBar',
    highlight = {colors.yellow,colors.purple},
  }
}

gls.short_line_left[1] = {
  FileName = {
    provider = {'FileName','FileSize'},
    condition = buffer_not_empty,
    highlight = {colors.bg}
  }
}


gls.short_line_right[1] = {
  BufferIcon = {
    provider = 'LineColumn',
    highlight = {colors.blue, colors.bg}
  }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()

-- BUFFERLINE
require('bufferline').setup {
    options = {
        mode = "tabs"
        -- right_mouse_command = 'vert sbuffer %d',
        -- show_close_icon = false,
        -- separator_style = os.getenv 'KITTY_WINDOW_ID' and 'slant' or 'padded_slant',
        -- diagnostics = 'nvim_lsp',
        -- diagnostics_indicator = diagnostics_indicator,
        -- custom_filter = custom_filter,
        -- offsets = {
        --     {
        --         filetype = 'NvimTree',
        --         text = 'File Explorer',
        --         highlight = 'PanelHeading',
        --         padding = 1,
        --     },
        --     {
        --         filetype = 'DiffviewFiles',
        --         text = 'Diff View',
        --         highlight = 'PanelHeading',
        --         padding = 1,
        --     },
        --     {
        --         filetype = 'flutterToolsOutline'
        --     }
        -- }
    }
}

-- NVIM TREE
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  view = {
    width = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = nil,
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      git = false,
      profile = false,
    },
  },
} -- END_DEFAULT_OPTS

vim.cmd [[ nnoremap <F2> :NvimTreeToggle<CR> ]]

-- local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- vim.g.nvim_tree_bindings = {
-- -- vim.g.view.mappings.list = {
--     ["z"]          = tree_cb("tabnew")
-- }

--- git signs
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '!', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    ['n <leader>htb'] = '<cmd>lua require"gitsigns".toggle_current_line_blame()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
  },
  watch_gitdir = {
    interval = 1000
  },
  current_line_blame = false,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
}

vim.cmd 'hi DiffAdd guifg=#81A1C1 guibg = none'
vim.cmd 'hi DiffChange guifg =#3A3E44 guibg = none'
vim.cmd 'hi DiffModified guifg = #81A1C1 guibg = none'


-- GDB
-- We're going to define single-letter keymaps, so don't try to define them
-- in the terminal window.  The debugger CLI should continue accepting text commands.
vim.cmd [[
let g:nvimgdb_use_find_executables=0
let g:nvimgdb_use_cmake_to_find_executables=0

function! NvimGdbNoTKeymaps()
  tnoremap <silent> <buffer> <esc> <c-\><c-n>
endfunction

let g:nvimgdb_config_override = {
  \ 'key_next': 'n',
  \ 'key_step': 's',
  \ 'key_finish': 'f',
  \ 'key_continue': 'c',
  \ 'key_until': 'u',
  \ 'key_breakpoint': 'b',
  \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
  \ }
]]

require('neoclip').setup({
    default_register="+"
})
require('telescope').load_extension('neoclip')
vim.api.nvim_set_keymap('n', 'fc', "<cmd>Telescope neoclip plus<cr>", opts)

vim.api.nvim_set_keymap('n', 'ft', "<cmd>Telescope telescope-tabs list_tabs<cr>", opts)
