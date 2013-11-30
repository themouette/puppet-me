# = Class me::dev::vim::bundle
#
# Install a vim bundle from git.
#
# == Parameters
#
# [*source*]
#   For git repos, the git repo OR null to use github.com/vim-scripts repo id.
#   For archives, the url OR vimscript download id.
#
# [*provider*]
#   git OR tgz OR tar OR zip
#
# [*create_folder*]
#   For archives, sometimes it is up to you to create bundle top folder.
#
# == Example
#
# include me::dev::vim::bundle
#
# me::dev::vim::bundle { 'jshint':
#   $source => 'git://github.com/groenewege/vim-less.git'
# }
#
define me::dev::vim::bundle (
  $source         = undef,
  $provider       = 'git',
  $create_folder  = false,
) {

  include me::params, me::dev::vim
  # the bunde destination.
  $destination = "${me::params::vim_bundle}/${name}"

  if $provider == 'git' {
    # simply clone git repository into destination.
    # If no url is provided, then script is fetched from vim-script.
    $repository = $source ? {
      undef   => "git://github.com/vim-scripts/${name}.git",
      default => $source,
    }

    vcsrepo { $destination:
      ensure   => present,
      provider => git,
      source   => $repository,
      owner    => $::me::params::username,
      group    => $::me::params::username,
      require  => File['pathogen'],
    }
  }
  elsif $provider == 'tar' or $provider == 'tgz' or $provider == 'zip' {

    case $source  {
      undef:      { fail('unable to guess url for ') }
      /^\d*$/:    {
        # this is numeric, so fetch from vim.org
        $base_url = 'http://www.vim.org/scripts/download_script.php'
        $url = "${base_url}?src_id=${source}"
      }
      default:    { $url = $source }
    }

    # Prepend directory createion to command
    # I know, this is horrible... but makes the job.
    if $create_folder {
      $create_cmd = "/bin/mkdir ${name} && cd ${name} && "
    }
    else {
      $create_cmd = ''
    }
    $fullname = "${name}.${provider}"
    $fetch_cmd = "/usr/bin/wget ${url} -O ${fullname}"
    $unpack_cmd = $provider ? {
      /tar|tgz/ => "/bin/tar -xzf ${fullname}",
      'zip'     => "/usr/bin/unzip ${fullname}",
    }
    $rm_cmd = "/bin/rm ${fullname}"
    $cmd = "${create_cmd}${fetch_cmd} && ${unpack_cmd} && ${rm_cmd}"

    exec { $destination:
      creates  => $destination,
      command  => $cmd,
      user     => $::me::params::username,
      group    => $::me::params::username,
      cwd      => $::me::params::vim_bundle,
      require  => [ File['pathogen'], Package['wget'] ],
    }
  }
  else {
    fail("Unknown provider ${provider} for me::dev::vim::bundle")
  }

}
