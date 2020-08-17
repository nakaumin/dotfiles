"-------------------------------
" NeoBundle
" :NeoBundleClean   remove obsolated plugins
" :NeoBundleInatall  install new plugins
" :NeoBundleInatall  install and update all plugins
"-------------------------------

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc'
NeoBundle 'clones/vim-l9'   
NeoBundle 'FuzzyFinder'
" NeoComplete/NeoComplcache
function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

"-------------------------------
" Unite系
"-------------------------------
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Sixeight/unite-grep'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'ujihisa/unite-colorscheme'

"-------------------------------
" ファイル操作
"-------------------------------
NeoBundle 'renamer.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tyok/nerdtree-ack'

"-------------------------------
" その他
"-------------------------------
NeoBundle 'ujihisa/repl.vim'
NeoBundle 'sudo.vim'
NeoBundle 'Align'
NeoBundle 'kana/vim-gf-user'
NeoBundle 'kana/vim-gf-diff'
NeoBundle 'kana/vim-altr'
NeoBundle 'kana/vim-tabpagecd'
"NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'matchit.zip'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tanabe/ToggleCase-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-surround'
NeoBundle 'syui/wauto.vim'

"-------------------------------
" 検索・置換系
"-------------------------------
"NeoBundle 'othree/eregex.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'sk1418/QFGrep'
"NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'osyo-manga/vim-over'

"-------------------------------
" Git
"-------------------------------
" コミットツリー表示
NeoBundle 'gregsexton/gitv'
" 編集・コミット作成
NeoBundle 'tpope/vim-fugitive'
" ブランチ管理
NeoBundle 'idanarye/vim-merginal'

"-------------------------------
" 特定言語向
"-------------------------------
NeoBundle 'soh335/vim-symfony'
NeoBundle 'PDV--phpDocumentor-for-Vim'
NeoBundle 'joonty/vdebug'

"-------------------------------
" Syntax & View
"-------------------------------
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Lokaltog/vim-powerline', {'rev' : 'develop'}
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'hail2u/vim-css3-syntax'

"-------------------------------
" Colorscheme
"-------------------------------
NeoBundle 'wombat256.vim'

" カラースキーム
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'croaker/mustang-vim'
"NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/twilight'
"NeoBundle 'vim-scripts/Lucius'
"NeoBundle 'vim-scripts/Zenburn'
"NeoBundle 'mrkn/mrkn256.vim'
"NeoBundle 'jpo/vim-railscasts-theme'
"NeoBundle 'therubymug/vim-pyte'
"NeoBundle 'tomasr/molokai'

"順番によっては日本語ヘルプがひけなくなるので注意
"NeoBundle 'vim-jp/vimdoc-ja'
"helptags ~/.vim/bundle/vimdoc-ja/doc

NeoBundleCheck

filetype plugin on
filetype indent on

"-------------------------------
" 各プラグイン設定 
"-------------------------------

"-------------------------------
" unite.vim
"-------------------------------
let g:unite_enable_start_insert=0
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1
let g:unite_update_time = 100
let g:unite_enable_split_vertically=0
let g:unite_winwidth = 80
let g:unite_split_rule = 'rightbelow'

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
endfunction

" Grep設定
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

" バッファ一覧

" ファイル一覧
"call unite#custom#source('file_rec/async', 'ignore_pattern',  '\(\(png\|gif\|jpeg\|jpg\)$\|/bundle/\|.sass-cache\|/uploads/\|/cache/\)')
call unite#custom#source('file_rec/async', 'ignore_pattern',  '\(png\|gif\|jpeg\|jpg\)$')
let g:unite_source_rec_max_cache_files = 2000

" カラースキーマ

" タグ
"nnoremap <silent> <Space>t :Unite tag<CR>

" neomru
let g:neomru#file_mru_limit=1000
let g:neomru#do_validate=0

" レジスタ一覧

" アウトライン

" ファイル検索統合: タグ/MRU/buffers

"-------------------------------
" FuzzyFinder
"-------------------------------

"-------------------------------
" neocomplete/neocomplcache
"-------------------------------

  " 新しく追加した neocomplete の設定
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#enable_camel_case_completion = 1
"let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction


" <TAB>: completion.
" <C-h>, <BS>: close popup and delete backword char.

