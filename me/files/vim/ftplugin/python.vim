" puppet specific bindings
" refer to https://github.com/themouette/puppet-me/blob/master/me/doc/python.markdown
" for further informations.

" Auto remove tailing spaces
autocmd BufWritePre *.py :call StripTrailingWhitespace()

" Activate python auto-complete
set omnifunc=pythoncomplete#Complete
