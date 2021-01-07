scriptencoding utf-8

"===============================================================================
" ▶ 初期化
"===============================================================================
set nocompatible

" 自動コマンドの初期化
autocmd!

filetype plugin indent on

"---------------------------------------
" VIM-Plug
"---------------------------------------

if has('vim_starting')
  if !filereadable(expand('~/.vim/autoload/plug.vim'))
    echo "install vim-plug..."
    :call system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
  endif
endif

" Required:
call plug#begin('~/.vim/plugged')

"---------------------------------------
" Install Plugins
"---------------------------------------

" Library
Plug 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
Plug 'clones/vim-l9'

" Unite
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite-outline'
Plug 'Sixeight/unite-grep'

" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'taiansu/nerdtree-ag'

" キーリピートをプラグインにも対応させる
"Plug 'tpope/vim-repeat'
"silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" QuickFix
Plug 'sk1418/QFGrep'
Plug 'thinca/vim-qfreplace'

" スニペット
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"-------
" Git 
"-------

" コミットツリー表示
Plug 'gregsexton/gitv'
Plug 'cohama/agit.vim'

" 差分の自動表示
Plug 'airblade/vim-gitgutter'

" 編集・コミット作成
Plug 'tpope/vim-fugitive'

" ブランチ管理
Plug 'idanarye/vim-merginal'

" Colorscheme
Plug 'vim-scripts/wombat256.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'
Plug 'vim-scripts/twilight'

" Syntax
Plug 'scrooloose/syntastic'
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'posva/vim-vue'
Plug 'tomlion/vim-solidity'
Plug 'sheerun/vim-polyglot'

" PHP
Plug 'alvan/vim-php-manual', { 'for' : 'php' }
Plug 'soh335/vim-symfony', { 'for' : 'php' }
Plug 'vim-scripts/PDV--phpDocumentor-for-Vim', { 'for' : 'php' }
Plug 'docteurklein/php-getter-setter.vim'

" Help
Plug 'vim-jp/vimdoc-ja'
helptags ~/.vim/plugged/vimdoc-ja/doc

" その他

" 末尾空白の可視化・一括削除
Plug 'bronson/vim-trailing-whitespace'

" インデントの可視化
Plug 'Yggdroot/indentLine'

" ファイル操作
Plug 'vim-scripts/renamer.vim'

" Powerline
Plug 'Lokaltog/vim-powerline', {'rev' : 'develop'}

" 正規表現
Plug 'othree/eregex.vim'

" 全文検索
Plug 'rking/ag.vim'

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/FuzzyFinder'

" Other
Plug 'thinca/vim-ref'
Plug 'osyo-manga/vim-over'
Plug 'ujihisa/repl.vim'
Plug 'vim-scripts/sudo.vim'
Plug 'vim-scripts/Align'

Plug 'kana/vim-gf-user'
Plug 'kana/vim-gf-diff'
Plug 'kana/vim-altr'
Plug 'kana/vim-tabpagecd'

Plug 'vim-scripts/matchit.zip'
Plug 'tanabe/ToggleCase-vim'
Plug 'tpope/vim-surround'

" Language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'


" Required
call plug#end()

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

set rtp+=/usr/local/opt/fzf

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

" ファイル末尾改行の設定
set binary noeol

"---------------------------------------
" 基本キーマップ
"---------------------------------------
let mapleader = "\<Space>"

" Quick command
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" Quick save
nnoremap ss :w<CR>
nnoremap sc :wq<CR>

" Quick quit
nnoremap q :q<CR>
nnoremap <C-q> :qa!<CR>

"---------------------------------------
" マクロ
"---------------------------------------

" qを他のコマンドに明け渡すために変更
nnoremap Q q

"---------------------------------------
" 特定ファイルへのショートカット
"---------------------------------------

" Configure vim
nnoremap <silent> g. :<C-u>edit ~/.config/nvim/init.vim<CR>
nnoremap <silent> g, :<C-u>edit ~/.bashrc<CR>
nnoremap <silent> g<Space> :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> gp :<C-u>bprevious<CR>
nnoremap <silent> gn :<C-u>bnext<CR>

"---------------------------------------
" 設定の即時適用
"---------------------------------------

