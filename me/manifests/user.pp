# create the user and add it to sudoer

class me::user {
  user { $me::username:
    ensure     => present,
    shell      => '/bin/bash',
    managehome => true,
    password   => $me::password
  }

  file {
  "/home/${me::username}/.bash_logout":
    source => 'puppet:///modules/me/bash/bash_logout',
    owner  => $me::username,
    group  => $me::username,
    mode   => '0755';
  "/home/${me::username}/.bashrc":
    source => 'puppet:///modules/me/bash/bashrc',
    owner  => $me::username,
    group  => $me::username,
    mode   => '0755';
  "/home/${me::username}/.bash_aliases":
    source => 'puppet:///modules/me/bash/bash_aliases',
    owner  => $me::username,
    group  => $me::username,
    mode   => '0755';
  "/home/${me::username}/.bash_completion":
    source => 'puppet:///modules/me/bash/bash_completion',
    owner  => $me::username,
    group  => $me::username,
    mode   => '0755';
  "/home/${me::username}/.bash_functions":
    source => 'puppet:///modules/me/bash/bash_functions',
    owner  => $me::username,
    group  => $me::username,
    mode   => '0755';
  "/home/${me::username}/.bash_prompt":
    source => 'puppet:///modules/me/bash/bash_prompt',
    owner  => $me::username,
    group  => $me::username,
    mode   => '0755';
  "/home/${me::username}/.ackrc":
    source => 'puppet:///modules/me/ackrc',
    owner  => $me::username,
    group  => $me::username,
    mode   => '0755';
  "${me::projecthome}":
    ensure => directory,
    owner  => $me::username,
    group  => $me::username,
    mode   => '0644';
  }

  include me::user::sudoer, me::user::ssh
}
