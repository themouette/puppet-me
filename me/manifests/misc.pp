# install miscelaneous tools

class me::misc {
  package { 'tree':
    ensure => present,
  }

  # for command output color
  package {
  'grc':
    ensure => present;
  'htop':
    ensure => present;
  'ncmpc':
    ensure => present;
  'wget':
    ensure => present;
  'curl':
    ensure => present;
  'elinks':
    ensure => present;
  }

  # to convert image to ascii
  package {
  'jp2a':
    ensure => present;
  'ack-grep':
    ensure => present;
  }
}
