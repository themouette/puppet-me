# Install vim-tern
# Vim tern is a syntax analisys plugin that should enable auto complete.

class me::dev::vim::tern {

  # pathogen repositories
  # =====================
  # tern for vim https://github.com/marijnh/tern_for_vim

  vcsrepo { "/home/${me::username}/.vim/bundle/tern_for_vim":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/marijnh/tern_for_vim.git',
    owner    => $me::username,
    group    => $me::username,
    require  => File['pathogen'],
  }

  # install the extension
  # =====================
  
  exec { 'install-tern-for-vim':
    command => "npm install",
    creates => "/home/${me::username}/.vim/bundle/tern_for_vim/node_modules",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    cwd     => "/home/${me::username}/.vim/bundle/tern_for_vim",
    user    => $me::username,
    timeout => 0,
    require => [Vcsrepo["/home/${me::username}/.vim/bundle/tern_for_vim"], Class['nodejs']]
  }

}
