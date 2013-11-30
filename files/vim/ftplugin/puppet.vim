" puppet specific bindings
" refer to https://github.com/themouette/puppet-me/blob/master/me/doc/puppet.markdown
" for further informations.

" Auto remove tailing spaces
autocmd BufWritePre *.pp :call StripTrailingWhitespace()

" Puppet linter
nmap <buffer> <C-l> :!/usr/local/bin/puppet-lint --with-filename %<CR>