" Reload vimrc
nnoremap <Leader>, :<C-u>source $MYVIMRC<CR>

"---------------------------------------
" ヘルプ
"---------------------------------------

" 日本語ヘルプ優先
set helplang=ja,en

" /は直接表現できない。_を使って表現する。
" ? + 単語でヘルプ
" XXX: Vimscript上での末尾の空白を維持するために冗長なキーバインドにしている
nnoremap ? :<C-u>vertical help  <Bs>
" ?二回でカーソル下の単語のヘルプを引く
nnoremap <silent> ?? :<C-u>vertical help <C-r><C-w><CR>
" ヘルプでも<Return>でジャンプ
autocmd FileType help nnoremap <buffer> <Return> <C-]>

"---------------------------------------
" 全バッファリロード
"---------------------------------------

nnoremap R :<C-u>bufdo e!<CR>

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
"colorscheme wombat256mod
colorscheme hybrid

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

" 移動の基準を表示ベースに
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

"不快なAck.vimのquickfixなどの挙動を抑止
let g:ag_apply_qmappings=0
let g:ag_apply_lmappings=0

"タブ切り替え時にQuickfixを閉じる
"autocmd TabLeave * cclose

" QucickFix内のエントリを連続的に閲覧
nnoremap <silent> <Down> :<C-u>cn<CR>zz
nnoremap <silent> <Up> :<C-u>cp<CR>zz

" Quickfixを開く
" TODO: トグルできるように
nnoremap <silent> ,q :<C-u>copen 20<CR>:set number<CR>

" Quickfix終了
autocmd FileType qf nnoremap <buffer> q :close<CR>

" QF内ではタグジャンプの動作を抑止し通常通り
autocmd FileType qf nnoremap <buffer> <Return> <Return>

" Quickfixリストを用いた一括置換 (QFReplace)
autocmd FileType qf nnoremap <buffer> rr :Qfreplace<CR>

" Quickfixリストの絞り込み (QFGrep)
" XXX: Vimscript上での末尾の空白を維持するために冗長なキーバインドにしている
autocmd FileType qf nnoremap <buffer> ss :<C-u>QFGrepPat  <BS>
autocmd FileType qf nnoremap <buffer> vv :<C-u>QFGrepPatV  <BS>

"---------------------------------------
" マーク
"---------------------------------------

" マーク一覧
" nnoremap <silent> mm :<C-u>marks<CR>

"---------------------------------------
" 検索・タグジャンプ
"---------------------------------------

" tags
set tags&
set tags+=plugins/tags,lib/vendor/tags,tags;

" 検索時の大文字小文字の違いを無視
set ignorecase
" 検索単語に大文字小文字が混じっていれば無視しない
set smartcase

" 標準の正規表現検索をeregexに置き換え
let g:eregex_default_enable=0
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
" インデントを含めて結合をデフォルトに
"nnoremap J gJ
"nnoremap gJ J
"vnoremap J gJ
"vnoremap gJ J

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
" XXX: これ多分効いていない？
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
" Alignに伴って不要なキーマップを追加するプラグインがインストールされるので
" 導入されている場合は削除する
if exists(':AlignMapsClear') == 2
  :AlignMapsClear
endif

" Align.vim
let g:Align_xstrlen = 3
call Align#AlignCtrl ('v', '^#')

"for YAML indent
call Align#AlignCtrl ('|W')

" Yaml
" ノーマルモードの場合yamlのインライン記述を展開する
nnoremap <silent> \y <S-v>:S/(\{\s*\|,\s*)/\r      /g<CR><S-v>:S/\s*\}//<CR>j
" 選択されていた場合はインデントを揃える
vnoremap <silent> \y :Align : <CR>gv:S/(\s+):/:\1/<CR>gv:S/\s+:/:/ge<CR>gv:S@/\s*:\s*@/:@ge<CR>gv:S/\s+$//ge<CR>gv:S@(https?:)\s+//@\1//@ge<CR>

" ToogleCase キャメルキャプス・スネークケースなどを切り替え
" TODO: 形式を直接指定したい
nnoremap C :<C-u>call ToggleCase()<CR>

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
\ '\btags$',
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

autocmd TabLeave * NERDTreeClose
"autocmd TabLeave * UniteClose

