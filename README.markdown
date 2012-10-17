# puppet-me

This file defines a module for my on configuration.

There is 2 main parts :

 * dev: a set of dev tools that ca be extended with extra manifets
 * user: the user and associated behaviors

## install

It's as easy as `git clone git@server:puppet-me.git ~/puppet/modules`

## include in your vagrant file

add the following line in your `Vagrantfile`

``` ruby
config.vm.provision :puppet, :module_path => "/home/julien/puppet/modules"
```

## available dev environments

* [puppet](me/doc/puppet.markdown)
* [php](me/doc/php.markdown)

## pimp your bash

* `$ fonctions` list all included extra functions
* `$ bashtips` list some tips for bash
