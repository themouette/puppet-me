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

  file { "${::me::params::home}/.gitconfig":
    content => template('me/dotfiles/gitconfig.erb'),
    owner   => $::me::params::username,
    group   => $::me::params::username,
    mode    => '0755',
    require => Class['me::user'],
  }

  # vim integration
  # ===============

  if $::me::params::vim {

    me::dev::vim::bundle {
      'vim-gitgutter':
        source => 'git://github.com/airblade/vim-gitgutter.git',
        ;
    }
  }
}
