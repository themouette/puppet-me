" ruby specific bindngs

" Auto remove tailing spaces
autocmd BufWritePre *.rb :call StripTrailingWhitespace()
