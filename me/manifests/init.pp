# defines global variables used accross the whole
# configuration.

class me {

  $username = 'julien'
  $fullname = 'Julien Muetton'
  $mail = 'themouette@gmail.com'
  $projecthome = "/home/${username}/Projects"
  $password = $::operatingsystem ? {
    Ubuntu => '$6$G9muOdld$LPD8hUB.3rk7uICJYDQVq2M7QqIafYMea3uCkO1ggwx9E8SHq0gwOQ.sLWE3RYQPW98w84BCi0RF9zL1o7kse1',
    Debian => '$6$TQImyBZz$MpDzn0TA3.pW6TlWakKLmaJgYhq88LrACRfQJGZArKf18dsKzj.OzjxEuj8Kx6EqsSvI5phgZWtXaOBpLefDf0',
  }

  # include user and dev tools
  include me::user, me::dev

  # install fr sources if not already present
  # and dotdeb
  if $::osfamily == 'debian' {
#    apt::source { 'debian':
#      location => 'http://ftp.fr.debian.org/debian',
#      release  => 'stable',
#      repos    => 'main contrib non-free',
#    }
#
#    apt::source { 'dotdeb':
#      location   => 'http://packages.dotdeb.org',
#      release    => 'squeeze-php54',
#      repos      => 'all',
#      key        => '89DF5277',
#      key_server => 'keys.gnupg.net',
#    }
  }
  # aptitude update before any package install
  Exec['apt_update'] -> Package <||>
}

