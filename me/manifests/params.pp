# = Class: me::params
#
# This class defines default parameters used by the main module class nodejs.
# Operating Systems differences in names and paths are addressed here.
#
# == Variables:
#
# Refer to me class for the variables defined here.
#
# == Usage:
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes.
#
class me::params {

  # Your username
  $username = 'julien'
  # Your fullname
  $fullname = 'Julien Muetton'
  # Your mail
  $mail = 'themouette@gmail.com'
  # Your password, encrypted for different systems
  $password = $::operatingsystem ? {
    Ubuntu => '$6$G9muOdld$LPD8hUB.3rk7uICJYDQVq2M7QqIafYMea3uCkO1ggwx9E8SHq0gwOQ.sLWE3RYQPW98w84BCi0RF9zL1o7kse1',
    Debian => '$6$TQImyBZz$MpDzn0TA3.pW6TlWakKLmaJgYhq88LrACRfQJGZArKf18dsKzj.OzjxEuj8Kx6EqsSvI5phgZWtXaOBpLefDf0',
  }
  # editor of choice
  $vim = true

  # computed user home
  $home = "/home/${::me::params::username}"
  # Where to store projects
  $projecthome = "${::me::params::home}/Projects"
  # paths for vim
  $vim_home = "${::me::params::home}/.vim"
  $vim_bundle = "${::me::params::vim_home}/bundle"

}
