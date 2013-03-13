# me::dev::git

include git and related development tools

## Install

in your `default.pp` file, just add :

``` puppet
include me::dev::git
```

This will require vim default configutation.

## installed tools

* [Vim gutter](https://github.com/airblade/vim-gitgutter)
* Git template with hooks. Tempaltes are available in `~/.git_templates` dir
    and are used by default.
