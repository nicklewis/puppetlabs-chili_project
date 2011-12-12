# Class: chili_project::service::unicorn
#
# This module installs and configures the unicorn application server for use with Chili Project.
#
# Parameters:
#   $app_root:
#     Where chili project is installed.
#   $port:
#     Port on which unicorn should listen
#   $gem_path:
#     Where to find the `unicorn_rails` exeecutable
#
# Sample Usage:
#
# class { chili_project::service::unicorn:
#   app_root => '/opt/chiliproject',
# }
#
# [Remember: No empty lines between comments and class definition]
class chili_project::service::unicorn(
  $app_root,
  $port=80,
  $gem_path='/var/lib/gems/1.8/bin'
) {
  # Should we externalize installation of unicorn itself?
  package { unicorn:
    ensure   => present,
    provider => gem,
  }

  file { 'chili init script':
    path    => '/etc/init.d/chili',
    ensure  => present,
    content => template('chili_project/init.erb'),
    owner   => root,
    group   => root,
    mode    => 755,
  }

  service { chili:
    ensure => running,
    hasrestart => true,
    require => [File['chili init script'], Package['unicorn']],
    subscribe => Class[chili_project::build, chili_project::configuration],
  }
}
