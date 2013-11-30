# defines global variables used accross the whole
# configuration.

class me {

  include me::params

  # This is a legacy copy.
  $username = $me::params::username
  $fullname = $me::params::fullname
  $mail     = $me::params::mail
  $projecthome = $me::params::projecthome
  $password = $me::params::password

  # include user and dev tools
  include me::user, me::dev, apt

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

