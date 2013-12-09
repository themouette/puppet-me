# include the user ssh keys and configuration
class me::user::ssh {

  include me::params

  # create the .ssh directory
  # =========================
  file{ "${::me::params::home}/.ssh":
    ensure  => directory,
    links   => follow,
    owner   => $::me::params::username,
    group   => $::me::params::username,
    mode    => '0700',
    require => User[$::me::params::username],
  }

  # include ssh private keys
  # ========================
  # id_rsa for general purpose
  file{ "${::me::params::home}/.ssh/id_rsa":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/id_rsa',
    owner   => $::me::params::username,
    group   => $::me::params::username,
    mode    => '0400',
    require => File["${::me::params::home}/.ssh"],
  }
  # git_rsa for git purpose
  file{ "${::me::params::home}/.ssh/git_rsa":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/git_rsa',
    owner   => $::me::params::username,
    group   => $::me::params::username,
    mode    => '0400',
    require => File["${::me::params::home}/.ssh"],
  }

  # include public keys
  # ===================
  # id_rsa for general purpose
  file{ "${::me::params::home}/.ssh/id_rsa.pub":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/id_rsa.pub',
    owner   => $::me::params::username,
    group   => $::me::params::username,
    mode    => '0644',
    require => File["${::me::params::home}/.ssh"],
  }
  # git_rsa for git purpose
  file{ "${::me::params::home}/.ssh/git_rsa.pub":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/git_rsa.pub',
    owner   => $::me::params::username,
    group   => $::me::params::username,
    mode    => '0644',
    require => File["${::me::params::home}/.ssh"],
  }

  # known hosts are shared too
  # ==========================
  file{ "${::me::params::home}/.ssh/config":
    ensure  => present,
    source  => 'puppet:///modules/me/ssh/config',
    replace => no,
    links   => follow,
    owner   => $::me::params::username,
    group   => $::me::params::username,
    mode    => '0644',
    require => File["${::me::params::home}/.ssh"],
  }

  # known hosts are shared too
  # ==========================
  file{ "${::me::params::home}/.ssh/authorized_keys":
    ensure  => present,
    source  => 'puppet:///modules/me/ssh/id_rsa.pub',
    replace => no,
    links   => follow,
    owner   => $::me::params::username,
    group   => $::me::params::username,
    mode    => '0644',
    require => File["${::me::params::home}/.ssh"],
  }

}
