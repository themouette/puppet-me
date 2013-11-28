# puppet-me

This file defines a module for my on configuration.

There is 2 main parts :

 * dev: a set of dev tools that ca be extended with extra manifets
 * user: the user and associated behaviors

## install

It's as easy as `git clone git@server:puppet-me.git ~/puppet/modules`

Then link your .ssh folder under `me/files/ssh`

``` sh
$ ln -s /home/julien/.ssh/ ~/puppet/modules/me/files/ssh
```

## include in your vagrant file

add the following line in your `Vagrantfile`

``` ruby
  # Run a shell script to initialize the VM
  config.vm.provision :shell, :path => "/home/julien/puppet/modules/bootstrap.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = [
        "/home/julien/puppet/modules"
    ]
  end
```

## available dev environments

* [puppet](https://github.com/themouette/puppet-me/blob/master/me/doc/puppet.markdown)
* [php](https://github.com/themouette/puppet-me/blob/master/me/doc/php.markdown)
* [frontend](https://github.com/themouette/puppet-me/blob/master/me/doc/frontend.markdown)
* markdown syntax highlight
* [git integration](https://github.com/themouette/puppet-me/blob/master/me/doc/git.markdown)
* [ruby](https://github.com/themouette/puppet-me/blob/master/me/doc/ruby.markdown)
* [python](https://github.com/themouette/puppet-me/blob/master/me/doc/python.markdown)

## pimp your bash

* `$ fonctions` list all included extra functions
* `$ bashtips` list some tips for bash

## Vim binding

* `<F2>`: Toggle paste mode
* `<F3>`: Toggle git gutter
* `<leader> /`: Clear search highlight
* `<leader> l`: Show hidden characters

## Installed packages

* [localtunnel](http://progrium.com/localtunnel/)
* htop
* wget
* curl
* ack-grep
* pandoc

