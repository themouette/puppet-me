# ensure vim installed with pathogen and other stuff
class me::dev::vim {
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

  file { "/home/${me::username}/.vimrc":
    source  => 'puppet:///modules/me/vim/vimrc',
    require => Class['me::user'],
  }

  file { "/home/${me::username}/.vim":
    ensure  => directory,
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => [ Class['me::user'], Package['vim'] ],
  }

  # installing pathogen
  # ===================
  # directory structure
  file {
  ["/home/${me::username}/.vim/bundle",
  "/home/${me::username}/.vim/autoload",
  "/home/${me::username}/.vim/ftplugin",
  "/home/${me::username}/.vim/plugin",
  "/home/${me::username}/.vim/syntax",
  "/home/${me::username}/.vim/ftdetect",
  "/home/${me::username}/.vim/snippets",
  "/home/${me::username}/.vim/UltiSnips",
    ]:
    ensure  => directory,
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require => [ Package['vim'], File["/home/${me::username}/.vim"] ];
  }
  # pathogen plugin file
  file {
  'pathogen':
    ensure  => present,
    source  => 'puppet:///modules/me/vendor/pathogen/autoload/pathogen.vim',
    name    => "/home/${me::username}/.vim/autoload/pathogen.vim",
    owner   => $me::username,
    group   => $me::username,
    mode    => '0664',
    require => [
        File["/home/${me::username}/.vim/autoload"],
        File["/home/${me::username}/.vim/bundle"],
        File["/home/${me::username}/.vim/ftplugin"],
        File["/home/${me::username}/.vim/plugin"],
        File["/home/${me::username}/.vim/syntax"],
        File["/home/${me::username}/.vim/ftdetect"],
        File["/home/${me::username}/.vim/snippets"],
        File["/home/${me::username}/.vim/UltiSnips"],
    ];
  "/home/${me::username}/.vim/autoload/me.vim":
    ensure  => present,
    content => template('me/vim/autoload/me.vim.erb'),
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require => [ File['pathogen'] ];
  "/home/${me::username}/.vim/autoload/snippets.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/autoload/snippets.vim',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require => [ File['pathogen'] ];
  "/home/${me::username}/.vim/ftplugin/markdown.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/ftplugin/markdown.vim',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require => [ File['pathogen'] ];
  "/home/${me::username}/.vim/python":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/python',
    owner   => $me::username,
    group   => $me::username,
    recurse => true,
    mode    => '0775',
    require => [ File['pathogen'] ];
  }

  # general purpose vim bundles
  # ===========================
  # solarized is the color scheme
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-colors-solarized":
    ensure   => present,
    provider => git,
    user     => $me::username,
    source   => 'git://github.com/altercation/vim-colors-solarized.git',
    require  => File['pathogen'],
  }
  # fugitive.vim is a git client
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-fugitive":
    ensure   => present,
    provider => git,
    user     => $me::username,
    source   => 'git://github.com/tpope/vim-fugitive.git',
    require  => File['pathogen'],
  }
  # UltiSnips
  vcsrepo { "/home/${me::username}/.vim/bundle/ultisnips":
    ensure   => present,
    provider => git,
    user     => $me::username,
    source   => 'git://github.com/SirVer/ultisnips.git',
    require  => File['pathogen'],
  }
  # TagBar
  vcsrepo { "/home/${me::username}/.vim/bundle/tagbar":
    ensure   => present,
    provider => git,
    user     => $me::username,
    source   => 'git://github.com/majutsushi/tagbar.git',
    require  => File['pathogen'],
  }
  # vim powerline
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-ack":
    ensure   => present,
    provider => git,
    user     => $me::username,
    source   => 'git://github.com/mileszs/ack.vim.git',
    require  => File['pathogen'],
  }
  # vim powerline
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-powerline":
    ensure   => present,
    provider => git,
    user     => $me::username,
    source   => 'git://github.com/Lokaltog/vim-powerline.git',
    require  => File['pathogen'],
  }
  # syntastic
  vcsrepo { "/home/${me::username}/.vim/bundle/syntastic":
    ensure   => present,
    provider => git,
    user     => $me::username,
    source   => 'https://github.com/scrooloose/syntastic.git',
    require  => File['pathogen'],
  }
  # vim markdown
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-markdown":
    ensure   => present,
    provider => git,
    user     => $me::username,
    source   => 'git://github.com/tpope/vim-markdown.git',
    require  => File['pathogen'],
  }
}
