
autocmd FileType qf nnoremap <buffer> rr :Qfreplace<CR>
autocmd FileType qf nnoremap <buffer> ss :<C-u>QFGrepPat 
autocmd FileType qf nnoremap <buffer> vv :<C-u>QFGrepPatV 

"QuickFix内では通常どおり
autocmd FileType qf nnoremap <buffer> <Return> <Return>

"不快なQuickFixの挙動を抑止
autocmd FileType qf nnoremap <buffer> H :<C-u>tabprevious<CR>
autocmd FileType qf nnoremap <buffer> L :<C-u>tabnext<CR>
autocmd FileType qf nnoremap <buffer> h h
autocmd FileType qf nnoremap <buffer> l l

