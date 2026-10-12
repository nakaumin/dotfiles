-- init.lua (モダン化版)  Neovim 0.11+ 想定
-- 方針: lazy.nvim / ネイティブLSP / treesitter / Lua製プラグインへ移行。
--       キーバインドは元の使い心地をできるだけ維持。

vim.loader.enable()

local map = vim.keymap.set
local silent = { silent = true }
local opt = vim.opt
local g = vim.g

-- leader は plugin 読み込み前に設定
g.mapleader = " "

-- netrw 無効化 (nvim-tree を使うため)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

local aug = vim.api.nvim_create_augroup("user_config", { clear = true })
local function autocmd(event, opts)
  opts.group = aug
  vim.api.nvim_create_autocmd(event, opts)
end

--===============================================================================
-- ▶ オプション
--===============================================================================

-- コア
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.shada = "!,'10000,<300,s10,h"
opt.clipboard:append("unnamedplus")
opt.fixendofline = false -- 旧 `binary noeol` の代替: 末尾改行を勝手に付けない

-- 文字コード・改行
opt.fileformats = { "dos", "unix", "mac" }
opt.fileencodings = { "ucs-boms", "utf-8", "iso-2022-jp", "euc-jp", "cp932", "latin1" }
opt.ambiwidth = "double"

-- 表示
opt.termguicolors = true
opt.background = "dark"
opt.number = false
opt.cursorline = true
opt.virtualedit = "onemore"
opt.visualbell = true
opt.showmatch = true
opt.showmode = false -- lualine が表示する
opt.laststatus = 2
opt.signcolumn = "yes"
opt.updatetime = 300
opt.wildmode = "list:longest"
opt.helplang = { "ja", "en" }
opt.list = true
opt.listchars = { tab = "▸▸" }
opt.inccommand = "split"

-- インデント
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true

-- 検索
opt.ignorecase = true
opt.smartcase = true
vim.cmd("set tags&")
opt.tags:append({ "plugins/tags", "lib/vendor/tags", "tags;" })

-- 診断
vim.diagnostic.config({ severity_sort = true })

-- :Cfilter (QuickFix の絞り込み)
vim.cmd.packadd("cfilter")

--===============================================================================
-- ▶ 基本キーマップ
--===============================================================================

map({ "n", "v" }, ";", ":")
map({ "n", "v" }, ":", ";")

map("n", "ss", ":w<CR>")
map("n", "sc", ":wq<CR>")
map("n", "q", ":q<CR>")
map("n", "Q", "q")

-- 設定ファイル
map("n", "g.", ":<C-u>edit ~/.config/nvim/init.lua<CR>", silent)
map("n", "g,", ":<C-u>edit ~/.bashrc<CR>", silent)
map("n", "g<Space>", ":<C-u>edit $MYVIMRC<CR>", silent)
map("n", "gn", ":<C-u>bnext<CR>", silent)
map("n", "<Leader>,", ":<C-u>source $MYVIMRC<CR>")

-- ヘルプ
map("n", "?", ":<C-u>vertical help ")
map("n", "??", ":<C-u>vertical help <C-r><C-w><CR>", silent)
autocmd("FileType", {
  pattern = "help",
  callback = function(ev)
    map("n", "<Return>", "<C-]>", { buffer = ev.buf })
  end,
})

map("n", "R", ":<C-u>bufdo e!<CR>")

-- 表示切り替え
map("n", ",h", ":set hlsearch!<CR>", silent)
map("n", ",n", ":set number!<CR>", silent)
map("n", ",p", ":set paste!<CR>", silent)
map("n", ",s", function()
  vim.cmd(vim.fn.exists("syntax_on") == 1 and "syntax off" or "syntax on")
end, silent)
map("n", ",u", ":<C-u>setlocal invcursorline<CR>", silent)
map("n", ",i", ":<C-u>IBLToggle<CR>", silent)
map("n", ",t", ":<C-u>set expandtab!<CR>", silent)

-- カーソル移動
map({ "n", "v" }, "j", "gj", silent)
map({ "n", "v" }, "k", "gk", silent)
map({ "n", "v" }, "gj", "j", silent)
map({ "n", "v" }, "gk", "k", silent)

-- 単語移動をデフォルトに
map("n", "w", "l")
map("n", "b", "h")
map("n", "l", "w")
map("n", "h", "b")

