scriptencoding utf-8

"===============================================================================
" ▶ 初期化
"===============================================================================
set nocompatible

"---------------------------------------
" NeoBundle
"---------------------------------------

if has('vim_starting')
  " 初回起動時のみruntimepathにNeoBundleのパスを指定する
  set runtimepath+=~/.vim/bundle/neobundle.vim/

  " NeoBundleが未インストールであればgit cloneする・・・・・・①
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install NeoBundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

"---------------------------------------
" Install Plugins
"---------------------------------------

" Library
NeoBundle 'Shougo/vimproc'
NeoBundle 'clones/vim-l9'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'
"NeoBundle 'Sixeight/unite-grep'
"NeoBundle 'tsukkee/unite-tag'
NeoBundle 'ujihisa/unite-colorscheme'

" Neo***
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" NERDTree
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'taiansu/nerdtree-ag'


" QuickFix
NeoBundle 'sk1418/QFGrep'
NeoBundle 'thinca/vim-qfreplace'

" Git

" コミットツリー表示
NeoBundle 'gregsexton/gitv'

" 編集・コミット作成
NeoBundle 'tpope/vim-fugitive'

" ブランチ管理
"NeoBundle 'idanarye/vim-merginal'

" Colorscheme
NeoBundle 'wombat256.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/twilight'

" Syntax
NeoBundle 'scrooloose/syntastic'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'hail2u/vim-css3-syntax'

" PHP
NeoBundle 'soh335/vim-symfony'
NeoBundle 'PDV--phpDocumentor-for-Vim'

" Help
NeoBundle 'vim-jp/vimdoc-ja'
helptags ~/.vim/bundle/vimdoc-ja/doc

" その他

" 末尾空白の可視化・一括削除
NeoBundle 'bronson/vim-trailing-whitespace'

" インデントの可視化
"NeoBundle 'Yggdroot/indentLine'

" ファイル操作
NeoBundle 'renamer.vim'

" Powerline
NeoBundle 'Lokaltog/vim-powerline', {'rev' : 'develop'}

" 正規表現
NeoBundle 'othree/eregex.vim'

" 全文検索
NeoBundle 'rking/ag.vim'

"NeoBundle 'thinca/vim-ref'
"NeoBundle 'osyo-manga/vim-over'

NeoBundle 'FuzzyFinder'
"NeoBundle 'ujihisa/repl.vim'
NeoBundle 'sudo.vim'
NeoBundle 'Align'

NeoBundle 'kana/vim-gf-user'
NeoBundle 'kana/vim-gf-diff'
"NeoBundle 'kana/vim-altr'
NeoBundle 'kana/vim-tabpagecd'

NeoBundle 'matchit.zip'
NeoBundle 'tanabe/ToggleCase-vim'
NeoBundle 'tpope/vim-surround'

"Finish install ====

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

NeoBundleCheck


"===============================================================================
" ▶ 基本設定
"===============================================================================

"---------------------------------------
" コア設定
"---------------------------------------

set noswapfile "スワップなし
set nobackup   "バックアップなし

" バッファ解放時に保存の問い合わせをしない
set hidden

" 他で編集されたら読み込み直す
set autoread


"---------------------------------------
" フォーマット・文字コード
"---------------------------------------

" 改行コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac

" Vimの内部文字コード
set encoding=utf-8

" 保存時の文字コード
set fileencoding=utf-8

" 読み込み時の文字コードの自動判別
set fileencodings=ucs-boms,utf-8,iso-2022-jp,euc-jp,cp932,latin1

" 曖昧文字幅問題: □や○文字が崩れる問題を解決
set ambiwidth=double

"---------------------------------------
" 基本キーマップ
"---------------------------------------
let mapleader = "\<Space>"

" Quick command
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" Quick escape
nnoremap <C-l> <Esc>
vnoremap <C-l> <Esc>
cnoremap <C-l> <Esc>
inoremap <C-l> <Esc>

" Quick save
nnoremap ss :w<CR>

" Quick quit
nnoremap qq :q<CR>

" Macro
nnoremap Q q<CR>

"---------------------------------------
" VIM設定の編集
"---------------------------------------

" Configure vim
nnoremap <silent> g. :<C-u>edit ~/.config/nvim/init.vim<CR>
nnoremap <silent> g, :<C-u>edit ~/.bashrc<CR>
nnoremap <silent> g<Space> :<C-u>edit $MYVIMRC<CR>

" Reload vimrc
nnoremap <Leader>, :<C-u>source $MYVIMRC<CR>

"---------------------------------------
" ヘルプ
"---------------------------------------

" 日本語ヘルプ優先
set helplang=ja,en

" <C-h> + 単語でヘルプ
" XXX: Vimscript上での末尾の空白を維持するために冗長なキーバインドにしている
nnoremap <C-h> :<C-u>vertical help  <Bs>
" <C-h>二回でカーソル下の単語のヘルプを引く
nnoremap <silent> <C-h><C-h> :<C-u>vertical help <C-r><C-w><CR>
" ヘルプでも<Return>でジャンプ
autocmd FileType help nnoremap <buffer> <Return> <C-]>

