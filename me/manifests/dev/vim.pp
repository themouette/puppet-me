# ensure vim installed with pathogen and other stuff
class me::dev::vim {
  $packagename = $::operatingsystem ? {
      /(Ubuntu|Debian)/ => 'vim-nox',
  }

  package { 'vim-nox':
    ensure => present,
    name   => $me::dev::vim::packagename,
  }

  file { "/home/${me::username}/.vimrc":
    source   => 'puppet:///modules/me/dotfiles/vimrc',
    require => Class['me::user'],
  }
}
