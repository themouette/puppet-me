# = Class me::dev::python
#
# Install python tools.
# see https://github.com/themouette/puppet-me/blob/master/me/doc/python.markdown
#
# == Parameters
#
# N/A
#
# == Example
#
# include me::dev::python
#
# class { 'me::dev::python': }
#
class me::dev::python {

  include wget

  # install pythoncomplete
  $scripturl = 'http://www.vim.org/scripts/download_script.php?src_id=10872'
  wget::fetch {'pythoncomplete':
    source      => $scripturl,
    destination => "/home/${me::username}/.vim/autoload/pythoncomplet.vim",
    require     => File['pathogen']
  }

  file {
    "/home/${me::username}/.vim/ftplugin/python.vim":
      ensure  => present,
      source  => 'puppet:///modules/me/vim/ftplugin/python.vim',
      owner   => $me::username,
      group   => $me::username,
      mode    => '0775',
      require => [ File['pathogen'] ];
  }

}
