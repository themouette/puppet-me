" Javascript specific bindings

" better folding thanks to vim-javascript-syntax
" https://github.com/jelera/vim-javascript-syntax
call JavaScriptFold()

" javascript linter
nmap <buffer> <C-l> :JSHint %<CR>
"
" open tagbar
nmap <F8> :TagbarToggle<CR>

if exists('s:did_me_js_snip_helper') || &cp || !exists('loaded_snips')
    finish
endif
let s:did_me_js_snip_helper = 1

function! Snippet_JSClassNameFromFilename(...)
    let name = expand("%:t:r:r")
    if len(name) == 0
        if a:0 == 0
            let name = 'MyClass'
        else
            let name = a:1
        endif
    endif
    return name
endfunction
