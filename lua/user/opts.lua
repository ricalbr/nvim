-- vim.api.nvim_command('filetype plugin indent on')
-- vim.cmd('syntax on')

vim.opt.autoindent = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.hidden = true
vim.g.noswapfile = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.cindent = true
vim.opt.cinoptions = ':.5s,>1s,p0,t0,(0,g2'
vim.opt.cinwords = 'if,else,while,do,for,switch,case,class,try'
vim.opt.termguicolors = true

-- listchars options
vim.opt.list = true
vim.opt.listchars = {
  nbsp = '⦸',       -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends = '»',    -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = '«',   -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab = '▷⋯',       -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
  trail = '•',      -- BULLET (U+2022, UTF-8: E2 80 A2)
}

-- fillchar options
vim.opt.fillchars = {
  diff = '∙',       -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob = ' ',        -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold = '·',       -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert = '┃',       -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83) 
  diff = '∙',       -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  fold = ·,         -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
} 

vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.nrformats: remove{'octal'}
vim.opt.diffopt: append{'foldcolumn:0', 'vertical'}
vim.g.splitvertical = true
vim.g.splitright = true
vim.g.splitbelow = true


-- folding options
vim.opt.foldlevelstart=99
vim.wo.foldmethod = 'indent' 
-- qui è un buon punto per partire https://github.com/wincent/wincent/commit/6c98fcb169345131e37e856d6ea2d264e61f3820
-- vim.opt.foldtext = 'user.foldtext()'
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- delete comment character when joining commented lines
vim.opt.formatoptions: append{'j'}

vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wildignore: append {'*.bak','*.swp','*.swo','*.a','*.o','*.so','*.pyc','*.class', '*.jpg','*.jpeg','*.gif','*.png','*.pdf', '*/.git*','*.tar','*.zip', '*.obj','*.exe','*.py[co]','.svn'}
vim.opt.completeopt = 'longest,menuone'
vim.opt.omnifunc = 'syntaxcomplete#Complete'

vim.opt.path = '.,**'
vim.opt.scrolljump = 5
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 5
vim.g.noshowmode = true
vim.opt.lazyredraw = true
vim.opt.redrawtime = 10000
vim.opt.synmaxcol = 0
vim.opt.number = true

vim.opt.relativenumber = true

vim.opt.numberwidth = 5
vim.opt.signcolumn = 'yes'
vim.opt.undofile = true
vim.opt.encoding = 'utf-8'