"---------------------------------------
" 表示
"---------------------------------------

" シンタックスハイライト
syntax on

" 行番号
set nonumber

" 現在行強調
set cursorline

" 現在列強調
" set cursorcolumn

" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore

" インデントはスマートインデント
set smartindent

" ビープ音を可視化
set visualbell

" 括弧入力時の対応する括弧を表示
set showmatch

" XXX: Vimの「%」を拡張する
source $VIMRUNTIME/macros/matchit.vim

" コマンドラインの補完
set wildmode=list:longest

" 現在入力中のコマンドを表示
set showcmd

" カラースキーマ
colorscheme wombat256mod
if neobundle#is_installed('molokai') " molokaiがインストールされていれば
  colorscheme molokai " カラースキームにmolokaiを設定する
endif

" iTerm2など256色環境なら無くても良い
set t_Co=256

" 暗色系背景(GUI)
set background=dark

"---------------------------------------
" 表示切り替え
"---------------------------------------
nnoremap <silent> ,h :set hlsearch!<CR>
nnoremap <silent> ,n :set number!<CR>
nnoremap <silent> ,p :set paste!<CR>
nnoremap <silent> <expr> ,s (exists("syntax_on")) ? "<Esc>:syntax off<CR>" : "<Esc>:syntax on<CR>"
nnoremap <silent> ,u :<C-u>setlocal invcursorline<CR>

"---------------------------------------
" ステータス行
"---------------------------------------

" ステータスラインを常に表示
set laststatus=2

let g:Powerline_symbols='fancy'

"---------------------------------------
" カーソル移動
"---------------------------------------

" バックスペースの挙動を便利に
set backspace=indent,eol,start

nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk
nnoremap <silent> gj j
nnoremap <silent> gk k
vnoremap <silent> gj j
vnoremap <silent> gk k

" 単語移動をデフォルトに
nnoremap w l
nnoremap b h
nnoremap l w
nnoremap h b

"---------------------------------------
" マウス対応
"---------------------------------------
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

"---------------------------------------
" タブ・インデント
"---------------------------------------

" タブ入力をスペースに置換
set expandtab

" タブの表示幅
set tabstop=2

" 連続スペースをタブとして増減させる幅
set softtabstop=2

" 改行時インデントを自動継続
set autoindent

" 文法を解析してインデント
set smartindent

" スマートインデント時のタブ幅
set shiftwidth=2

"'タブの可視化
set list listchars=tab:\▸\▸

"---------------------------------------
" ウィンドウ（タブ）移動
"---------------------------------------

"nnoremap <silent> <C-h> <C-w>h "ヘルプと干渉
"nnoremap <silent> <C-l> <C-w>l "エスケープ代替と干渉
"nnoremap <silent> <C-j> <C-w>j "QuickFix閲覧と干渉
"nnoremap <silent> <C-k> <C-w>k "QuickFix閲覧と干渉
nnoremap <silent> <C-n> :tabnew<CR>
nnoremap <silent> ts :<C-u>vsp<CR>
nnoremap <silent> tS :<C-u>sp<CR>
nnoremap <silent> tt :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> H :<C-u>tabprevious<CR>
nnoremap <silent> L :<C-u>tabnext<CR>
nnoremap <silent> t+ <C-w>+
nnoremap <silent> t- <C-w>-
nnoremap <silent> t< <C-w><
nnoremap <silent> t> <C-w>>
nnoremap <silent> td :<C-u>tabc<CR>
nnoremap <silent> tx <C-w>x
nnoremap <silent> tl <C-w>l
nnoremap <silent> th <C-w>h
nnoremap <silent> tj <C-w>j
nnoremap <silent> tk <C-w>k

"---------------------------------------
" QuickFix 
"---------------------------------------
nnoremap <silent> <C-j> :<C-u>cn<CR>zz
nnoremap <silent> <C-k> :<C-u>cp<CR>zz

"---------------------------------------
" 検索・タグジャンプ
"---------------------------------------

" 検索時の大文字小文字の違いを無視
set ignorecase
" 検索単語に大文字小文字が混じっていれば無視しない
set smartcase

" 標準の正規表現検索をeregexに置き換え
nnoremap / :<C-u>M/
vnoremap / :M/

" tagsファイルの二分探索（高速）
set tagbsearch

" エンターでカーソル下の単語のタグジャンプ
nnoremap <silent> <Return> :execute 'tjump' expand('<cword>')<Return>zz

" 移動後の表示位置を画面中央に揃える
nnoremap n nzz
nnoremap N Nzz
nnoremap [[ [[<Esc>zz
nnoremap ]] ]]<Esc>zz
nnoremap <silent> <C-o> <C-o>zz

"---------------------------------------
" 置換
"---------------------------------------

" eregexの置換コマンド割当
nnoremap s/ :<C-u>%S/
vnoremap s/ :S/

"---------------------------------------
" 行結合
"---------------------------------------
nnoremap J gJ
nnoremap gJ J
vnoremap J gJ
vnoremap gJ J

