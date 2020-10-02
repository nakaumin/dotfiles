let php_sql_query = 0
let php_baselib = 1
let php_htmlInStrings = 0
let php_noShortTags = 1
let php_parent_error_close = 0
let php_parent_error_open = 0
let php_folding = 0
let php_sync_method = -1

"  let php_sql_query = 0
"  let php_baselib = 1
"  let php_htmlInStrings = 0
"  let php_oldStyle = 0
"  let php_asp_tags = 0
"  let php_parent_error_close = 1
"  let php_parent_error_open = 1
"  let php_folding = 1
"  let php_sync_method = x

set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

"nnoremap <silent> ,l :make<CR><C-w>k
nnoremap ,l :execute '!php -l %'<CR>

" PHP構文チェック1
function! PHPLint()
  let result = system( &ft . ' -l ' . bufname(""))
  echo result
endfunction

"--- php 
nnoremap <C-?>p :<C-u>Ref phpmanual <C-r><C-w><CR>

" ********************
" php settings
" ********************

"augroup php
"  au BufEnter *.php set foldmethod=syntax
"  au BufEnter *.php nnoremap <buffer> ,l :call PHPLint()<CR>
"  au BufEnter *.php nnoremap <Leader>p :<C-u>call PhpDocSingle()<CR> 
"  au BufEnter *.php vnoremap <Leader>p :call PhpDocRange()<CR> 
"  let php_folding=1
"  let php_htmlInStrings=0
"  let php_parent_error_close=1
"  let php_parent_error_open=1
"augroup END
"pdv-php-documentor
"inoremap <Leader>p <ESC>:call PhpDocSingle()<CR>i 
