# include all required tools for frontend development

class me::dev::frontend {

  # debian 6 requires aptitude changes
  # https://github.com/puppetlabs/puppetlabs-nodejs#class-nodejs
  if $::operatingsystem == 'Debian' {
    case $::operatingsystemrelease {
      /^6/: {
        $dev=true
      }
      default: {
        $dev=false
      }
    }
  }

  class { 'nodejs':
    dev_package => $dev
  }

  # a bunch of tools required
  package {'grunt':
    ensure   => present,
    provider => 'npm',
    require  => [
        Package['npm'], Package['nodejs']
    ] ,
  }
  package {'grunt-requirejs':
    ensure   => present,
    provider => 'npm',
    require  => [
        Package['npm'], Package['nodejs'],
        Package['grunt'],
    ] ,
  }
  package {'grunt-less':
    ensure   => present,
    provider => 'npm',
    require  => [
        Package['npm'], Package['nodejs'],
        Package['grunt'],
    ] ,
  }
}
