# me::dev::puppet

include developement tools for puppet development

## Install

in your `default.pp` file, just add :

``` puppet
include me::dev::puppet
```

## vim integration

* [`vim-puppet`](https://github.com/rodjek/vim-puppet) is used to provide
  puppet syntax highlight
 
## binding

* `<C-l>`: lint current file

## linter

`puppet-lint` gem is intalled to lint module files.

``` bash
$ puppet-lint --with-filename /path/to/modules/or/file
```
