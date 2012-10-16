# configure environment for puppet scripts development
# simply add `include me::dev::pupet` to your manifest

class me::dev::puppet {

  package { 'vim-puppet':
    ensure  => present,
    require => Class['me::dev']
  }

  package { 'puppet-lint':
    ensure   => 'installed',
    provider => 'gem',
  }

  require => Class['me::dev'],
}
