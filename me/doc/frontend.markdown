# me::dev::frontent

include frontend development tools

## Install

in your `default.pp` file, just add :

``` puppet
include me::dev::frontend
```

## installed tools

* grunt: a javascript command line utility
* grunt-requirejs: compile requirejs scripts
* grunt-less: compile lesscss scripts
* jshint: javascript linter
* jsctags: javascript ctags generator (doctor.js)
* zencoding: html completer

## vim integration

* [`walm/jshint.vim`](https://github.com/walm/jshint.vim) provides jshint integration

_Add a specific ft for all files in your project_

```!puppet
au BufNewFile,BufRead */PROJECT_HOME/*.js set filetype=javascript.backbone
au BufNewFile,BufRead */PROJECT_HOME/**/tests/*.js set filetype=javascript.qunit
```

### ft: javascript.backbone

Following snippets are available:

    * `bbview`: create a new backboone view
    * `bbmodel`: create a new backboone model
    * `bbcollection`: create a new backboone collection

### ft: javascript.jquery

Any jquery.*.js file has jquery filetype. Up to now this does nothing.

## binding

* `<C-l>`: use jshint to lint current file
* `<F8>`: open tagbar
* `<C-e>,`: zend coding completion
