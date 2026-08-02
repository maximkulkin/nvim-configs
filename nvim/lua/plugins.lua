return {
  { "catppuccin/nvim", as = "catppuccin" },

  { 'alexghergh/nvim-tmux-navigation',
    config = function()
      require('config.tmux-navigation')
    end,
  },

  { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('config.indent-blankline')
    end,
  },

  'tpope/vim-sleuth',  -- auto detect tabsize and shiftwidth

  'nvim-lua/plenary.nvim',

  { 'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      require('config.telescope')
    end,
  },

  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' },
  { 'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },
  'nvim-telescope/telescope-symbols.nvim',

  'kevinhwang91/nvim-bqf',  -- better quick fix window

  {'s1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
      require('window-picker').setup()
    end,
  },

  {'ibhagwan/fzf-lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },

  'nvim-tree/nvim-web-devicons',
  {'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      'TimCreasman/neo-tree-tests-source.nvim',
    },
    config = function()
      require('config.neotree')
    end,
  },

  { 'linrongbin16/lsp-progress.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
  },

  { 'hedyhli/outline.nvim',
    config = function()
      require('config.outline')
    end,
  },

  { 'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'linrongbin16/lsp-progress.nvim',
    },
    config = function()
      require('config.statusline')
    end,
  },

  { 'simeji/winresizer',
    config = function()
      require('config.winresizer')
    end,
  },

  { 'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'famiu/bufdelete.nvim',
    },
    config = 'require("config.bufferline")',
  },

  { 'j-hui/fidget.nvim',
    config = function()
      require('config.fidget')
    end,
  },

  { 'nvim-treesitter/nvim-treesitter',
    dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('config.treesitter')
    end,
  },
  -- Show current function context
  { 'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('config.treesitter-context')
    end,
  },

  { 'williamboman/mason.nvim',
    config = function()
      require('config.mason')
    end,
  },

  'milisims/nvim-luaref',  -- Lua reference
  -- Lua LSP support
  { 'folke/neodev.nvim', opts = {} },

  { 'neovim/nvim-lspconfig',
    config = function()
      require('config.lsp')
    end,
  },

  { 'stevanmilic/nvim-lspimport',
    config = function()
      require('config.lspimport')
    end,
  },

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  { 'hrsh7th/nvim-cmp',
    config = function()
      require('config.cmp')
    end,
  },

  { 'AckslD/nvim-neoclip.lua',
    config = function()
      require('config.neoclip')
    end,
  },
  { "folke/trouble.nvim",
    config = function()
      require('config.trouble')
    end,
  },
  { "folke/which-key.nvim",
    config = function()
      require('config.which-key')
    end,
  },
  { "folke/persistence.nvim",
    config = function()
      require('config.persistence')
    end,
  },
  { "klen/nvim-config-local",
    config = function()
      require('config-local').setup({
        config_files = { '.nvim.lua' },
        hashfile = vim.fn.stdpath("data") .. "/config-local",

        autocommands_create = true,
        commands_create = true,
        silent = true,
        lookup_parents = true,
      })
    end,
  },

  { 'lewis6991/gitsigns.nvim',
    config = function()
      require('config.gitsigns')
    end,
  },
  { 'tpope/vim-fugitive' },

  { "mfussenegger/nvim-dap",
    opt = true,
    event = "BufReadPre",
    module = { "dap" },
    wants = {
      "nvim-dap-virtual-text",
      "DAPInstall.nvim",
      "nvim-dap-ui",
      "nvim-dap-python",
      "which-key.nvim",
    },
    dependencies = {
      "Pocco81/DAPInstall.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      require("config.dap")
    end,
  },

  -- 'bfredl/nvim-luadev',
  'ii14/neorepl.nvim',

  { "ariel-frischer/bmessages.nvim", event = 'CmdlineEnter', opts = {} },

  { 'stevearc/overseer.nvim',
    config = function()
      require('config.overseer')
    end,
  },

  {"nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require('config.neotest')
    end,
  },
  {"akinsho/toggleterm.nvim",
    version = '*',
    config = function()
      require("config.toggleterm")
    end,
  },

  {"ellisonleao/carbon-now.nvim", opts = { open_cmd = 'open', titlebar = '' } },

  {"salkin-mada/openscad.nvim",
    dependencies = "L3MON4D3/LuaSnip",
    config = function()
      require("config.openscad")
    end,
  },

  {"kawre/leetcode.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("config.leetcode")
    end,
  },

  {"Civitasv/cmake-tools.nvim",
    config = function()
      require("config.cmake_tools")
    end,
  },
}
