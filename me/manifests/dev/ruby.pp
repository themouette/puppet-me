# defines ruby development environment
# simply add `include me::dev::ruby` to your manifest

class me::dev::ruby {
  # ruby.vim: bind extra filetypes
  file {
  "/home/${me::username}/.vim/ftplugin/ruby.vim":
    ensure  => present,
    source  => 'ruby:///modules/me/vim/ftplugin/ruby.vim',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/plugin"]
    ;
  }
}
