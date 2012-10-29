" this file defines php tools

" Twig
au BufNewFile,BufRead *.twig set filetype=twig
au BufNewFile,BufRead *.html.twig set filetype=twig.html
autocmd BufEnter *.html.twig nmap <buffer><leader>c :bf<CR>

" behat
let feature_filetype='behat'