-- 移動後の表示位置を画面中央に
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "[[", "[[<Esc>zz")
map("n", "]]", "]]<Esc>zz")
map("n", "<C-o>", "<C-o>zz", silent)
map("n", "gc", "`[v`]")

-- タブ・ウィンドウ
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

-- QuickFix
autocmd("TabLeave", { pattern = "*", command = "cclose" })
map("n", "<Down>", ":<C-u>cn<CR>zz", silent)
map("n", "<Up>", ":<C-u>cp<CR>zz", silent)
map("n", ",q", ":<C-u>copen 20<CR>:set number<CR>", silent)
map("n", "<space>j", ":<C-u>cn<CR>zz", silent)
map("n", "<space>k", ":<C-u>cp<CR>zz", silent)

autocmd("FileType", {
  pattern = "qf",
  callback = function(ev)
    local o = { buffer = ev.buf }
    map("n", "q", ":close<CR>", o)
    map("n", "<Return>", "<Return>", o)
    map("n", "rr", ":Qfreplace<CR>", o)
    map("n", "ss", ":<C-u>Cfilter ", o)  -- 含む行だけに絞り込み
    map("n", "vv", ":<C-u>Cfilter! ", o) -- 含む行を除外
  end,
})

-- eregex (/ を拡張正規表現に)
g.eregex_default_enable = 0
map("n", "/", ":<C-u>M/")
map("v", "/", ":M/")
map("n", "s/", ":<C-u>OverCommandLine<CR>%S/")
map("v", "s/", ":OverCommandLine<CR>S/")

-- YAML (Align + eregex の :S を使う。複雑なので Vimscript のまま)
vim.cmd([=[
nnoremap <silent> \y <S-v>:S/(\{\s*\|,\s*)/\r      /g<CR><S-v>:S/\s*\}//<CR>j
vnoremap <silent> \y :Align : <CR>gv:S/(\s+):/:\1/<CR>gv:S/\s+:/:/ge<CR>gv:S@/\s*:\s*@/:@ge<CR>gv:S/\s+$//ge<CR>gv:S@(https?:)\s+//@\1//@ge<CR>
]=])

-- 連番入力
vim.api.nvim_create_user_command("ContinuousNumber", function(o)
  local keys = o.args ~= "" and o.args or "\1" -- 既定は <C-a>
  local col = vim.fn.col(".")
  local count = o.range > 0 and (o.line2 - o.line1) or 1
  local saved = vim.o.nrformats
  vim.opt.nrformats:remove("octal")
  vim.fn.cursor(o.line1, col)
  for i = 1, count do
    vim.cmd("normal! j" .. i .. keys)
    vim.fn.cursor(vim.fn.line("."), col)
  end
  vim.o.nrformats = saved
end, { range = true, nargs = "?" })
map({ "n", "v" }, "co", ":ContinuousNumber<CR>", silent)

-- 無名バッファの自動削除
map("n", ",C", function()
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
end, silent)

--===============================================================================
-- ▶ カラースキーム用ハイライト (colorscheme 読み込み前に登録)
--===============================================================================
autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd("highlight CursorLine ctermbg=238 guibg=#444444")
    vim.cmd("highlight LineNr ctermfg=240 guifg=#585858")
    vim.cmd("highlight SpecialKey ctermfg=245 guifg=#8a8a8a")
  end,
})

--===============================================================================
-- ▶ lazy.nvim
--===============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
opt.rtp:prepend(lazypath)

-- copilot.vim の Tab マップを無効化 (補完メニューと競合するため)
g.copilot_no_tab_map = true

local function fzf(name, opts)
  return function()
    require("fzf-lua")[name](opts)
  end
end

