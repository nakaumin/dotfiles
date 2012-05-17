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
NeoBundle 'othree/eregex.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'sk1418/QFGrep'
NeoBundle 'thinca/vim-qfreplace'
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
let NERDTreeIgnore=['^\.git$', '^tags$', '^sf$', '\.\(xls\|png\|jpg\|gif\|map\|pdf\|bak\)$', '\~$', '^uploads$', '^images$', '^vendor$', '^node_modules$', '^bundle$']
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
" Qfreplace
"-------------------------------
autocmd FileType qf nnoremap rr :Qfreplace<CR>

"-------------------------------
" vim-powerline
"-------------------------------

"set guifont=Inconsolata_for_Powerline:h11:cANSI
let g:Powerline_symbols='fancy'
"let g:Powerline_symbols='unicode'
"let g:Powerline_symbols='compatible'

"-------------------------------
" QFGrep
"-------------------------------
autocmd FileType qf nnoremap ss :<C-u>QFGrepPat 
autocmd FileType qf nnoremap vv :<C-u>QFGrepPatV 

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

"-------------------------------
" Vdebug
"-------------------------------
let g:vdebug_options= {
\    "port" : 9000,
\    "server" : 'localhost',
\    "timeout" : 120,
\    "on_close" : 'detach',
\    "break_on_open" : 0,
\    "ide_key" : 'XDEBUG_KEY',
\    "path_maps" : {},
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\    "watch_window_style" : 'compact',
\    "marker_default" : '-',
\    "marker_closed_tree" : '▸',
\    "marker_open_tree" : '▾'
\}

let g:vdebug_keymap = {
\    "run" : "<F5>",
\    "run_to_cursor" : "<F9>",
\    "step_over" : "<F2>",
\    "step_into" : "<F3>",
\    "step_out" : "<F4>",
\    "close" : "<F6>",
\    "detach" : "<F7>",
\    "set_breakpoint" : "<SPACE>",
\    "get_context" : "<F11>",
\    "eval_under_cursor" : "<F8>",
\    "eval_visual" : "<Leader>e",
\}


nmap vd tltktk20t+th

"-------------------------------
" Key mappings
"-------------------------------

"-------------------------------
" 今後、整理・定義していくべきグループ
" <Space>:  未定(Unite, fur系？）
" ,: コマンド実行系 / トグル系
" t: タブ、ウィンドウ系(tab)
" g: ジャンプ、移動系(go)
" s: 検索系(search)?
" I: 挿入系
"-------------------------------

"-------------------------------
" 基本操作
"-------------------------------

" エスケープの代替キー

" Helpへのアクセスを改善

" Ex-modeに入りやすく

" 直前の編集領域を選択(like gv)

" 移動のカスタマイズ

" 行連結のカスタマイズ

" 拡張検索／置換をしやすく

" 日付を挿入 2010-05-27 12:19:04+09:00

" 保存

"-------------------------------
" [g] commands  特定ファイル移動系
"-------------------------------

" .vimrcの編集を手軽に

"-------------------------------
" <t> commands ウィンドウ、タブ、バッファの分割・移動
"-------------------------------


" ウィンドウ移動

" タブ移動

" タブ操作
"nnoremap <silent> td :<C-u>bdelete<CR>

" ウィンドウ拡大縮小

" ウィンドウの分割

"-------------------------------
" 
"-------------------------------

"<C-d>とあわせて左手だけでスクロール
"nnoremap <C-e> <C-u>

" quickfixの移動


"-------------------------------
" 
"-------------------------------

" 折り畳みの開閉
"nnoremap <C-s> za

"-------------------------------
" <,>: 表示トグル系
"-------------------------------

" シンタックスハイライト

" アンダーライン

" 検索ハイライト

"行番号表示

" ペーストモード

"-------------------------------
" <,>: コマンド実行系
"-------------------------------

" 保存

" vimrcの再読み込み

"-------------------------------
" 検索
"-------------------------------
"nnoremap <silent> n n<Esc>zz
"nnoremap <silent> N N<Esc>zz
"nnoremap <silent> # #<Esc>zz
"nnoremap <silent> * *<Esc>zz


" very magic をデフォルトに
"nnoremap / :/\v
"vnoremap / :/\v
"nnoremap ,/ /\v

"-------------------------------
" インサートモード用
"-------------------------------

" ファイル保存

" カーソル移動