" AutoComplPop like behavior.
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


"-------------------------------
" neosnippet.vim
"-------------------------------

" スニペット設定
let g:neosnippet#snippets_directory = $HOME.'/.vim/snippets'

imap <C-s> <Plug>(neosnippet_start_unite_snippet)
" Unite連携
"let g:neocomplcache_enable_auto_select = 1

"-------------------------------
" eregex.vim
"-------------------------------
let g:eregex_default_enable=0

"-------------------------------
" Ag as Ack
"-------------------------------
" let g:ackprg = "ag -S --nogroup --nocolor --column"
let g:ackprg = "ag --nogroup --nocolor --column"
let g:ack_apply_qmappings = 0
let g:ack_apply_lmappings = 0

"-------------------------------
" Align.vim
"-------------------------------
call Align#AlignCtrl ('v', '^#')

"for YAML indent
call Align#AlignCtrl ('|W') 
let g:Align_xstrlen = 3

"-------------------------------
" vim-ref
"-------------------------------
let g:ref_phpmanual_path=$HOME.'/.vim/php-chunked-xhtml'
let g:ref_open='vsplit'

"webdictサイトの設定
let g:ref_source_webdict_sites = {
\   'je': {
\     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
\   },
\   'ej': {
\     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
\   },
\   'wiki': {
\     'url': 'http://ja.wikipedia.org/wiki/%s',
\   },
\   'g': {
\     'url': 'http://www.google.co.jp/?q=%s',
\   },
\ }

"デフォルトサイト
let g:ref_source_webdict_sites.default = 'ej'

"出力に対するフィルタ。最初の数行を削除
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction


"-------------------------------
" symfony.vim
"-------------------------------
"nnoremap ,, :<C-u>Symfony 

"pdv-php-documentor
source ~/.vim/bundle/PDV--phpDocumentor-for-Vim/plugin/php-doc.vim
"inoremap <Leader>p <ESC>:call PhpDocSingle()<CR>i 

let g:pdv_cfg_Type = "string"
let g:pdv_cfg_Package = ""
let g:pdv_cfg_Version = "$id$"
let g:pdv_cfg_Author = "topenpe <topenpe@gmail.com>"
let g:pdv_cfg_Copyright = "Copyright (C) 2007 Hoge Corporation. All Rights Reserved."
let g:pdv_cfg_License = "PHP Version 5.0 {@link http://www.php.net/license/5_0.txt}"

"-------------------------------
" NERDTree
"-------------------------------
"let NERDTreeIgnore=['^\.git$', '^tags$', '^sf$', '^base$', '^map$', '^om$', '\.\(xls\|png\|jpg\|gif\|map\|pdf\|bak\)$', '^cache$', '\~$', '^uploads$', '^images$', '^vendor$']
let NERDTreeIgnore=['^\.git$',
\ '^tags$',
\ '^sf$',
\ '\.\(xls\|png\|jpg\|gif\|map\|pdf\|bak\)$',
\ '\~$',
\ '^base$',
\ '^om$',
\ '^map$',
\ '^dist$',
\ '^uploads$',
\ '^images$',
\ '^vendor$',
\ '^node_modules$',
\ '^bundle$']
"let NERDTreeIgnore=['^\.git$', '^tags$', '\.\(xls\|png\|jpg\|gif\|map\|pdf\|bak\)$', '^cache$', '\~$', '^images$', '^lib/vendor$']
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 40
let NERDTreeShowBookmarks = 1
let NERDTreeMapToggleHidden='.'
let NERDTreeCascadeSingleChildDir=0
let NERDTreeCascadeOpenSingleChildDir=0

"-------------------------------
" fugitive
"-------------------------------

"-------------------------------
" gitv
"-------------------------------
" log --graph

"-------------------------------
" git-merginal
"-------------------------------

"-------------------------------
" vimproc
"-------------------------------

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

"-------------------------------
" surround.vim
"-------------------------------

" inspect charcode -> :echo char2nr("X")<CR>
let g:surround_40 = "(\r)"

"-------------------------------
" VimFiler
"-------------------------------
function! s:my_vimfiler_settings()
endfunction
autocmd! FileType vimfiler call s:my_vimfiler_settings()

