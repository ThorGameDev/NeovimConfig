-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	{'sainnhe/gruvbox-material', lazy=false},

	{'romgrk/barbar.nvim', lazy=false},
	{'nvim-tree/nvim-web-devicons', lazy=true},

	{'habamax/vim-godot', lazy=true, ft="gdscript"},

	{"nvim-treesitter/nvim-treesitter", lazy=false},
	{"williamboman/mason.nvim", lazy=false},
	{"williamboman/mason-lspconfig.nvim", lazy=false},
	{"neovim/nvim-lspconfig", lazy = false},
	{"ms-jpq/coq_nvim", branch = "coq", lazy=false},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
