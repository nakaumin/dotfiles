scriptencoding utf-8
"-------------------------------
" コア設定
"-------------------------------

" Vimモード
set nocompatible

syntax on

if $SHELL =~ '/fish$'
  set shell=bash
endif

" 端末エミュレータの設定
set ttyfast
set ttybuiltin

set encoding=utf-8
set fileencodings=utf-8,ucs-bom,default,iso-2022-jp,euc-jp,cp932,latin1
set fileformats=unix,mac,dos

set noswapfile
set nobackup
set directory-=.
"set autochdir

" 日本語ヘルプ優先
set helplang=ja,en
set notagbsearch

" ファイラーの設定 netrw: Explore
let g:netrw_list_hide='^\..*,*.swp'

set printoptions=number:y " 印刷設定
set printfont=osaka_unicode\ 12
"set printmbfont=osaka_unicode:h12:cUTF8

" 高速化設定
if has('unix')
  set nofsync
  set swapsync=
endif

set autoread                   " 他で編集されたら読み込み直す
set backspace=indent,eol,start " バックスペースの挙動

"-------------------------------
" OSタイプ判定
"-------------------------------

let OSTYPE = system('uname')
if OSTYPE == "Darwin\n"
  " Mac
elseif OSTYPE == "Linux\n"
  " Linux
endif

"-------------------------------
"タブ・インデントの設定
"-------------------------------

set expandtab
set tabstop=2
set shiftwidth=2
set shiftround
set softtabstop=2
"set indentkeys=!^F,o,O
set smarttab

" TABとSPACEの扱い
set copyindent
set preserveindent

set autoindent
"set smartindent
set cindent

"-------------------------------
" 検索
"-------------------------------

set ignorecase
set smartcase
set noincsearch
" set nowrapscan

set grepprg=ag

"make
set makeprg=cat\ temp.diff

"quickfix open
au QuickfixCmdPost make,grep,grepadd,vimgrep copen

" tags
set tags&
set tags+=plugins/tags,lib/vendor/tags,tags;

" auto-complete
set wildmenu
set complete=sl

"コピー＆ペースト
"set clipboard&
"set clipboard+=unnamed     "YankRing.vimと干渉する

autocmd TabLeave * NERDTreeClose

"-------------------------------
" 表示設定
"-------------------------------

" 補完メニューのハイライト
highlight Pmenu ctermbg=242 guibg=red
highlight PmenuSel ctermbg=13 guibg=DarkGrey

let loaded_matchparen=1
set shortmess+=I
set foldcolumn=0
hi clear FoldColumn 

" gvim設定
if has('gui_running')
  set guioptions&
  set guioptions+=b
endif

" シンタックスハイライト
syntax enable
"set synmaxcol=160

" 全角空白の表示
highlight ZenkakuSpace cterm=underline ctermfg=blue guibg=white
match ZenkakuSpace /　/

" 曖昧文字幅問題
set ambiwidth=double

" 行番号
set nonumber

" カーソルライン
set cursorline 
autocmd WinEnter,BufRead * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" ステータスライン
set laststatus=2
set statusline=%3.5n:\ %f%m%r%h%w\%=[%c,%l/%L]\ type:%y\ %{&enc}/%{&ff}\ 
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\  [POS=%04l,%04v][%p%%]\ [LEN=%L]

"-------------------------------
" タブライン設定
"-------------------------------
function! MyTabLabel(n)
  " tabline にカレントウィンドウのバッファ名表示させたい
  let buflist = tabpagebuflist(a:n)
  " のでタブのなかのカレントウィンドの番号を使う
  let winnr = tabpagewinnr(a:n)
  " あとタブのなかにあるウィンドウ数表示させたい
  "let buflen = tabpagewinnr(a:n, '$')
  " ファイル名を表示させたい(ながいのは困るのでファイル名のぶんだけ)
  let bufname = fnamemodify(bufname(buflist[winnr - 1]), ':t')
  " タブの番号表示させたい(これが一番の目的)
  let label = a:n . " "
  "let label = ''
  " バッファ名、なければ No name に
  let label .= bufname == '' ? 'No name' : bufname
  " うえでとったウィンドの数をもってくる
  "let label .= '[' . buflen . ']'
  " tabline に表示させる文字列返す
  return label
