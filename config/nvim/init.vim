"===============================================================================
" Core settings
"===============================================================================

if &compatible
  set nocompatible               " Be iMproved
endif

let mapleader = "\<Space>"

"===============================================================================
" Plugins
"===============================================================================

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  "call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})

  " Add or remove your plugins here like this:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  call dein#add('Shougo/denite.nvim')

  " NERDTree
  call dein#add('scrooloose/nerdtree')

  " Qfreplace
  call dein#add('thinca/vim-qfreplace')

  " Eregex
  call dein#add('othree/eregex.vim')

  " Syntastic
  call dein#add('scrooloose/syntastic')

  " Powerline
  call dein#add('Lokaltog/vim-powerline', {'rev' : 'develop'})

  " Align
  call dein#add('vim-scripts/Align')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"===============================================================================
" Key bindings
"===============================================================================

"---------------------------------------
" Basic
"---------------------------------------
" Quick command
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" Quick save
nnoremap <C-s> :w<CR>

" Quick quit
nnoremap q :q<CR>

" Escape alternative
nnoremap <C-l> <Esc>
vnoremap <C-l> <Esc>
cnoremap <C-l> <Esc>
inoremap <C-l> <Esc>

" Macro
nnoremap Q q<CR>

" Reload vimrc
nnoremap <Leader>, :<C-u>source $MYVIMRC<CR>

"---------------------------------------
" Quick help
"---------------------------------------
nnoremap <C-h> :<C-u>vertical help
nnoremap <silent> <C-h><C-h> :<C-u>vertical help <C-r><C-w><CR>

"---------------------------------------
" Cursor move
"---------------------------------------
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk
nnoremap <silent> gj j
nnoremap <silent> gk k
vnoremap <silent> gj j
vnoremap <silent> gk k
nnoremap w l
nnoremap b h
nnoremap l w
nnoremap h b

"---------------------------------------
" Jump behavior
"---------------------------------------
nnoremap n nzz
nnoremap N Nzz
nnoremap [[ [[<Esc>zz
nnoremap ]] ]]<Esc>zz
nnoremap <silent> <C-o> <C-o>zz

"---------------------------------------
" Window/Tab operations
"---------------------------------------
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
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
" Quick access
"---------------------------------------
nnoremap <silent> g. :<C-u>edit ~/.config/nvim/init.vim<CR>
nnoremap <silent> g, :<C-u>edit ~/.bashrc<CR>
nnoremap <silent> <Return> :execute 'tjump' expand('<cword>')<Return>zz
nnoremap <silent> g<Space> :<C-u>edit $MYVIMRC<CR>

"---------------------------------------
" Toggle settings
"---------------------------------------
nnoremap <silent> ,h :set hlsearch!<CR>
nnoremap <silent> ,n :set number!<CR>
nnoremap <silent> ,p :set paste!<CR>
nnoremap <silent> <expr> ,s (exists("syntax_on")) ? "<Esc>:syntax off<CR>" : "<Esc>:syntax on<CR>"
nnoremap <silent> ,u :<C-u>setlocal invcursorline<CR>

"---------------------------------------
" Visual Selection
"---------------------------------------
nnoremap ga :call VisualCurrentIndentBlock('a')<CR>
nnoremap gc `[v`]
nnoremap gi :call VisualCurrentIndentBlock('i')<CR>

"---------------------------------------
" QuickFix Jump
"---------------------------------------
nnoremap <silent> <C-Up> :<C-u>cn<CR>zz
nnoremap <silent> <C-Down> :<C-u>cp<CR>zz

"---------------------------------------
" NERDTree
"---------------------------------------
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

nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-e> :NERDTreeToggle<CR>

"-------------------------------
" Quick search & replace
"-------------------------------
nnoremap / :M/
nnoremap s/ :%S/
vnoremap / :M/
vnoremap s/ :S/

"---------------------------------------
" Join lines
"---------------------------------------
nnoremap J gJ
nnoremap gJ J
vnoremap J gJ
vnoremap gJ J

"---------------------------------------
" Special format
"---------------------------------------
" Yaml format
nnoremap <silent> \y <S-v>:S/(\{\s*\|,\s*)/\r      /g<CR><S-v>:S/\s*\}//<CR>j
vnoremap <silent> \y :Align : <CR>gv:S/(\s+):/:\1/<CR>gv:S/\s+:/:/ge<CR>gv:S@/\s*:\s*@/:@ge<CR>gv:S/\s+$//ge<CR>gv:S@(https?:)\s+//@\1//@ge<CR>
" Continuous Number
nnoremap <silent> co :ContinuousNumber <C-a><CR>
vnoremap <silent> co :ContinuousNumber <C-a><CR>

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

"---------------------------------------
" Denite
"---------------------------------------
nnoremap <Leader>m :<C-u>Denite file_mru<CR>
nnoremap <C-g>V :Gitv --all<CR>
nnoremap <C-g>m :Merginal<CR>

