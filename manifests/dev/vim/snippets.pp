# = Resource me::dev::vim::snippets
#
# Include a new snippet file.
#
# == Example
#
# me::dev::vim::snippets{ 'backbone': }
#
define me::dev::vim::snippets {

  file {
  # vim configuration
  "${::me::params::home}/.vim/UltiSnips/${name}.snippets":
    ensure   => present,
    source   => "puppet:///modules/me/vim/UltiSnips/${name}.snippets",
    owner    => $::me::params::username,
    group    => $::me::params::username,
    mode     => '0775',
    require  => File['pathogen'];
  }
}