require("lazy").setup({
  ---------------------------------------------------------------------------
  -- カラースキーム / UI
  ---------------------------------------------------------------------------
  {
    "w0ng/vim-hybrid",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("hybrid")
    end,
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = { enabled = false },
  },
  {
    "nvim-mini/mini.trailspace",
    event = "VeryLazy",
    config = function()
      require("mini.trailspace").setup()
      vim.api.nvim_create_user_command("FixWhitespace", function()
        require("mini.trailspace").trim()
      end, {})
    end,
  },

  ---------------------------------------------------------------------------
  -- ファイラー / 検索 / アウトライン
  ---------------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeClose" },
    opts = {
      view = { width = 40 },
      renderer = { group_empty = false },
      actions = { open_file = { quit_on_open = true } },
      filters = {
        custom = {
          "^\\.git$", "^tags$", "\\btags$", "^sf$",
          "\\.\\(xls\\|png\\|jpg\\|gif\\|map\\|pdf\\|bak\\)$",
          "\\~$", "^backup$", "^log$", "^var$", "^om$", "^dist$",
          "^uploads$", "^images$", "^vendor$", "^node_modules$",
          "^__pycache__$", "^bundle$",
        },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        map("n", ".", api.tree.toggle_hidden_filter, { buffer = bufnr })
      end,
    },
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    opts = { winopts = { height = 0.4, width = 1.0, row = 0, col = 0 } },
  },
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen" },
    opts = { backends = { "lsp", "treesitter" }, layout = { min_width = 60 } },
  },

  ---------------------------------------------------------------------------
  -- Git
  ---------------------------------------------------------------------------
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gwrite", "Gread", "Gvdiffsplit", "Gdiffsplit" },
  },
  { "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
  { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },

  ---------------------------------------------------------------------------
  -- Treesitter
  ---------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "lua", "vim", "vimdoc", "php", "javascript", "typescript", "tsx",
        "vue", "html", "css", "scss", "json", "yaml", "markdown",
        "markdown_inline", "bash", "solidity",
      })
      autocmd("FileType", {
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })
      local function select(query)
        return function()
          require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
        end
      end
      map({ "x", "o" }, "af", select("@function.outer"))
      map({ "x", "o" }, "if", select("@function.inner"))
    end,
  },

  ---------------------------------------------------------------------------
  -- LSP / 補完 / フォーマット
  ---------------------------------------------------------------------------
  { "mason-org/mason.nvim", opts = {} },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    opts = { ensure_installed = { "prettier" } },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- Vue: ts_ls に @vue/typescript-plugin を渡す (Volar hybrid mode)
      local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = vim.fn.stdpath("data")
          .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
        languages = { "vue" },
        configNamespace = "typescript",
      }
      vim.lsp.config("ts_ls", {
        init_options = { plugins = { vue_plugin } },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
      })
      vim.lsp.config("lua_ls", {
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })

      -- 入れたサーバは自動で vim.lsp.enable される
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls", "vue_ls", "intelephense", "jsonls", "cssls", "html", "lua_ls",
        },
      })
    end,
  },
  { "mason-org/mason-lspconfig.nvim", lazy = true },
  {
    "saghen/blink.cmp",
    version = "1.*",
    lazy = true,
    opts = {
      keymap = {
        preset = "none",
        ["<Tab>"] = {
          "select_next",
          "snippet_forward",
          function(cmp)
            local col = vim.fn.col(".") - 1
            local before = col > 0 and vim.fn.getline("."):sub(col, col):match("%s") == nil
            if before then return cmp.show() end
          end,
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        documentation = { auto_show = true },
      },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      default_format_opts = { lsp_format = "fallback" },
    },
  },
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      map("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
        expr = true, replace_keycodes = false, silent = true,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- 編集まわり (従来のプラグインを継続利用)
  ---------------------------------------------------------------------------
  { "tpope/vim-surround" },
  { "bhritchie/vim-toggle-case" },
  { "LeafCage/yankround.vim" },
  { "vim-scripts/Align", config = function()
      g.Align_xstrlen = 3
      vim.fn["Align#AlignCtrl"]("v", "^#")
      vim.fn["Align#AlignCtrl"]("|W")
    end },
  { "othree/eregex.vim" },
  { "osyo-manga/vim-over" },
  { "thinca/vim-qfreplace" },
  { "dalance/vseq.vim" },
}, {
  change_detection = { notify = false },
  rocks = { enabled = false },
})

-- Align が勝手に作るマップを消す (プラグイン読み込み後に実行)
autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    if vim.fn.exists(":AlignMapsClear") == 2 then
      vim.cmd("AlignMapsClear")
    end
  end,
})

--===============================================================================
-- ▶ プラグインのキーマップ
--===============================================================================

-- NvimTree
map("n", "<C-s>", ":NvimTreeFindFile<CR>")
map("n", "<C-e>", ":NvimTreeToggle<CR>")
autocmd("TabLeave", {
  pattern = "*",
  callback = function()
    if package.loaded["nvim-tree"] then
      require("nvim-tree.api").tree.close()
    end
  end,
})

