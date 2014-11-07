# puppet-me

This file defines a module for my on configuration.

There is 2 main parts :

 * dev: a set of dev tools that ca be extended with extra manifets
 * user: the user and associated behaviors

## install

It's as easy as `git clone https://github.com/themouette/puppet-me.git ~/puppet/modules/me`

Then link your .ssh folder under `me/files/ssh` and install dependencies

``` sh
$ ~/puppet/modules/me/bin/bootstrap.sh
```

## Provision

``` sh
$ puppet apply -e "include me, me::dev, me::dev::ruby, me::dev::python"
```

## include in your vagrant file

add the following line in your `Vagrantfile`

``` ruby
  # Run a shell script to initialize the VM
  config.vm.provision :shell, :path => "/home/julien/.puppet/modules/me/bin/puppet.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = [
        "/home/julien/puppet/modules"
    ]
  end
```

## available dev environments

* [puppet](https://github.com/themouette/puppet-me/blob/master/doc/puppet.markdown)
* [php](https://github.com/themouette/puppet-me/blob/master/doc/php.markdown)
* [frontend](https://github.com/themouette/puppet-me/blob/master/doc/frontend.markdown)
* markdown syntax highlight
* [git integration](https://github.com/themouette/puppet-me/blob/master/doc/git.markdown)
* [ruby](https://github.com/themouette/puppet-me/blob/master/doc/ruby.markdown)
* [python](https://github.com/themouette/puppet-me/blob/master/doc/python.markdown)
* [perl](https://github.com/themouette/puppet-me/blob/master/doc/perl.markdown)
* [docker](https://github.com/themouette/puppet-me/blob/master/doc/docker.markdown)

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