"タグジャンプ
"QuickFix内では通常どおり
autocmd FileType qf nnoremap <buffer> <Return> <Return>
"不快なQuickFixの挙動を抑止
autocmd FileType qf nnoremap <buffer> H :<C-u>tabprevious<CR>
autocmd FileType qf nnoremap <buffer> L :<C-u>tabnext<CR>
autocmd FileType qf nnoremap <buffer> h h
autocmd FileType qf nnoremap <buffer> l l

"-------------------------------
" 一時的なコマンド
"-------------------------------
autocmd FileType qf nnoremap <buffer> <Return> <Return>
autocmd FileType qf nnoremap <buffer> rr :Qfreplace<CR>
autocmd FileType qf nnoremap <buffer> ss :<C-u>QFGrepPat 
autocmd FileType qf nnoremap <buffer> vv :<C-u>QFGrepPatV 
cnoremap <C-l> <Esc>
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
imap <C-s> <Plug>(neosnippet_start_unite_snippet)
nnoremap <space>s :Unite snippet<CR>
nnoremap ,S :<C-u>NeoSnippetEdit<CR>
imap <buffer> <C-j> <Plug>(unite_insert_leave)j
imap <buffer> <C-l> <Plug>(unite_insert_leave)
imap <buffer> <C-o> <Plug>(unite_insert_leave):<C-u>call unite#noremappings#do_action('above')<CR>
imap <buffer> <C-q> <Plug>(unite_exit)
inoremap <C-s> <Esc>:<C-u>w<CR>
inoremap <C-w> <Esc>:<C-u>w<CR>
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
nnoremap ,<Space> :<C-u>source $MYVIMRC<CR>
nnoremap ,a :<C-u>Saction<CR>
nnoremap ,gg :<C-u>Ref webdict g<Space><C-r><C-w><CR>
nnoremap ,re :<C-u>Ref webdict ej<Space><C-r><C-w><CR>
nnoremap ,rj :<C-u>Ref webdict je<Space><C-r><C-w><CR>
nnoremap ,rw :<C-u>Ref webdict wiki<Space><C-r><C-w><CR>
nnoremap ,u :<C-u>setlocal invcursorline<CR>
nnoremap ,v :<C-u>Sview<CR>
nnoremap ,w :<C-u>ToggleAutoWrite()<CR>
nnoremap ,w :w<CR>
nnoremap / :M/
nnoremap : ;
nnoremap ; :
nnoremap <C-c> :<C-u>call ToggleCase()<CR>
nnoremap <C-e> :<C-u>VimFilerSplit<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" fugitive
nnoremap ga :Gwrite<CR>
nnoremap gB :Gblame<CR>
nnoremap gC :Gcommit -v<CR>
nnoremap gd :Gdiff<CR>
nnoremap gl :Glog\|copen<CR>
nnoremap gr :Gread<CR>
nnoremap gs :Gstatus<CR>
" gitv
nnoremap gv :Gitv<CR>
nnoremap gV :Gitv --all<CR>
nnoremap gm :Merginal<CR>

