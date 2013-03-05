# ensure git client is installed
class me::dev::git {

  include me::dev::vim

  if !defined(Package['git']) {
    $packagename = $::operatingsystem ? {
      Ubuntu => 'git-core',
      Debian => 'git-core',
    }

    package { 'git':
      ensure => present,
      name   => $me::dev::git::packagename,
    }
  }

  file { "/home/${me::username}/.gitconfig":
    content => template('me/dotfiles/gitconfig.erb'),
    owner   => $me::username,
    group   => $me::username,
    mode    => '0755',
    require => Class['me::user'],
  }

  # vim integration
  # ===============
  # git gutter
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-gitgutter":
    ensure   => present,
    provider => git,
    user     => $me::username,
    source   => 'git://github.com/airblade/vim-gitgutter.git',
    require  => File['pathogen'],
  }
}
