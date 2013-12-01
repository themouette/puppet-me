# = Resource me::dev::vim::file ()
#
# Include a vim file.
# File is included from module.
#
# == Parameters
#
# N/A
#
# == Example
#
# me::dev::vim::file {'ftdetec/javascript.vim': }
#
define me::dev::vim::file (
  $provider = 'file',
  $source   = undef,
) {

  $_filename = "${::me::params::vim_home}/${name}"

  case $provider {

    'file': {

        $_source   = $source ? {
          undef   => "puppet:///modules/me/vim/${name}",
          default => $source,
        }

        file{ $_filename :
          ensure   => present,
          source   => $_source,
          owner    => $::me::params::username,
          group    => $::me::params::username,
          mode     => '0775',
          require  => File['pathogen'];
        }
      }
    'template': {

        $content  = $source ? {
          undef   => template("me/vim/${name}.erb"),
          default => $source,
        }

        file{ $_filename :
            ensure  => present,
            content => $content,
            owner   => $me::params::username,
            group   => $me::params::username,
            mode    => '0775',
            require => [ File['pathogen'] ];

        }
      }

      default: { fail("Unknown provider ${provider} for me::dev::vim::file") }
  }
}
