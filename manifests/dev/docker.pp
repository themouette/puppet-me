class me::dev::docker {
  "/home/${me::username}/.bashrc.d/docker":
    ensure   => present,
    source   => 'puppet:///modules/me/bash/bashrc.d/docker',
    owner    => $::me::params::username,
    group    => $::me::params::username,
    mode     => '0775',
    require => File["/home/${me::username}/.bashrc.d"];
  }
}
