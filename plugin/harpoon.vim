" ADD FILE TO LIST
nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<CR>
" SHOW MENU
nnoremap <silent><leader>s :lua require("harpoon.ui").toggle_quick_menu()<CR>

" QUICK SELECT MAPPINGS FIRST 5 FILES
nnoremap <silent><leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><leader>4 :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <silent><leader>5 :lua require("harpoon.ui").nav_file(5)<CR>
