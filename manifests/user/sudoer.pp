# add user to sudoers
class me::user::sudoer {
  $packagename = $::operatingsystem ? {
    /(Ubuntu|Debian)/ => 'sudo',
  }

  package { 'sudo':
    ensure => present,
    name   => $me::user::sudoer::packagename,
  }

  file { 'sudoer.d':
    ensure => directory,
    path   => '/etc/sudoer.d',
    owner  => 'root',
    group  => 'root',
    mode   => '0440',
  }

  file { "/etc/sudoers.d/${me::username}":
    content => template('me/sudoers.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    require => [ Class['me::user'], File['sudoer.d'] ]
  }
}

