# = Class me::dev::frontend::jshint
#
# Install jshint and vim integration
#
# == Parameters
#
# N/A
#
# == Example
#
# include me::dev::frontend::jshint
#
# class { 'me::dev::frontend::jshint': }
#
class me::dev::frontend::jshint {

  include me::params

  package {
    'jshint':
      ensure   => present,
      provider => 'npm',
      require  => [
          Class['nodejs'],
      ];
  }

  if $::me::params::vim {

    # install vim bindings
    me::dev::vim::bundle{'jshint':
      source => 'git://github.com/walm/jshint.vim.git'
    }

  }
}
