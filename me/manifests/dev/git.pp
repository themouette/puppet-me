# ensure git client is installed
class me::dev::git {
  $packagename = $::operatingsystem ? {
    Ubuntu => 'git',
    Debian => 'git-core',
  }

  package { 'git':
    ensure => present,
    name   => $me::dev::git::packagename,
  }

  file { "/home/${me::username}/.gitconfig":
    content => template('me/dotfiles/gitconfig.erb'),
    owner  => $me::username,
    group  => $me::username,
    mode   => '0755',
    require => Class['me::user'],
  }
}
