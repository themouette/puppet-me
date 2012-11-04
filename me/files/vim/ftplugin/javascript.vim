" Javascript specific bindings

" better folding thanks to vim-javascript-syntax
" https://github.com/jelera/vim-javascript-syntax
call JavaScriptFold()

" javascript linter
nmap <buffer> <C-l> :JSHint %<CR>

" ctags replacement
let g:tagbar_type_javascript = {
    \ 'ctagsbin' : '/usr/local/bin/jsctags'
\ }
" open tagbar
nmap <F8> :TagbarToggle<CR>