-- fzf-lua
map("n", "<Return>", function()
  require("fzf-lua").git_files({ query = vim.fn.expand("<cword>") })
end, silent)
map("n", "<Leader>g", fzf("live_grep"), silent)
map("n", "<Leader>G", fzf("grep_cword"), silent)
map("n", "<Leader>t", fzf("tags"), silent)
map("n", "<Leader>f", fzf("files"), silent)
map("n", "<Leader>F", fzf("git_files"), silent)
map("n", "<Leader>b", fzf("buffers"), silent)
map("n", "<Leader>l", fzf("blines"), silent)
map("n", "<Leader>h", fzf("oldfiles"), silent)
map("n", "<Leader>r", fzf("registers"), silent)
map("n", "<Leader>s", fzf("lsp_live_workspace_symbols"), silent)
map("n", "<space>s", fzf("lsp_live_workspace_symbols"), silent)
map("n", "<space><space>", ":FzfLua<CR>", silent)
map("n", "<space>a", fzf("diagnostics_document"), silent)
map("n", "<space>c", fzf("commands"), silent)
map("n", "<space>p", fzf("resume"), silent)
map("n", "<space>e", ":Mason<CR>", silent)

-- aerial
map("n", "<Leader>o", ":AerialToggle<CR>")

-- Git
map("n", "ghp", function() require("gitsigns").preview_hunk() end)
map("n", "ghs", function() require("gitsigns").stage_hunk() end)
map("n", "ghu", function() require("gitsigns").reset_hunk() end)
map("n", "<C-g>a", ":Gwrite<CR>")
map("n", "<C-g>b", ":Git blame<CR>")
map("n", "<C-g>c", ":Git commit -v<CR>")
map("n", "<C-g>d", ":Gvdiffsplit<CR>")
map("n", "<C-g>r", ":Gread<CR>")
map("n", "<C-g>s", ":Git<CR>")
map("n", "<C-g>l", ":DiffviewFileHistory<CR>")

-- yankround / toggle-case
map({ "n", "x" }, "p", "<Plug>(yankround-p)", { remap = true })
map("n", "P", "<Plug>(yankround-P)", { remap = true })
map({ "n", "x" }, "gp", "<Plug>(yankround-gp)", { remap = true })
map("n", "gP", "<Plug>(yankround-gP)", { remap = true })
map("n", "<C-j>", "<Plug>(yankround-prev)", { remap = true })
map("n", "<C-k>", "<Plug>(yankround-next)", { remap = true })
map("n", "C", "<Plug>ToggleCase", { remap = true })

-- フォーマット
map("n", "F", function()
  require("conform").format({ async = true })
end)
vim.api.nvim_create_user_command("Format", function()
  require("conform").format({ async = true })
end, {})
vim.api.nvim_create_user_command("OR", function()
  vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
end, {})

--===============================================================================
-- ▶ LSP キーマップ (coc.nvim の操作感を踏襲)
--===============================================================================

-- 0.11 標準の gr* マップは `gr` の待ち時間の原因になるので外す
for _, lhs in ipairs({ "grr", "gri", "gra", "grn", "grt", "grx" }) do
  for _, mode in ipairs({ "n", "x" }) do
    pcall(vim.keymap.del, mode, lhs)
  end
end

map("n", "[g", function() vim.diagnostic.jump({ count = -1, float = true }) end, silent)
map("n", "]g", function() vim.diagnostic.jump({ count = 1, float = true }) end, silent)

map("n", "gd", vim.lsp.buf.definition, silent)
map("n", "gy", vim.lsp.buf.type_definition, silent)
map("n", "gi", vim.lsp.buf.implementation, silent)
map("n", "gr", vim.lsp.buf.references, silent)

map("n", "K", function()
  if vim.tbl_contains({ "vim", "help" }, vim.bo.filetype) then
    vim.cmd("h " .. vim.fn.expand("<cword>"))
  else
    vim.lsp.buf.hover()
  end
end, silent)

map("n", "<leader>rn", vim.lsp.buf.rename)
map("x", "<leader>a", vim.lsp.buf.code_action)
map("n", "<leader>ac", vim.lsp.buf.code_action)
map("n", "<leader>qf", function()
  vim.lsp.buf.code_action({ context = { only = { "quickfix" } }, apply = true })
end)

-- カーソル下シンボルのハイライト
autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight") then
      local grp = vim.api.nvim_create_augroup("lsp_highlight_" .. ev.buf, { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", {
        group = grp, buffer = ev.buf, callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
        group = grp, buffer = ev.buf, callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

