# include the user ssh keys and configuration
class me::user::ssh {

  # create the .ssh directory
  # =========================
  file{ "/home/${me::username}/.ssh":
    ensure  => directory,
    links   => follow,
    owner   => $me::username,
    group   => $me::username,
    mode    => '0700',
    require => User[$me::username],
  }

  # include ssh private keys
  # ========================
  # id_rsa for general purpose
  file{ "/home/${me::username}/.ssh/id_rsa":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/id_rsa',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0400',
    require => File["/home/${me::username}/.ssh"],
  }
  # git_rsa for git purpose
  file{ "/home/${me::username}/.ssh/git_rsa":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/git_rsa',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0400',
    require => File["/home/${me::username}/.ssh"],
  }

  # include public keys
  # ===================
  # id_rsa for general purpose
  file{ "/home/${me::username}/.ssh/id_rsa.pub":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/id_rsa.pub',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => File["/home/${me::username}/.ssh"],
  }
  # git_rsa for git purpose
  file{ "/home/${me::username}/.ssh/git_rsa.pub":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/git_rsa.pub',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => File["/home/${me::username}/.ssh"],
  }

  # authorized keys
  # ===============
  file{ "/home/${me::username}/.ssh/authorized_keys":
    ensure  => present,
    links   => follow,
    source  => 'puppet:///modules/me/ssh/authorized_keys',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => File["/home/${me::username}/.ssh"],
  }

  # known hosts are shared too
  # ==========================
  file{ "/home/${me::username}/.ssh/known_hosts":
    ensure  => present,
    source  => 'puppet:///modules/me/ssh/known_hosts',
    links   => follow,
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => File["/home/${me::username}/.ssh"],
  }

}
