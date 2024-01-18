-- LaTeX

-- tex specific text format
vim.opt.linebreak = true
-- set fo-=t

-- set compiler
vim.opt.compiler = "tex"

-- correcting spelling mistakes on the fly
vim.opt.spell = true
vim.opt.spellang="en_gb,it"

-- keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("i", "<C-l>", '<c-g>u<Esc>[s1z=`]a<c-g>u', opts)

-- generate the document and open pdf
inoremap <F7> <Esc> :w \| :Make % <CR>
nnoremap <F7> :w \| :Make % <CR>

-- compilation using pdflatex
inoremap <F8> <Esc> :w \| :! pdflatex % <CR><CR>
nnoremap <F8> :w \| :! pdflatex % <CR><CR>

-- open document
noremap <leader>o :! zathura %<.pdf & <CR><CR>
