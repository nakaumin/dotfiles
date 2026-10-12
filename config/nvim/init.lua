-- init.lua (init.vim からの移植)
-- プラグインマネージャは vim-plug のまま利用

local map = vim.keymap.set
local silent = { silent = true }
local remap = { remap = true, silent = true }
local opt = vim.opt
local g = vim.g

vim.cmd("autocmd!")
vim.cmd("filetype plugin indent on")

-- プラグインエラー表示の無効化
g.coc_disable_startup_warning = 1

--===============================================================================
-- ▶ vim-plug
--===============================================================================
local plug_path = vim.fn.expand("~/.config/nvim/autoload/plug.vim")
if vim.fn.filereadable(plug_path) == 0 then
  print("install vim-plug...")
  vim.fn.system(
    "curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  )
  vim.cmd("source " .. plug_path)
end

local Plug = vim.fn["plug#"]
vim.call("plug#begin", "~/.config/nvim/plugged")

-- Library
Plug("Shougo/vimproc.vim", { dir = "~/.config/nvim/plugged/vimproc.vim", ["do"] = "make" })
Plug("clones/vim-l9")
Plug("kana/vim-operator-user")

-- Github copilot
Plug("github/copilot.vim")

-- Unite
Plug("Shougo/unite.vim")
Plug("Sixeight/unite-grep")

-- Vista
Plug("liuchengxu/vista.vim")

-- NERDTree
Plug("scrooloose/nerdtree")
Plug("xuyangy/nerdtree-ag-ack")

-- QuickFix
Plug("sk1418/QFGrep")
Plug("thinca/vim-qfreplace")

-- Git
Plug("gregsexton/gitv")
Plug("cohama/agit.vim")
Plug("airblade/vim-gitgutter")
Plug("tpope/vim-fugitive")
Plug("idanarye/vim-merginal")

-- Colorscheme
Plug("vim-scripts/wombat256.vim")
Plug("nanotech/jellybeans.vim")
Plug("w0ng/vim-hybrid")
Plug("vim-scripts/twilight")

-- Syntax
Plug("scrooloose/syntastic")
Plug("cakebaker/scss-syntax.vim")
Plug("hail2u/vim-css3-syntax")
Plug("posva/vim-vue")
Plug("tomlion/vim-solidity")
Plug("maxmellon/vim-jsx-pretty")

-- PHP
Plug("alvan/vim-php-manual", { ["for"] = "php" })
Plug("soh335/vim-symfony", { ["for"] = "php" })
Plug("vim-scripts/PDV--phpDocumentor-for-Vim", { ["for"] = "php" })

-- その他
Plug("dalance/vseq.vim")                  -- 連番
Plug("bronson/vim-trailing-whitespace")   -- 末尾空白
Plug("Yggdroot/indentLine")               -- インデント可視化
Plug("vim-scripts/renamer.vim")           -- ファイル操作
Plug("Lokaltog/vim-powerline", { rev = "develop" })
Plug("othree/eregex.vim")                 -- 正規表現
Plug("mileszs/ack.vim")                   -- 全文検索

-- fzf
Plug("junegunn/fzf", { dir = "~/.fzf", ["do"] = "./install --all" })
Plug("junegunn/fzf.vim")
Plug("vim-scripts/FuzzyFinder")

-- Other
Plug("thinca/vim-ref")
Plug("osyo-manga/vim-over")
Plug("ujihisa/repl.vim")
Plug("vim-scripts/sudo.vim")
Plug("vim-scripts/Align")
Plug("LeafCage/yankround.vim")

Plug("kana/vim-gf-user")
Plug("kana/vim-gf-diff")
Plug("kana/vim-altr")
Plug("kana/vim-tabpagecd")

Plug("bhritchie/vim-toggle-case")
Plug("tpope/vim-surround")

-- Language server
Plug("neoclide/coc.nvim", { branch = "release" })
Plug("neoclide/coc-vetur")

Plug("leafOfTree/vim-vue-plugin")
Plug("editorconfig/editorconfig-vim")
Plug("prettier/vim-prettier", { ["do"] = "yarn install" })

vim.call("plug#end")

g["prettier#config#config_precedence"] = "file-override"

--===============================================================================
-- ▶ 基本設定
--===============================================================================

-- コア設定
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.hidden = true
opt.autoread = true
opt.rtp:append("/usr/local/opt/fzf")
opt.shada = "!,'10000,<300,s10,h"

-- フォーマット・文字コード
opt.fileformats = { "dos", "unix", "mac" }
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = { "ucs-boms", "utf-8", "iso-2022-jp", "euc-jp", "cp932", "latin1" }
opt.ambiwidth = "double"
opt.binary = true
opt.eol = false

-- 基本キーマップ
g.mapleader = " "

map({ "n", "v" }, ";", ":")
map({ "n", "v" }, ":", ";")

map("n", "ss", ":w<CR>")
map("n", "sc", ":wq<CR>")
map("n", "q", ":q<CR>")

-- マクロ
map("n", "Q", "q")

-- 特定ファイルへのショートカット
map("n", "g.", ":<C-u>edit ~/.config/nvim/init.lua<CR>", silent)
map("n", "g,", ":<C-u>edit ~/.bashrc<CR>", silent)
map("n", "g<Space>", ":<C-u>edit $MYVIMRC<CR>", silent)
map("n", "gn", ":<C-u>bnext<CR>", silent)
-- gp は後述の yankround で上書きされるため bprevious は割り当てない

-- 設定の即時適用
map("n", "<Leader>,", ":<C-u>source $MYVIMRC<CR>")

-- ヘルプ
opt.helplang = { "ja", "en" }
map("n", "?", ":<C-u>vertical help  <Bs>")
map("n", "??", ":<C-u>vertical help <C-r><C-w><CR>", silent)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function(ev)
    map("n", "<Return>", "<C-]>", { buffer = ev.buf })
  end,
})

