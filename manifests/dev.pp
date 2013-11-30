# defines the dev base classes.
# different tools are defines in the dev subnamespace
# but none is included by default.

class me::dev {
  include me::dev::git, me::misc

  if $::me::params::vim {
    include me::dev::vim
  }

}

