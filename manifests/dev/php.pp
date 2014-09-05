# configure environment for php development
# simply add `include me::dev::php` to your manifest

class me::dev::php {

  include me::params
  include me::dev

  me::dev::vim::file {
    # specfic bingings and configuration
    'ftplugin/php.vim': ;
    # related filetypes
    # =================
    # php.vim: bind extra filetypes
    'plugin/php.vim': ;
    'ftdetect/php.vim': ;
    # twig configuration
    'ftplugin/twig.vim': ;
    # twig syntax highlight
    'syntax/twig.vim': ;
    # sf14 compatibility layer
    'ftplugin/symfony14.vim': ;
    # php autocompletion
    'syntax/php.api': ;
    # debugger
    'plugin/php-debugger.py': ;
    'plugin/php-debugger.vim': ;
    # snippets
    'UltiSnips/php.snippets': ;
    'UltiSnips/phpunit.snippets': ;
    'UltiSnips/sf2class.snippets': ;
    'python/helpers/php.py': ;
  }

  me::dev::vim::bundle {
    # php syntax highlight
    'php':
      source => 'git://github.com/StanAngeloff/php.vim.git',
      ;
    # behat plugin
    'php-behat':
      source => 'git://github.com/veloce/vim-behat.git',
      ;
    # namespace ease plugin
    'php-namespace':
      source => 'git://github.com/arnaud-lb/vim-php-namespace.git',
      ;
    # phpunit plugin
    'php-unit':
      source => 'git://github.com/docteurklein/vim-phpunit.git'
      ;
    # symfony plugin
    'php-symfony':
      source => 'git://github.com/docteurklein/vim-symfony.git',
      ;
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
