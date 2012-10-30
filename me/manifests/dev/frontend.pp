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
  package {
  'grunt':
    ensure   => present,
    provider => 'npm',
    require  => [
        Package['npm'], Package['nodejs']
    ];
  'grunt-requirejs':
    ensure   => present,
    provider => 'npm',
    require  => [
        Package['npm'], Package['nodejs'],
        Package['grunt'],
    ];
  'grunt-less':
    ensure   => present,
    provider => 'npm',
    require  => [
        Package['npm'], Package['nodejs'],
        Package['grunt'],
    ];
  }

  # vim configuration
  file {
  "/home/${me::username}/.vim/ftplugin/backbone.vim":
    ensure   => present,
    source   => 'puppet:///me/vim/ftplugin/backbone.vim',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require  => File['pathogen'];
  "/home/${me::username}/.vim/snippets/backbone.snippets":
    ensure   => present,
    source   => 'puppet:///me/vim/snippets/backbone.snippets',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require  => File['pathogen'];
  }
}
