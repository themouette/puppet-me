# configure environment for puppet scripts development
# simply add `include me::dev::puppet` to your manifest

class me::dev::puppet {

  # puppet syntax highlight
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-puppet":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/rodjek/vim-puppet.git',
    owner    => $me::username,
    group    => $me::username,
    require  => File['pathogen'],
  }

  # puppet.vim: bind extra filetypes
  file { "/home/${me::username}/.vim/ftplugin/puppet.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/ftplugin/puppet.vim',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/plugin"]
  }

  package { 'puppet-lint':
    ensure   => 'installed',
    provider => 'gem',
  }

  include me::dev
}
