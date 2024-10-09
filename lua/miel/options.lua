local opt = vim.opt
local optm = vim.o
local global = vim.g
local api = vim.api
local indent = 4

global.mapleader = " "
global.loaded_matchparen = 1

optm.mouse = "n"

opt.showcmd = true
opt.incsearch = true
opt.showmatch = true
opt.hidden = true
opt.equalalways = true

opt.breakindent = true
opt.showbreak = string.rep(" ", 3)
opt.linebreak = true

opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1

opt.belloff = "all"

opt.inccommand = "split"
opt.shada = { "!", "'1000", "<50", "s10", "h" }

opt.formatoptions = opt.formatoptions - "a" - "t" + "c" + "q" - "o" + "r" + "n" + "j" + "2"

-- Set joinspaces
opt.joinspaces = false

-- set fillchars=eob:~
-- opt.fillchars = { eob = "~" }

opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }

opt.undofile = true

-- Completion
opt.pumheight = 15

-- OFICIAL

-- misc
opt.backspace = { "eol", "start", "indent" }
opt.clipboard = "unnamedplus"
opt.encoding = "utf-8"
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.syntax = "enable"

-- indention
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent

-- search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore
	+ { "*/node_modules/*", "*/.git/*", "*/vendor/*", "__pycahe__", "*.o", "*~", ".pyc", "*pycache*" }
opt.wildmenu = true

-- ui
opt.cursorline = true
opt.laststatus = 3
opt.showtabline = 0
--[[ opt.lazyredraw = true ]]
opt.list = false
opt.listchars = {
	tab = "¦·",
	trail = "·",
	lead = "·",
	extends = "»",
	precedes = "«",
	nbsp = "×",
}
opt.number = true
opt.rnu = true
opt.showmode = false
opt.sidescrolloff = 4 -- Lines to scroll horizontally
opt.signcolumn = "yes"
opt.splitbelow = true -- Open new split below
opt.splitright = true -- Open new split to the right
opt.wrap = false

-- backups
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- autocomplete
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess = opt.shortmess + { c = true }

-- perfomance
opt.redrawtime = 1500
opt.timeoutlen = 200
opt.ttimeoutlen = 10

-- theme
opt.termguicolors = true

opt.conceallevel = 3
opt.errorbells = false
opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
opt.scrolloff = 4
opt.autowrite = true
opt.cmdheight = 1
opt.updatetime = 50