-- 全バッファリロード
map("n", "R", ":<C-u>bufdo e!<CR>")

-- 表示
vim.cmd("syntax on")
opt.number = false
opt.cursorline = true
opt.virtualedit = "onemore"
opt.smartindent = true
opt.visualbell = true
opt.showmatch = true
opt.wildmode = "list:longest"
opt.showcmd = true

-- カラースキーマ
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd("highlight CursorLine ctermbg=238")
    vim.cmd("highlight LineNr ctermfg=240")
    vim.cmd("highlight SpecialKey ctermfg=245")
  end,
})
vim.cmd("colorscheme hybrid")
opt.background = "dark"

-- 表示切り替え
map("n", ",h", ":set hlsearch!<CR>", silent)
map("n", ",n", ":set number!<CR>", silent)
map("n", ",p", ":set paste!<CR>", silent)
map("n", ",s", function()
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax off")
  else
    vim.cmd("syntax on")
  end
end, silent)
map("n", ",u", ":<C-u>setlocal invcursorline<CR>", silent)
map("n", ",i", ":<C-u>IndentLinesToggle<CR>", silent)
map("n", ",t", ":<C-u>set expandtab!<CR>", silent)

-- ステータス行
opt.laststatus = 2
g.Powerline_symbols = "fancy"

-- カーソル移動
opt.backspace = { "indent", "eol", "start" }

map({ "n", "v" }, "j", "gj", silent)
map({ "n", "v" }, "k", "gk", silent)
map({ "n", "v" }, "gj", "j", silent)
map({ "n", "v" }, "gk", "k", silent)

-- 単語移動をデフォルトに
map("n", "w", "l")
map("n", "b", "h")
map("n", "l", "w")
map("n", "h", "b")

-- タブ・インデント
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.shiftwidth = 2
g.indentLine_enabled = 0
opt.list = true
opt.listchars = { tab = "▸▸" }

-- ウィンドウ（タブ）移動
map("n", "<C-n>", ":tabnew<CR>", silent)
map("n", "ts", ":<C-u>vsp<CR>", silent)
map("n", "tS", ":<C-u>sp<CR>", silent)
map("n", "tt", ":<C-u>tabnew<CR>:tabmove<CR>", silent)
map("n", "H", ":<C-u>tabprevious<CR>", silent)
map("n", "L", ":<C-u>tabnext<CR>", silent)
map("n", "t+", "<C-w>+", silent)
map("n", "t-", "<C-w>-", silent)
map("n", "t<", "<C-w><", silent)
map("n", "t>", "<C-w>>", silent)
map("n", "td", ":<C-u>tabc<CR>", silent)
map("n", "tx", "<C-w>x", silent)
map("n", "tl", "<C-w>l", silent)
map("n", "th", "<C-w>h", silent)
map("n", "tj", "<C-w>j", silent)
map("n", "tk", "<C-w>k", silent)
map("n", "tc", ":<C-u>tab sp<CR>", silent)