"---------------------------------------
" ビジュアルモード・選択
"---------------------------------------
nnoremap ga :call VisualCurrentIndentBlock('a')<CR>
nnoremap gc `[v`]
nnoremap gi :call VisualCurrentIndentBlock('i')<CR>

"---------------------------------------
" コピー・ペースト
"---------------------------------------

" 無名レジスタへのヤンク時に"*"レジスタへも追加
set clipboard+=unnamed

" ビジュアル選択の範囲を自動的にクリップボードへコピー
" CUI
:set clipboard+=autoselect
" GUI
:set guioptions+=a

" クリップボードからの貼り付け時自動的にペーストモードに
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function! XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"---------------------------------------
" テキスト整形
"---------------------------------------

" Align.vim
let g:Align_xstrlen = 3
call Align#AlignCtrl ('v', '^#')

"for YAML indent
call Align#AlignCtrl ('|W')

" Yaml
nnoremap <silent> \y <S-v>:S/(\{\s*\|,\s*)/\r      /g<CR><S-v>:S/\s*\}//<CR>j
vnoremap <silent> \y :Align : <CR>gv:S/(\s+):/:\1/<CR>gv:S/\s+:/:/ge<CR>gv:S@/\s*:\s*@/:@ge<CR>gv:S/\s+$//ge<CR>gv:S@(https?:)\s+//@\1//@ge<CR>

" ToogleCase キャメルキャプス・スネークケースなどを切り替え
" TODO: 形式を直接指定したい
nnoremap <C-c> :<C-u>call ToggleCase()<CR>

"---------------------------------------
" 連番入力
"---------------------------------------
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>

"===============================================================================
" ▶ プラグイン設定
"===============================================================================

"---------------------------------------
" NERDTree
"---------------------------------------

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

let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 40
let NERDTreeShowBookmarks = 1
let NERDTreeMapToggleHidden='.'
let NERDTreeCascadeSingleChildDir=0
let NERDTreeCascadeOpenSingleChildDir=0

nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-e> :NERDTreeToggle<CR>

"---------------------------------------
" Unite
"---------------------------------------

call unite#custom#profile('default', 'context', {
\  'vertical': 1,
\  'toggle': 1,
\  'winwidth': 60
\})
" no-focus
" quick-match
" auto-resize
" max-multi-lines={max-lines}
nnoremap ,m :Unite file_mru -buffer-name=files<CR>
nnoremap ,M :Unite file_mru -buffer-name=files -no-quit<CR>
nnoremap ,b :Unite buffer -buffer-name=files<CR>
nnoremap ,B :Unite buffer -buffer-name=files -no-quit<CR>
nnoremap ,f :Unite buffer file_mru -buffer-name=files<CR>
nnoremap ,F :Unite buffer file_mru -buffer-name=files -no-quit<CR>
nnoremap ,o :Unite outline -winwidth=40<CR>
nnoremap ,O :Unite outline -winwidth=40 -no-quit<CR>
nnoremap ,r :Unite register -winwidth=80 -buffer-name=register<CR>
nnoremap ,R :Unite register -winwidth=80 -buffer-name=register -no-quit<CR>

" Unite上でもウィンドウ間移動が効くように
autocmd FileType unite nnoremap <buffer> th <C-W>h
autocmd FileType unite nnoremap <buffer> tj <C-W>j
autocmd FileType unite nnoremap <buffer> tk <C-W>k
autocmd FileType unite nnoremap <buffer> tl <C-W>l

" <Esc>/<C-l>でUniteを閉じる
autocmd FileType unite nnoremap <buffer> <Esc> :UniteClose<CR>
autocmd FileType unite nnoremap <buffer> <C-l> :UniteClose<CR>

"---------------------------------------
" Unite-outline
"---------------------------------------
let g:unite_source_outline_indent_width=2

"---------------------------------------
" neomru
"---------------------------------------
let g:neomru#file_mru_limit=1000
let g:neomru#do_validate=1

"---------------------------------------
" neocomplete・neosnippet
"---------------------------------------
if neobundle#is_installed('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

"" AutoComplPop like behavior.
"" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" スニペット保存先
let g:neosnippet#snippets_directory = $HOME.'/.vim/snippets'

"---------------------------------------
" Symfony
"---------------------------------------
nnoremap ga :<C-u>Saction<CR>
nnoremap gv :<C-u>Sview<CR>
nnoremap gp :<C-u>Spartial<CR>
nnoremap gv :<C-u>Sview<CR>

"===============================================================================
" ▶ Git関連設定
"===============================================================================

"---------------------------------------
" Fugitive
"---------------------------------------
nnoremap <C-g>a :Gwrite<CR>
nnoremap <C-g>b :Gblame<CR>
nnoremap <C-g>c :Gcommit -v<CR>
nnoremap <C-g>d :Gdiff<CR>
nnoremap <C-g>l :Glog\|copen<CR>
nnoremap <C-g>r :Gread<CR>
nnoremap <C-g>s :Gstatus<CR>

"---------------------------------------
" Gitv
"---------------------------------------
nnoremap <C-g>v :Gitv<CR>
nnoremap <C-g>V :Gitv --all<CR>
nnoremap <C-g>m :Merginal<CR>

