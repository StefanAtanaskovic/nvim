return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },
  -- "gc" to comment visual regions/lines
    { "numToStr/Comment.nvim", opts = {} },
    {"tpope/vim-sleuth", config = function() require('lualine').setup() end},
}
