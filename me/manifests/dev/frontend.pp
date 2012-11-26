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
  file { '/usr/bin/node':
    ensure  => symlink,
    target  => '/usr/bin/nodejs',
    require => Class['nodejs'],
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
  'jshint':
    ensure   => present,
    provider => 'npm',
    require  => [
        Package['npm'], Package['nodejs'],
    ];
  }

  # vim configuration
  file {
  "/home/${me::username}/.vim/ftplugin/backbone.vim":
    ensure   => present,
    source   => 'puppet:///modules/me/vim/ftplugin/backbone.vim',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require  => File['pathogen'];
  "/home/${me::username}/.vim/snippets/backbone.snippets":
    ensure   => present,
    source   => 'puppet:///modules/me/vim/snippets/backbone.snippets',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require  => File['pathogen'];
  "/home/${me::username}/.vim/snippets/qunit.snippets":
    ensure   => present,
    source   => 'puppet:///modules/me/vim/snippets/qunit.snippets',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require  => File['pathogen'];
  "/home/${me::username}/.vim/ftdetect/javascript.vim":
    ensure   => present,
    source   => 'puppet:///modules/me/vim/ftdetect/javascript.vim',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require  => File['pathogen'];
  "/home/${me::username}/.vim/ftplugin/javascript.vim":
    ensure   => present,
    source   => 'puppet:///modules/me/vim/ftplugin/javascript.vim',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require  => File['pathogen'];
  "/home/${me::username}/.vim/autoload/javascript.vim":
    ensure   => present,
    source   => 'puppet:///modules/me/vim/autoload/javascript.vim',
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require  => File['pathogen'];
  }

  # install closure linter
  #exec {'closure-linter':
  #  command => '/usr/local/bin/easy_install http://closure-linter.googlecode.com/files/closure_linter-latest.tar.gz',
  #  user    => 'root',
  #  group   => 'root',
  #  cwd     => '/tmp',
  #  creates => '/usr/local/bin/gjslint',
  #}

  # install jsctags

  vcsrepo { "/opt/jsdoctor":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/mozilla/doctorjs.git',
    owner    => $me::username,
    group    => $me::username,
    require  => Package['git'],
  }
  exec { 'jsctags':
    command => '/usr/bin/make install',
    cwd     => '/opt/jsdoctor',
    creates => '/usr/local/bin/jsctags',
    require => [Vcsrepo['/opt/jsdoctor'], Class['nodejs']]
  }

  # pathogen repositories
  # =====================
  # jshint
  vcsrepo { "/home/${me::username}/.vim/bundle/jshint":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/walm/jshint.vim.git',
    owner    => $me::username,
    group    => $me::username,
    require  => File['pathogen'],
  }
  # javascript syntax
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-javascript-syntax":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/jelera/vim-javascript-syntax.git',
    owner    => $me::username,
    group    => $me::username,
    require  => File['pathogen'],
  }
  # javascript indent
  # http://www.vim.org/scripts/script.php?script_id=3081
  exec { "/home/${me::username}/.vim/bundle/web-indent":
    creates  => "/home/${me::username}/.vim/bundle/web-indent/test.html",
    command  => '/usr/bin/wget http://www.vim.org/scripts/download_script.php?src_id=15643 -O web-indent.tgz && /bin/tar -xzf web-indent.tgz && rm web-indent.tgz',
    user     => $me::username,
    group    => $me::username,
    cwd      => "/home/${me::username}/.vim/bundle/",
    require  => [ File['pathogen'], Package['wget'] ],
  }
  # lesscss syntax
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-less":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/groenewege/vim-less.git',
    owner    => $me::username,
    group    => $me::username,
    require  => File['pathogen'],
  }
}
