local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use { "catppuccin/nvim", as = "catppuccin" }

  use { 'alexghergh/nvim-tmux-navigation',
    config = function()
      require('config.tmux-navigation')
    end,
  }

  use { 'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('config.indent-blankline')
    end,
  }

  use 'tpope/vim-sleuth'  -- auto detect tabsize and shiftwidth

  use 'nvim-lua/plenary.nvim'
  use { 'nvim-telescope/telescope.nvim',
    config = function()
      require('config.telescope')
    end,
  }

  use 'kevinhwang91/nvim-bqf'  -- better quick fix window

  use 'nvim-tree/nvim-web-devicons'
  use {'nvim-tree/nvim-tree.lua',
    config = function()
      require('config.tree')
    end,
  }

  use { 'linrongbin16/lsp-progress.nvim',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lsp-progress').setup {}
    end,
  }

  use { 'nvim-lualine/lualine.nvim',
    requires = {
      'nvim-tree/nvim-web-devicons',
      'linrongbin16/lsp-progress.nvim',
    },
    config = function()
      require('config.statusline')
    end,
  }

  use { 'simeji/winresizer',
    config = function()
      require('config.winresizer')
    end,
  }

  use { 'akinsho/bufferline.nvim',
    requires = {
      'nvim-tree/nvim-web-devicons',
      'famiu/bufdelete.nvim',
    },
    config = 'require("config.bufferline")',
  }

  use 'rcarriga/nvim-notify'

  use { 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('config.treesitter')
    end,
  }
  use { 'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('config.treesitter-context')
    end,
  }

  use { 'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
    config = function()
      require('config.mason')
    end,
  }

  use 'milisims/nvim-luaref'  -- Lua reference
  -- Lua LSP support
  use { 'folke/neodev.nvim',
    config = function()
      require('neodev').setup({})
    end,
  }

  use { 'neovim/nvim-lspconfig',
    config = function()
      require('config.lsp')
    end,
  }

  use { 'AckslD/nvim-neoclip.lua',
    config = function()
      require('config.neoclip')
    end,
  }
  use { "folke/trouble.nvim",
    config = function()
      require('config.trouble')
    end,
  }
  use { "folke/which-key.nvim",
    config = function()
      require('config.which-key')
    end,
  }
  use { "folke/persistence.nvim",
    config = function()
      require('config.persistence')
    end,
  }

  use { 'lewis6991/gitsigns.nvim',
    config = function()
      require('config.gitsigns')
    end,
  }
  use { 'tpope/vim-fugitive' }

  use { "mfussenegger/nvim-dap",
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
    requires = {
      "Pocco81/DAPInstall.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope-dap.nvim",
    },
    config = function()
      require("config.dap")
    end,
  }

  use { 'stevearc/overseer.nvim',
    config = function()
      require('config.overseer')
    end,
  }

  use {"nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    config = function()
      require('config.neotest')
    end,
  }
  use {"akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("config.toggleterm")
    end,
  }

  use {"salkin-mada/openscad.nvim",
    requires = "L3MON4D3/LuaSnip",
    config = function()
      require("config.openscad")
    end,
  }

  use {"kawre/leetcode.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("config.leetcode")
    end,
  }

end)

if packer_bootstrap then
  require('packer').sync()
end

vim.api.nvim_create_augroup('packer_user_config', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'packer_user_config',
  pattern = 'plugins.lua',
  callback = function()
    vim.cmd([[source <afile> | PackerCompile]])
  end,
})
