" ********************
" for scss (sass)
" ********************
function! Sass_convert()
    let scss = expand('%:p')
    let css  = substitute(scss, 'scss$', 'css', '')
    "let cmd  = printf('scss %s %s', scss, css)
    let cmd  = printf('sass %s %s', scss, css)
    let res  = system(cmd)
    if res != ''
        echo res
    endif
endfunction

set tabstop=2
set shiftwidth=2
set softtabstop=2

"au! BufWritePost *.scss call Sass_convert()
au! BufRead *.scss set filetype=scss



