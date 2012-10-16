# install miscelaneous tools

class me::misc {
  package { 'tree':
    ensure => present,
  }

  # for command output color
  package { 'grc':
    ensure => present,
  }

  package { 'htop':
    ensure => present,
  }

  package { 'ncmpc':
    ensure => present,
  }

  package { 'wget':
    ensure => present,
  }

  package { 'curl':
    ensure => present,
  }

  # to convert image to ascii
  package { 'jp2a':
    ensure => present,
  }
}
