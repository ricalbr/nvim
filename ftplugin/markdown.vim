" MARKDOWN

" commment string
autocmd FileType markdown setlocal commentstring=<!--%s-->

" Live Preview
noremap <buffer> <leader>ll :MarkdownPreview<CR>
noremap <buffer> <leader>lk :MarkdownPreviewStop<CR>
