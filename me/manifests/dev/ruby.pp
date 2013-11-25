# defines ruby development environment
# simply add `include me::dev::ruby` to your manifest

class me::dev::ruby {
  # ruby.vim: bind extra filetypes
  file {
  "/home/${me::username}/.vim/ftplugin/ruby.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/ftplugin/ruby.vim',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/ftplugin"]
    ;
  "/home/${me::username}/.vim/ftdetect/ruby.vim":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/ftdetect/ruby.vim',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/ftdetect"]
    ;
  "/home/${me::username}/.vim/UltiSnips/rspec.snippets":
    ensure  => present,
    source  => 'puppet:///modules/me/vim/UltiSnips/rspec.snippets',
    owner   => $me::username,
    group   => $me::username,
    require => File["/home/${me::username}/.vim/UltiSnips"]
    ;
  }
}