nnoremap <C-s> :NERDTreeFind<CR>
nnoremap <C-e> :NERDTreeToggle<CR>

"---------------------------------------
" fzf
"---------------------------------------
" deniteと合わせて上部に表示
let g:fzf_layout = { 'up': '~40%' }
" fzfからファイルにジャンプできるようにする
let g:fzf_buffers_jump = 1

" サンプルキーバインド
nnoremap <silent> <Leader>s :CocList symbols<CR>
nnoremap <silent> <Leader>t :Tags<CR>
nnoremap <silent> <Leader>f :GFiles<CR>
nnoremap <silent> <Leader>F :GFiles?<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>l :BLines<CR>
nnoremap <silent> <Leader>h :History<CR>
"nnoremap <silent> <Leader>m :Mark<CR>

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
nnoremap <Leader>m :Unite neomru/file -buffer-name=files -start-insert<CR>
"nnoremap <Leader>M :Unite neomru/file -buffer-name=files -no-quit<CR>
"noremap <Leader>b :Unite buffer:- -buffer-name=files<CR>
nnoremap <Leader>B :Unite buffer:- -buffer-name=files -no-quit<CR>
"nnoremap <Leader>f :Unite buffer neomru/file -buffer-name=files -start-insert<CR>
"nnoremap <Leader>F :Unite buffer neomru/file -buffer-name=files -no-quit<CR>
"nnoremap <Leader>o :Unite outline -start-insert<CR>
nnoremap <Leader>O :Unite outline -no-quit<CR>
nnoremap <Leader>r :Unite register -buffer-name=register<CR>
nnoremap <Leader>R :Unite register -buffer-name=register -no-quit<CR>

" Unite上でもウィンドウ間移動が効くように
autocmd FileType unite nnoremap <buffer> th <C-W>h
autocmd FileType unite nnoremap <buffer> tj <C-W>j
autocmd FileType unite nnoremap <buffer> tk <C-W>k
autocmd FileType unite nnoremap <buffer> tl <C-W>l

" <Esc>/<C-l>でUniteを閉じる
autocmd FileType unite nnoremap <buffer> <Esc> :UniteClose<CR>

let s:filters = {
\   "name" : "my_converter",
\}

function! s:filters.filter(candidates, context)
    for candidate in a:candidates
        let bufname = bufname(candidate.action__buffer_nr)
        let filename = fnamemodify(bufname, ':p:t')
        let path = fnamemodify(bufname, ':p:h')

        " Customize output format.
        let candidate.abbr = printf("%s: %s", filename, path)
    endfor
    return a:candidates
endfunction

call unite#define_filter(s:filters)
unlet s:filters

" Unite-buffer: better format
call unite#custom#source('buffer', 'converters', 'my_converter')

" Neomru: Restrict files to the current project
call unite#custom#source('neomru/file', 'matchers',
      \ ['matcher_project_files', 'matcher_default'])

"---------------------------------------
" Unite-outline
"---------------------------------------
let g:unite_source_outline_indent_width=2

"---------------------------------------
" neomru
"---------------------------------------
let g:neomru#file_mru_limit=1000
let g:neomru#do_validate=1
call unite#custom#source('neomru/file', 'converters',
      \ ['converter_relative_abbr', 'converter_file_directory'])
"call unite#custom#source('neomru/file', 'sorters', ['sorter_word'])

"---------------------------------------
" Symfony
"---------------------------------------
nnoremap ,a :<C-u>Saction<CR>
nnoremap ,v :<C-u>Sview<CR>

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
" Agit
"---------------------------------------
nnoremap <C-g>v :Agit<CR>

"---------------------------------------
" 補完時のキーマップ
"---------------------------------------
inoremap <expr><silent> <Tab> pumvisible() ? "\<C-e>\<C-n>" : "\<Tab>"
inoremap <expr><silent> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><silent> <CR> pumvisible() ? "\<C-y>" : "\<CR>"


"---------------------------------------
" coc.nvim
"---------------------------------------

" PHP: coc-phplsよりintelephenseの方がエラー検出が正確なので
" コマンドラインより以下にてインストールしておく
" npm -i intelephense -g

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" Vista
nnoremap <silent> <space>o  :<C-u>Vista<cr>