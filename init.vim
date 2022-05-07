syntax on
set relativenumber
set ignorecase      " ignore case
set smartcase     " but don't ignore it, when search string contains uppercase letters
set incsearch        " do incremental searching
set noerrorbells
set nohlsearch
set noswapfile
set nobackup
set scrolloff=10
set signcolumn=yes
set expandtab
set tabstop=4
set ruler
set colorcolumn=80
highlight ColorColumn ctermbg=9
set smartindent
set shiftwidth=4
set nohlsearch
set virtualedit=onemore
set autoindent
set guicursor=


call plug#begin('~/.config/nvim/pluged')
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'lspcontainers/lspcontainers.nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

colorscheme gruvbox

lua <<EOF
require("nvim-lsp-installer").setup {}
EOF
lua require("stefan.lsp")
"Telescope keybinds
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
