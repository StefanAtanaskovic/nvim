call plug#begin('~/.config/nvim/pluged')
Plug 'preservim/nerdtree'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-commentary'
Plug 'ThePrimeagen/harpoon'
call plug#end()

colorscheme gruvbox

let mapleader = " "

lua require("stefan")
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
lua require('nvim-autopairs').setup{}
autocmd VimEnter * :COQnow
