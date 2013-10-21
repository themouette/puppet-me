# configure environment for puppet scripts development
# simply add `include me::dev::puppet` to your manifest

class me::dev::puppet {

  package { 'vim-puppet':
    ensure  => present,
    require => Class['me::dev']
  }

  package { 'puppet-lint':
    ensure   => 'installed',
    provider => 'gem',
  }

  include me::dev
}