nnoremap <C-h> :<C-u>vertical help 
nnoremap <C-h><C-h> :<C-u>vertical help <C-r><C-w><CR>
nnoremap <C-l> <Esc>
nnoremap <C-s> :<C-u>w<CR>
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <Leader>ch I<!--{* <Esc>A *}--><Esc>
nnoremap <Leader>p :<C-u>call PhpDocSingle()<CR> 
nnoremap <Space>dd :<C-u>%S/^\n//g<CR>
nnoremap <Space>dh :<C-u>%S/<(\w+) [^>]+>/<\1>/g<CR>
nnoremap <Space>di :<C-u>%S/<(img [^>]+)>/[[\1]]/g<CR>
nnoremap <Space>ls :<C-u>%S/<a href="<\?php echo url_for\((.*)\) \?>">(.*)<\/a>/<?php echo link_to('\2', \1) ?>/g
nnoremap <buffer> t <nop>
nnoremap <expr> ,s (exists("syntax_on")) ? "<Esc>:syntax off<CR>" : "<Esc>:syntax on<CR>"
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
nnoremap <silent> ,h :set hlsearch!<CR>
nnoremap <silent> ,n :set number!<CR>
nnoremap <silent> ,p :set paste!<CR>
nnoremap <silent> <C-j> :<C-u>cn<CR>zz
nnoremap <silent> <C-k> :<C-u>cp<CR>zz
nnoremap <silent> <C-o> <C-o>zz 
"nnoremap <silent> <Return> <C-]>
nnoremap <Return> :execute 'tjump' expand('<cword>')<Return>zz
"nnoremap <C-Return> :vsplit<Return>:execute 'tjump' expand('<cword>')<Return>zz
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
nnoremap <silent> H :<C-u>tabprevious<CR>
nnoremap <silent> L :<C-u>tabnext<CR>
nnoremap <silent> Q q
nnoremap <silent> \y <S-v>:S/(\{\s*\|,\s*)/\r      /g<CR><S-v>:S/\s*\}//<CR>j
nnoremap <silent> co :ContinuousNumber <C-a><CR>
nnoremap <silent> g<Space> :<C-u>edit $MYVIMRC<CR>
nnoremap ,. :<C-u>edit ~/.bashrc<CR>
nnoremap <silent> gb :tabnew<CR>:<C-u>edit $HOME/.vim/bundle.vim<CR>
nnoremap <silent> gz :tabnew<CR>:<C-u>edit $HOME/.zshrc<CR>
nnoremap <silent> gj j
"nnoremap <silent> gk k
nnoremap <silent> gk :tabnew<CR>:<C-u>edit $HOME/.vim/key.vim<CR>
nnoremap <silent> j gj
nnoremap <silent> k gk
"nnoremap <silent> q :<C-u>q!<CR>
nnoremap <silent> q :<C-u>NERDTreeClose<CR>:<C-u>cclose<CR>:UniteClose<CR>:q!<CR>
nnoremap <silent> t+ <C-w>+
nnoremap <silent> t- <C-w>-
nnoremap <silent> t< <C-w><
nnoremap <silent> t> <C-w>>
nnoremap <silent> tD :<C-u>quit<CR>
nnoremap <silent> tS :<C-u>sp<CR>
nnoremap <silent> td :<C-u>tabc<CR>
nnoremap <silent> th <C-W>h
nnoremap <silent> tj <C-W>j
nnoremap <silent> tk <C-W>k
nnoremap <silent> tl <C-W>l
nnoremap <silent> ts :<C-u>vsp<CR>
nnoremap <silent> tt :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> tx <C-w>x
nnoremap C omodified at <Esc>:r! date "+\%F \%T"<CR>kJ$a. requirement_no.
nnoremap Id :<C-u>r! date --rfc-3339=seconds<CR>0kJ
nnoremap J gJ
nnoremap [[ [[<Esc>zz
nnoremap ]] ]]<Esc>zz
nnoremap b h
nnoremap gJ J
nnoremap ga :call VisualCurrentIndentBlock('a')<CR>
nnoremap gc `[v`]
nnoremap gi :call VisualCurrentIndentBlock('i')<CR>
nnoremap h b
nnoremap l w
nnoremap s/ :%S/
nnoremap w l
onoremap ga :normal ga<CR>
onoremap gc :<C-u>normal gc<CR>
onoremap gi :normal gi<CR>
vnoremap / :M/
vnoremap : ;
vnoremap ; :
vnoremap <C-l> <Esc>
vnoremap <Leader>p :call PhpDocRange()<CR> 
vnoremap <Space>dd :<C-u>%S/^\n//g<CR>
vnoremap <Space>dh :<C-u>normal dh<CR>
vnoremap <Space>di :<C-u>%S/<(img [^>]+)>/[[\1]]/g<CR>
vnoremap <Space>ls :<C-u>'<, '>S/<a href="<\?php echo url_for\((.*)\) \?>">(.*)<\/a>/<?php echo link_to('\2', \1) ?>/g
vnoremap <silent> \y :Align : <CR>gv:S/(\s+):/:\1/<CR>gv:S/\s+:/:/g<CR>gv:S/\/\s*:\s*/\/:/g<CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap J gJ
vnoremap gJ J
vnoremap gc :<C-u>normal gc<CR>
vnoremap s/ :S/
autocmd FileType unite nnoremap <buffer> th <C-W>h
autocmd FileType unite nnoremap <buffer> tj <C-W>j
autocmd FileType unite nnoremap <buffer> tk <C-W>k
autocmd FileType unite nnoremap <buffer> tl <C-W>l
autocmd FileType help nnoremap <buffer> <Return> <C-]>
nnoremap n nzz
nnoremap N Nzz
