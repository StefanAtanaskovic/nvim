-- NOTE: must be set before plugins are loaded
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- NOTE: disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- My own settings
require("stefan.options")
require("stefan.basic_keymaps")
require("stefan.auto_commands")

-- Load lazy plugin menager
require("stefan.lazy")

-- setup harpoon
require("stefan.harpoon_setup")

-- setup nvimtree
require("stefan.nvimtree_setup")

-- color theme
vim.cmd[[colorscheme catppuccin]]
