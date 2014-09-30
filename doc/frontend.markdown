# me::dev::frontent

include frontend development tools

## Install

in your `default.pp` file, just add :

``` puppet
include me::dev::frontend
```

## installed tools

* jshint: javascript linter
* jsctags: javascript ctags generator (doctor.js)
* zencoding: html completer
* registry.npmjs.eu: europe npm registry. Activate it in ~/.npmrc
* [scss-lint](https://github.com/causes/scss-lint) provide sass files linting

Note that global npm packages are intalled in `~/.npm-packages`. Therefore, sudo
is not required when installing packages globaly. This relies on [Sindre
Sorhus's guide](https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo-linux.md)

## vim integration

* [`tern_for_vim`](https://github.com/marijnh/tern_for_vim) for [`tern`](http://ternjs.net/) integration.
* [`walm/jshint.vim`](https://github.com/walm/jshint.vim) provides jshint integration

_Add a specific ft for all files in your project_

```!vim
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

### Javascript

* `<C-l>`: use jshint to lint current file
* `<F8>`: open tagbar
* `<C-e>,`: zend coding completion

### Scss

* `<C-l>`: use scss-lint to lint current file
