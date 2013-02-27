# install miscelaneous tools

class me::misc {
  package { 'tree':
    ensure => present,
  }

  # for command output color
  if !defined(Package['grc']) {
    package{ 'grc':
      ensure => present
    }
  }
  if !defined(Package['htop']) {
    package{ 'htop':
      ensure => present
    }
  }
  if !defined(Package['ncmpc']) {
    package{ 'ncmpc':
      ensure => present
    }
  }
  if !defined(Package['wget']) {
    package{ 'wget':
      ensure => present
    }
  }
  if !defined(Package['curl']) {
    package{ 'curl':
      ensure => present
    }
  }
  if !defined(Package['elinks']) {
    package{ 'elinks':
      ensure => present
    }
  }
  if !defined(Package['tmux']) {
    package{ 'tmux':
      ensure => present
    }
  }

  # to convert image to ascii
  if !defined(Package['jp2a']) {
    package{ 'jp2a':
      ensure => present
    }
  }
  if !defined(Package['ack-grep']) {
    package{ 'ack-grep':
      ensure => present
    }
  }
  if !defined(Package['pandoc']) {
    package{ 'pandoc':
      ensure => present
    }
  }
}