-- Ack/Ag
g.ackprg = "ag --vimgrep"

-- QuickFix
g.ack_apply_qmappings = 0
g.ack_apply_lmappings = 0

vim.api.nvim_create_autocmd("TabLeave", { pattern = "*", command = "cclose" })

map("n", "<Down>", ":<C-u>cn<CR>zz", silent)
map("n", "<Up>", ":<C-u>cp<CR>zz", silent)
map("n", ",q", ":<C-u>copen 20<CR>:set number<CR>", silent)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(ev)
    local o = { buffer = ev.buf }
    map("n", "q", ":close<CR>", o)
    map("n", "<Return>", "<Return>", o)
    map("n", "rr", ":Qfreplace<CR>", o)
    map("n", "ss", ":<C-u>QFGrepPat  <BS>", o)
    map("n", "vv", ":<C-u>QFGrepPatV  <BS>", o)
  end,
})

-- 検索・タグジャンプ
vim.cmd("set tags&")
opt.tags:append({ "plugins/tags", "lib/vendor/tags", "tags;" })
opt.ignorecase = true
opt.smartcase = true

g.eregex_default_enable = 0
map("n", "/", ":<C-u>M/")
map("v", "/", ":M/")

opt.tagbsearch = true

map("n", "<Return>", ":GFiles  *<C-r><C-w>*<CR>", silent)

map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "[[", "[[<Esc>zz")
map("n", "]]", "]]<Esc>zz")
map("n", "<C-o>", "<C-o>zz", silent)

-- 置換
map("n", "s/", ":<C-u>OverCommandLine<CR>%S/")
map("v", "s/", ":OverCommandLine<CR>S/")

-- ビジュアルモード・選択
map("n", "gc", "`[v`]")
-- ga / gi の VisualCurrentIndentBlock は未定義かつ gi は coc で上書きされるため省略

-- ヤンク・ペースト
opt.clipboard:append("unnamed")

-- yankround
map({ "n", "x" }, "p", "<Plug>(yankround-p)", { remap = true })
map("n", "P", "<Plug>(yankround-P)", { remap = true })
map({ "n", "x" }, "gp", "<Plug>(yankround-gp)", { remap = true })
map("n", "gP", "<Plug>(yankround-gP)", { remap = true })
map("n", "<C-j>", "<Plug>(yankround-prev)", { remap = true })
map("n", "<C-k>", "<Plug>(yankround-next)", { remap = true })

-- テキスト整形
map("n", "F", ":<C-u>Prettier<CR>")

-- Align
if vim.fn.exists(":AlignMapsClear") == 2 then
  vim.cmd("AlignMapsClear")
end
g.Align_xstrlen = 3
vim.fn["Align#AlignCtrl"]("v", "^#")
vim.fn["Align#AlignCtrl"]("|W")

-- Yaml (複雑な正規表現が多いので Vimscript のまま)
vim.cmd([=[
nnoremap <silent> \y <S-v>:S/(\{\s*\|,\s*)/\r      /g<CR><S-v>:S/\s*\}//<CR>j
vnoremap <silent> \y :Align : <CR>gv:S/(\s+):/:\1/<CR>gv:S/\s+:/:/ge<CR>gv:S@/\s*:\s*@/:@ge<CR>gv:S/\s+$//ge<CR>gv:S@(https?:)\s+//@\1//@ge<CR>
]=])

-- ToggleCase
map("n", "C", "<Plug>ToggleCase", { remap = true })

-- 連番入力
vim.cmd([=[
command! -count -nargs=1 ContinuousNumber let snf=&nf|set nf-=octal|let cl = col('.')|for nc in range(1, <count>?<count>-line('.'):1)|exe 'normal! j' . nc . <q-args>|call cursor('.', cl)|endfor|unlet cl|unlet snf
]=])
map({ "n", "v" }, "co", ":ContinuousNumber <C-a><CR>", silent)

--===============================================================================
-- ▶ プラグイン設定
--===============================================================================

