# ensure vim installed with pathogen and other stuff
class me::dev::vim {

  include ::me::params

  $packagename = $::operatingsystem ? {
      /(Ubuntu|Debian)/ => 'vim-nox',
  }

  # vim package
  # ===========
  if !defined(Package['vim']) {
    package { 'vim':
        ensure => present,
        name   => $me::dev::vim::packagename,
    }
  }
  package { 'exuberant-ctags':
    ensure  => present,
  }

  file { "${::me::params::home}/.vimrc":
    source  => 'puppet:///modules/me/vim/vimrc',
    require => Class['me::user'],
  }

  file { "${::me::params::home}/.vim":
    ensure  => directory,
    owner   => $::me::params::username,
    group   => $::me::params::username,
    mode    => '0644',
    require => [ Class['me::user'], Package['vim'] ],
  }

  # installing pathogen
  # ===================
  # directory structure
  file {
  ["${::me::params::home}/.vim/bundle",
  "${::me::params::home}/.vim/autoload",
  "${::me::params::home}/.vim/ftplugin",
  "${::me::params::home}/.vim/plugin",
  "${::me::params::home}/.vim/syntax",
  "${::me::params::home}/.vim/ftdetect",
  "${::me::params::home}/.vim/snippets",
  "${::me::params::home}/.vim/UltiSnips",
  "${::me::params::home}/.vim/python/helpers",
    ]:
    ensure  => directory,
    owner   => $::me::params::username,
    group   => $::me::params::username,
    mode    => '0775',
    require => [ Package['vim'], File["${::me::params::home}/.vim"] ];
  }
  # pathogen plugin file
  file {
  'pathogen':
    ensure  => present,
    source  => 'puppet:///modules/me/vendor/pathogen/autoload/pathogen.vim',
    name    => "${::me::params::home}/.vim/autoload/pathogen.vim",
    owner   => $::me::params::username,
    group   => $::me::params::username,
    mode    => '0664',
    require => [
        File["${::me::params::home}/.vim/autoload"],
        File["${::me::params::home}/.vim/bundle"],
        File["${::me::params::home}/.vim/ftplugin"],
        File["${::me::params::home}/.vim/plugin"],
        File["${::me::params::home}/.vim/syntax"],
        File["${::me::params::home}/.vim/ftdetect"],
        File["${::me::params::home}/.vim/snippets"],
        File["${::me::params::home}/.vim/UltiSnips"],
        File["${::me::params::home}/.vim/python/helpers"],
    ];
  }

  # Copy vim config files
  me::dev::vim::file {
    'plugin/me.vim':
      provider => 'template'
      ;
    'ftplugin/markdown.vim': ;
    'autoload/snippets.vim': ;
    # python helpers for snippets
    'python/helpers/__init__.py': ;
  }

  # general purpose vim bundles
  # ===========================
  me::dev::vim::bundle {
    # solarized is the color scheme
    'vim-colors-solarized':
      source => 'git://github.com/altercation/vim-colors-solarized.git',
      ;
    # fugitive.vim is a git client
    'vim-fugitive':
      source => 'git://github.com/tpope/vim-fugitive.git',
      ;
    # UltiSnips
    'ultisnips':
      source => 'git://github.com/SirVer/ultisnips.git',
      ;
    # UltiSnips
    'vim-snippets':
      source => 'git://github.com/honza/vim-snippets.git',
      ;
    # TagBar
    'tagbar':
      source => 'git://github.com/majutsushi/tagbar.git',
      ;
    # vim ack
    'vim-ack':
      source => 'git://github.com/mileszs/ack.vim.git',
      ;
    # vim powerline replacement
    'vim-airline':
      source => 'https://github.com/bling/vim-airline.git',
      ;
    # syntastic
    'syntastic':
      source => 'https://github.com/scrooloose/syntastic.git',
      ;
    # vim markdown
    'vim-markdown':
      source => 'git://github.com/tpope/vim-markdown.git',
      ;
  }
}