endfunction

" あとはヘルプにあるのそのまま
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    let s .= '%' . (i + 1) . 'T'
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor
  let s .= '%#TabLineFill#%T'
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xx'
  endif
  return s
endfunction

set tabline=%!MyTabLine()
set showtabline=2

" 補完メニューのハイライト
highlight Pmenu ctermbg=242 guibg=red
highlight PmenuSel ctermbg=13 guibg=DarkGrey

" ローカルの設定ファイル .vimrc.localを読み込む
" Load settings for each location.
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

"-------------------------------
" 便利コマンド定義
"-------------------------------


" ブラウザをリロードできるコマンドを定義
" Google-Chromeも同時にリロード
" command! BrowserReload :call system('firefox_reload;chrome_reload')
" noremap <F5> <Esc>:BrowserReload<CR>

" HTMLのタグ内のアトリビュート削除

" 文字コード指定で開き直す
command! Utf8 edit ++enc=utf-8
command! Cp932 edit ++enc=cp932
command! Iso2022jp edit ++enc=iso-2022-jp
command! EucJp edit ++enc=euc-jp
command! Sjis Cp932
command! Jis Iso2022jp

"-------------------------------
" 連番入力
"-------------------------------
command! -count -nargs=1 ContinuousNumber let c = col('.')|for n in range(1, <count>?<count>-line('.'):1)|exec 'normal! j' . n . <q-args>|call cursor('.', c)|endfor


"nnoremap <C-k> :<C-u>call ToggleCase()<CR>

"-------------------------------
" 同じインデントレベルの行を選択
"-------------------------------
function! VisualCurrentIndentBlock(type)
  let current_indent = indent('.')
  let current_line   = line('.')
  let current_col    = col('.')
  let last_line      = line('$')

  let start_line = current_line
  while start_line != 1 && current_indent <= indent(start_line) || getline(start_line) == ''
      let start_line -= 1
  endwhile
  if a:type ==# 'i'
      let start_line += 1
  endif

  let end_line = current_line
  while end_line != last_line && current_indent <= indent(end_line) || getline(end_line) == ''
      let end_line += 1
  endwhile
  if a:type ==# 'i'
      let end_line -= 1
  endif

  call cursor(start_line, current_col)
  normal! v
  call cursor(end_line, current_col)
endfunction


"-------------------------------
"  日本語入力を自動的にOFFにする
"-------------------------------
if has('unix')
  "HankakuキーにIME側でIME-OFFの挙動が定義されているという前提
  "なぜか、スリープを入れないと動作しない場合がある。
  command! ImeOff call system('sleep 0.2 && xvkbd -text "\[Hankaku]" >/dev/null 2>&1') "Vi協調モードがあるならば[ESC]でもよい
  "Vi協調モード前提。したがって、CTRL-LのみにIme-Offを割り当てればよい。
"  nnoremap <silent> <C-l> <Esc>:<C-u>ImeOff<CR><Esc>
"  inoremap <silent> <C-l> <Esc>:<C-u>ImeOff<CR>
"  cnoremap <silent> <C-l> <C-e><C-u><Esc>:ImeOff<CR>
  "エンターでCommandモードを抜けたときもIME-Off（検索時etcに便利）
  "cnoremap <silent> <CR> <CR>:<C-u>ImeOff<CR>
endif

"-------------------------------
" Autocmd
"-------------------------------
"
autocmd BufReadPost * setlocal foldlevel=2

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
  autocmd InsertEnter * highlight StatusLine ctermfg=Red ctermbg=Black
  autocmd InsertLeave * highlight StatusLine ctermfg=Grey ctermbg=Black
"  autocmd InsertEnter * ImeOff
"  autocmd InsertLeave * ImeOff
augroup END

source $HOME/.vim/bundle.vim

"-------------------------------
" カラー設定
"-------------------------------
"
if &term =~ ".*256color" || &term =~ 'linux'
  set t_Co=256
  colorscheme hybrid
  set background=dark
else
  colorscheme desert
endif

