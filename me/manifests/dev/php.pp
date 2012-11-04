# configure environment for php development
# simply add `include me::dev::php` to your manifest

class me::dev::php {

  include me::dev

  # specfic bingings and configuration
  file { "/home/${me::username}/.vim/ftplugin/php.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/ftplugin/php.vim',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/ftplugin"]
  }

  # related filetypes
  # =================
  # php.vim: bind extra filetypes
  file { "/home/${me::username}/.vim/autoload/php.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/autoload/php.vim',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/autoload"]
  }
  file { "/home/${me::username}/.vim/ftdetect/php.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/ftdetect/php.vim',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/ftdetect"]
  }
  # twig configuration
  file { "/home/${me::username}/.vim/ftplugin/twig.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/ftplugin/twig.vim',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/ftplugin"]
  }
  # sf14 compatibility layer
  file { "/home/${me::username}/.vim/ftplugin/symfony14.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/ftplugin/symfony14.vim',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/syntax"]
  }

  # syntax highlights
  # =================
  # php syntax highlight
  vcsrepo { "/home/${me::username}/.vim/bundle/php":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/StanAngeloff/php.vim.git',
    owner    => $me::username,
    group    => $me::username,
    require  => File['pathogen'],
  }
  # twig syntax highlight
  file { "/home/${me::username}/.vim/syntax/twig.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/syntax/twig.vim',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/syntax"]
  }
  # php autocompletion
  file { "/home/${me::username}/.vim/syntax/php.api":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/syntax/php.api',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/syntax"]
  }

  # plugins
  # =======
  # behat plugin
  vcsrepo { "/home/${me::username}/.vim/bundle/php-behat":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/veloce/vim-behat.git',
    user     => $me::username,
    require  => File['pathogen'],
  }
  # namespace ease plugin
  vcsrepo { "/home/${me::username}/.vim/bundle/php-namespace":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/arnaud-lb/vim-php-namespace.git',
    user     => $me::username,
    require  => File['pathogen'],
  }
  # phpunit plugin
  vcsrepo { "/home/${me::username}/.vim/bundle/php-unit":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/docteurklein/vim-phpunit.git',
    user     => $me::username,
    require  => File['pathogen'],
  }
  # symfony plugin
  vcsrepo { "/home/${me::username}/.vim/bundle/php-symfony":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/docteurklein/vim-symfony.git',
    user     => $me::username,
    require  => File['pathogen'],
  }
  # debugger
  file { "/home/${me::username}/.vim/plugin/php-debugger.py":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/plugin/php-debugger.py',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/syntax"]
  }
  file { "/home/${me::username}/.vim/plugin/php-debugger.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/plugin/php-debugger.vim',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/syntax"]
  }

  # Packages
  package { 'guard':
    ensure   => present,
    provider => 'gem',
  }
  package { 'guard-ctags-composer':
    ensure   => present,
    provider => 'gem',
    require  => Package['guard'],
  }

}
