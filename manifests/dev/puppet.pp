# configure environment for puppet scripts development
# simply add `include me::dev::puppet` to your manifest

class me::dev::puppet {

  include me::params
  include me::dev
  include me::dev::ruby

  file {
  "/home/${me::username}/.puppet/module":
    ensure  => directory,
    owner   => $me::username,
    group   => $me::username,
    recurse => true,
  }

  package {
  'puppet-lint':
    ensure   => 'installed',
    provider => 'gem',
    ;
  'ruby-full':
    ensure   => 'installed',
    ;
  'libxslt-dev':
    ensure   => 'installed',
    ;
  }

  if $::me::params::vim {
    me::dev::vim::file {
      # puppet.vim: bind extra filetypes
      'ftplugin/puppet.vim': ;
      'UltiSnips/puppet.snippets': ;
    }

    me::dev::vim::bundle {
      # puppet syntax highlight
      'vim-puppet':
        source => 'git://github.com/rodjek/vim-puppet.git',
        ;
    }
  }
}
