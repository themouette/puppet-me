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

## vim integration

### ft: javascript.backbone

Following snippets are available:

    `bbview`: create a new backboone view
    `bbmodel`: create a new backboone model
    `bbcollection`: create a new backboone collection

### ft: javascript.jquery

Any jquery.*.js file has jquery filetype. Up to now this does nothing.

## binding