-- NERDTree
g.NERDTreeIgnore = {
  "^\\.git$",
  "^tags$",
  "\\btags$",
  "^sf$",
  "\\.\\(xls\\|png\\|jpg\\|gif\\|map\\|pdf\\|bak\\)$",
  "\\~$",
  "^backup$",
  "^log$",
  "^var$",
  "^om$",
  "^dist$",
  "^uploads$",
  "^images$",
  "^vendor$",
  "^node_modules$",
  "^__pycache__$",
  "^bundle$",
}
g.NERDTreeQuitOnOpen = 1
g.NERDTreeWinSize = 40
g.NERDTreeShowBookmarks = 1
g.NERDTreeMapToggleHidden = "."
g.NERDTreeCascadeSingleChildDir = 0
g.NERDTreeCascadeOpenSingleChildDir = 0

vim.api.nvim_create_autocmd("TabLeave", { pattern = "*", command = "NERDTreeClose" })

map("n", "<C-s>", ":NERDTreeFind<CR>")
map("n", "<C-e>", ":NERDTreeToggle<CR>")

-- fzf
g.fzf_layout = { up = "~40%" }
g.fzf_buffers_jump = 1

map("n", "<Leader>g", ":Rg<CR>", silent)
map("n", "<Leader>G", ":Rg <C-r><C-w><CR>", silent)
map("n", "<Leader>s", ":CocList symbols<CR>", silent)
map("n", "<Leader>t", ":Tags<CR>", silent)
map("n", "<Leader>f", ":Files<CR>", silent)
map("n", "<Leader>F", ":GFiles<CR>", silent)
map("n", "<Leader>b", ":Buffers<CR>", silent)
map("n", "<Leader>l", ":BLines<CR>", silent)
map("n", "<Leader>h", ":History<CR>", silent)

vim.api.nvim_create_user_command("History", function(o)
  vim.fn["fzf#vim#history"]({ options = "--tiebreak=begin --no-sort" }, o.bang and 1 or 0)
end, { bang = true, nargs = "*" })

-- GitGutter
map("n", "ghp", "<Plug>(GitGutterPreviewHunk)", { remap = true })
map("n", "ghs", "<Plug>(GitGutterStageHunk)", { remap = true })
map("n", "ghu", "<Plug>(GitGutterUndoHunk)", { remap = true })

-- Unite
vim.fn["unite#custom#profile"]("default", "context", {
  vertical = 1,
  toggle = 1,
  winwidth = 60,
})

map("n", "<Leader>B", ":Unite buffer:- -buffer-name=files -no-quit<CR>")
map("n", "<Leader>r", ":Unite register -buffer-name=register<CR>")
map("n", "<Leader>R", ":Unite register -buffer-name=register -no-quit<CR>")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "unite",
  callback = function(ev)
    local o = { buffer = ev.buf }
    map("n", "th", "<C-W>h", o)
    map("n", "tj", "<C-W>j", o)
    map("n", "tk", "<C-W>k", o)
    map("n", "tl", "<C-W>l", o)
    map("n", "<Esc>", ":UniteClose<CR>", o)
  end,
})

-- Unite のカスタムフィルタ (Vimscript の関数辞書を使うためそのまま)
vim.cmd([=[
let s:filters = {
\   "name" : "my_converter",
\}

function! s:filters.filter(candidates, context)
    for candidate in a:candidates
        let bufname = bufname(candidate.action__buffer_nr)
        let filename = fnamemodify(bufname, ':p:t')
        let path = fnamemodify(bufname, ':p:h')
        let candidate.abbr = printf("%s: %s", filename, path)
    endfor
    return a:candidates
endfunction

call unite#define_filter(s:filters)
unlet s:filters
call unite#custom#source('buffer', 'converters', 'my_converter')
]=])

-- Vista
g.vista_default_executive = "coc"
g.vista_fzf_preview = { "right:50%" }
g.vista_sidebar_width = 60
g.vista_enable_markdown_extension = 0
map("n", "<Leader>o", ":Vista!!<CR>")

-- Symfony
map("n", ",a", ":<C-u>Saction<CR>")
map("n", ",v", ":<C-u>Sview<CR>")

--===============================================================================
-- ▶ Git関連設定
--===============================================================================

-- Fugitive
map("n", "<C-g>a", ":Gwrite<CR>")
map("n", "<C-g>b", ":Git blame<CR>")
map("n", "<C-g>c", ":Gcommit -v<CR>")
map("n", "<C-g>d", ":Gvdiffsplit<CR>")
map("n", "<C-g>r", ":Gread<CR>")
map("n", "<C-g>s", ":Git<CR>")

-- Agit
map("n", "<C-g>l", ":Agit<CR>")

--===============================================================================
-- ▶ coc.nvim
--===============================================================================
-- PHP: intelephense を使う
-- npm -i intelephense -g