"-------------------------------
" vim-powerline
"-------------------------------

"set guifont=Inconsolata_for_Powerline:h11:cANSI
let g:Powerline_symbols='fancy'
"let g:Powerline_symbols='unicode'
"let g:Powerline_symbols='compatible'

"-------------------------------
" wauto.vim
"-------------------------------
let g:auto_write = 1

function! ToggleAutoWrite()
  if g:auto_write == 1
    let g:auto_write = 0
  else
    let g:auto_write = 1
  endif
endfunction


imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
imap <C-s> <Plug>(neosnippet_start_unite_snippet)
nnoremap <space>s :Unite snippet<CR>
nnoremap ,S :<C-u>NeoSnippetEdit<CR>
imap <buffer> <C-j> <Plug>(unite_insert_leave)j
imap <buffer> <C-l> <Plug>(unite_insert_leave)
imap <buffer> <C-o> <Plug>(unite_insert_leave):<C-u>call unite#noremappings#do_action('above')<CR>
imap <buffer> <C-q> <Plug>(unite_exit)

inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><Down>  pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><Up>  pumvisible() ? "\<C-p>" : "\<Up>"

nmap <Leader>ci C<Esc>\ch
nmap <buffer> <C-j> j
nmap <buffer> <C-l> <Plug>(unite_exit)
nmap <buffer> t <nop>

nnoremap ,/ /
nnoremap ,<BS> :<C-u>BufExplorer<Cr>

"nnoremap ,gg :<C-u>Ref webdict g<Space><C-r><C-w><CR>
"nnoremap ,re :<C-u>Ref webdict ej<Space><C-r><C-w><CR>
"nnoremap ,rj :<C-u>Ref webdict je<Space><C-r><C-w><CR>
"nnoremap ,rw :<C-u>Ref webdict wiki<Space><C-r><C-w><CR>
"
nnoremap <C-c> :<C-u>call ToggleCase()<CR>

nnoremap <Leader>ch I<!--{* <Esc>A *}--><Esc>
nnoremap <Leader>p :<C-u>call PhpDocSingle()<CR> 

nnoremap <buffer> t <nop>
"nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
"nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>


nnoremap <silent> <Space><Return> :<C-u>FufTagWithCursorWord<CR>

nnoremap <silent> <Space>C :<C-u>Unite colorscheme -auto-preview<CR>
nnoremap <silent> <Space>b :<C-u>Unite buffer<CR>
nnoremap <silent> <Space>f :<C-u>Unite -no-quit -start-insert -vertical file_rec/async:!<CR>
nnoremap <silent> <Space>m :Unite neomru/file -buffer-name=files -start-insert  -vertical -winwidth=100<CR>
nnoremap <silent> <Space>o :Unite outline -start-insert -vertical -no-immediately -quit<CR>
nnoremap <silent> <Space>O :Unite outline -vertical -direction=aboveleft -no-quit -winwidth=60<CR>
nnoremap <silent> <Space>r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <Space>t :<C-u>FufTag<CR>
nnoremap <silent> <Space>u :Unite tag buffer file_mru -buffer-name=files -start-insert  -vertical -winwidth=100<CR>

nnoremap C omodified at <Esc>:r! date "+\%F \%T"<CR>kJ$a. requirement_no.
nnoremap Id :<C-u>r! date --rfc-3339=seconds<CR>0kJ

onoremap ga :normal ga<CR>
onoremap gc :<C-u>normal gc<CR>
onoremap gi :normal gi<CR>

vnoremap <Leader>p :call PhpDocRange()<CR> 

"vnoremap <Space>dd :<C-u>%S/^\n//g<CR>
"vnoremap <Space>dh :<C-u>normal dh<CR>
"vnoremap <Space>di :<C-u>%S/<(img [^>]+)>/[[\1]]/g<CR>

vnoremap gc :<C-u>normal gc<CR>
autocmd FileType unite nnoremap <buffer> th <C-W>h
autocmd FileType unite nnoremap <buffer> tj <C-W>j
autocmd FileType unite nnoremap <buffer> tk <C-W>k
autocmd FileType unite nnoremap <buffer> tl <C-W>l
autocmd FileType help nnoremap <buffer> <Return> <C-]>

