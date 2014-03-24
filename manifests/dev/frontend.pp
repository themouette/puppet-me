# include all required tools for frontend development

class me::dev::frontend {

  include me::params
  include me::dev::vim

  class { 'nodejs': }
  # extra configuration
  file {
  "/home/${me::username}/.npmrc":
    ensure   => present,
    source   => 'puppet:///modules/me/dotfiles/.npmrc',
    owner    => $::me::params::username,
    group    => $::me::params::username,
    mode     => '0775',
  }

  include me::dev::frontend::jshint

  if $::me::params::vim {

    me::dev::vim::snippets {
      'backbone': ;
      'qunit': ;
      'html': ;
      'javascript': ;
    }
    me::dev::vim::file {
      'ftdetect/javascript.vim': ;
      'ftplugin/javascript.vim': ;
      'plugin/frontend.vim': ;
    }
    me::dev::vim::bundle{
      # javascript syntax
      'vim-javascript-syntax':
        source  => 'git://github.com/jelera/vim-javascript-syntax.git',
        ;
      # less syntax highlight
      'vim-less':
        source  => 'git://github.com/groenewege/vim-less.git',
        ;
      # zen-coding allow quick html coding
      # zen-coding became emet
      # http://www.vim.org/scripts/download_script.php?src_id=21081
      'vim-emmet':
        #source => https://github.com/mattn/emmet-vim.git
        source        => 21081,
        provider      => 'zip',
        create_folder => true,
        ;
      # javascript indent
      # http://www.vim.org/scripts/script.php?script_id=3081
      'web-indent':
        provider  => 'tgz',
        source    => '15643',
    }
  }

}