opt.cmdheight = 2
opt.updatetime = 300
opt.shortmess:append("c")
opt.signcolumn = "yes"

local function check_back_space()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

-- Tab で補完
map("i", "<TAB>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  elseif check_back_space() then
    return "<TAB>"
  else
    return vim.fn["coc#refresh"]()
  end
end, { silent = true, expr = true })
map("i", "<S-TAB>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-h>"
end, { expr = true })

map("i", "<c-space>", function()
  return vim.fn["coc#refresh"]()
end, { silent = true, expr = true })

-- <CR> で補完確定
map("i", "<cr>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<C-g>u<CR>"
end, { expr = true })

-- 診断
map("n", "[g", "<Plug>(coc-diagnostic-prev)", remap)
map("n", "]g", "<Plug>(coc-diagnostic-next)", remap)

-- goto
map("n", "gd", "<Plug>(coc-definition)", { remap = true })
map("n", "gy", "<Plug>(coc-type-definition)", remap)
map("n", "gi", "<Plug>(coc-implementation)", remap)
map("n", "gr", "<Plug>(coc-references)", remap)

-- K でドキュメント表示
local function show_documentation()
  if vim.tbl_contains({ "vim", "help" }, vim.bo.filetype) then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  else
    vim.fn.CocAction("doHover")
  end
end
map("n", "K", show_documentation, silent)

-- カーソル下シンボルのハイライト
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.fn.CocActionAsync("highlight")
  end,
})

-- リネーム
map("n", "<leader>rn", "<Plug>(coc-rename)", { remap = true })

local mygroup = vim.api.nvim_create_augroup("mygroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = mygroup,
  pattern = { "typescript", "json" },
  callback = function()
    vim.opt_local.formatexpr = "CocAction('formatSelected')"
  end,
})
vim.api.nvim_create_autocmd("User", {
  group = mygroup,
  pattern = "CocJumpPlaceholder",
  callback = function()
    vim.fn.CocActionAsync("showSignatureHelp")
  end,
})

-- コードアクション
map({ "x", "n" }, "<leader>a", "<Plug>(coc-codeaction-selected)", { remap = true })
map("n", "<leader>ac", "<Plug>(coc-codeaction)", { remap = true })
map("n", "<leader>qf", "<Plug>(coc-fix-current)", { remap = true })

-- 関数テキストオブジェクト
map({ "x", "o" }, "if", "<Plug>(coc-funcobj-i)", { remap = true })
map({ "x", "o" }, "af", "<Plug>(coc-funcobj-a)", { remap = true })

-- コマンド
vim.api.nvim_create_user_command("Format", function()
  vim.fn.CocAction("format")
end, { nargs = 0 })
vim.api.nvim_create_user_command("Fold", function(o)
  vim.fn.CocAction("fold", unpack(o.fargs))
end, { nargs = "?" })
vim.api.nvim_create_user_command("OR", function()
  vim.fn.CocAction("runCommand", "editor.action.organizeImport")
end, { nargs = 0 })

-- ステータスライン
opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- CocList
map("n", "<space><space>", ":<C-u>CocList<cr>", silent)
map("n", "<space>a", ":<C-u>CocList diagnostics<cr>", silent)
map("n", "<space>e", ":<C-u>CocList extensions<cr>", silent)
map("n", "<space>c", ":<C-u>CocList commands<cr>", silent)
map("n", "<space>s", ":<C-u>CocList -I symbols<cr>", silent)
map("n", "<space>j", ":<C-u>CocNext<CR>", silent)
map("n", "<space>k", ":<C-u>CocPrev<CR>", silent)
map("n", "<space>p", ":<C-u>CocListResume<CR>", silent)

-- 無名バッファの自動削除
local function clean_no_name_empty_buffers()
  local buffers = {}
  for nr = 1, vim.fn.bufnr("$") do
    if vim.fn.buflisted(nr) == 1
      and vim.fn.bufname(nr) == ""
      and vim.fn.bufwinnr(nr) < 0
      and vim.deep_equal(vim.fn.getbufline(nr, 1, "$"), { "" })
    then
      table.insert(buffers, nr)
    end
  end
  if #buffers > 0 then
    vim.cmd("bd " .. table.concat(buffers, " "))
  else
    print("No buffer deleted")
  end
end
map("n", ",C", clean_no_name_empty_buffers, silent)
