# me::dev::python

include python development tools

## Install

in your `default.pp` file, just add :

``` puppet
include me::dev::python
```

## installed tools

* [pylint](http://www.pylint.org/)

## vim integration

* [pythoncomplete](http://www.vim.org/scripts/script.php?script_id=1542) python
  omni completion
* [pylint.vim](https://github.com/vim-scripts/pylint.vim) linter

## binding

* `<C-l>`: lint current file
