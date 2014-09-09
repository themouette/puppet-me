# = Class me::dev::perl
#
# == Parameters
#
# [**]
#   description.
#
# == Example
#
# include me::dev::perl
#
# class { 'me::dev::perl':
#    => undef
# }
#
class me::dev::perl {
  me::dev::vim::bundle {
    'vim-perl':
        provider  => 'git',
        source    => 'https://github.com/vim-perl/vim-perl.git'
  }
}
