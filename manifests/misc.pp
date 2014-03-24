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
  # Server monitoring
  #
  # @see http://aarvik.dk/four-linux-server-monitoring-and-management-tools/
  if !defined(Package['htop']) {
    package{ 'htop':
      ensure => present
    }
  }
  if !defined(Package['iotop']) {
    package{ 'iotop':
      ensure => present
    }
  }
  if !defined(Package['glances']) {
    package{ 'glances':
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
    file {"/home/${me::username}/.tmux.conf":
        ensure => present,
        source  => 'puppet:///modules/me/dotfiles/tmux.conf',
        owner   => $me::username,
        group   => $me::username,
        mode    => '0775',
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
  package {'localtunnel':
    ensure   => present,
    provider => 'gem'
  }
}
