# me::dev::puppet

include developement tools for php development

## Install

in your `default.pp` file, just add :

``` puppet
include me::dev::php
```

## vim integration

* [`StanAngeloff/php.vim`](https://github.com/StanAngeloff/php.vim) provides syntax highlight
* specific configuration and binding are provided in `/home/${me::username}/.vim/autoload/php.vim`
* `twig` hightlight
* `behat` integration thanks to [vim-behat](https://github.com/veloce/vim-behat)
* ease namesapce manipulation thanks to [php-namespace](git://github.com/arnaud-lb/vim-php-namespace.git)
* phpunit thanks to [vim-phpunit](https://github.com/docteurklein/vim-phpunit)
* symfony integration through [vim-symfony](git://github.com/docteurklein/vim-symfony.git)
* tags are auto generated thanks to [guard-tags-composer](https://github.com/everzet/guard-ctags-composer)

## binding

* `<F5>`: autocomplete use statement (based on ctags)
* `<F8>`: toggle tagbar
* `<F9>`: start debug mode
* `<C-l>`: lint current file
* `<C-p>`: better autocompletion
* `<leader>doc`: opent php.net for word under cursor
* `<leader>cns`: insert current namespace
* `<leader>u`: autocomplete use statement (based on ctags)
* `<leader>m`: run phpunit tests
* `<leader>a`: run ack-grep
* `<leader>/`: clear search hghlight

### Symfony

* `<C-x><C-u>`: complete on routes and DIC
* `<C-F>`: open symfony interactive console
* `<leader>v`: switch to symfony view

### Tags

* `:tag`: jump to tag under cursor
* `<C-]>`: jump to tag under cursor
* `<leader><right>`: jump to tag under cursor
* `<C-W>]`: open tag in a new window
* `<leader><up>`: open tag in a new window
* `:pop`: return to previous position before tag jump
* `<C-T>`: return to previous position before tag jump
* `<leader><left>`: return to previous position before tag jump
* `:ptag`: preview tag in window

more on http://vim.wikia.com/wiki/Browsing_programs_with_tags

to install :

``` sh
$ cd /path/to/my/project
$ guard init ctags-composer
```

to start it :

``` sh
$ cd /path/to/my/project
$ guard &> /dev/null &
```

### Snippets

#### php

* `ns`: create a namespaced class
* `fun`: a class method with arguments autodocumentation
* `puf`: a public method with arguments autodocumentation
* `prof`: a protected method with arguments autodocumentation
* `prif`: a private method with arguments autodocumentation
* `fn`: a function with arguments autodocumentation

#### phpunit

All file ending in `Test.php` will have `phpunit` filetype.

Following snippets are available :

* `testCase`: bootstrap a new testcase class
* `test`: create a new test method
* `setUp` and `tearDown`: new setUp and tearDown functions
* `provider`: boilerplate for a new dataprovider method

#### sf2class

* `action`: bootstrap a new Action method.
