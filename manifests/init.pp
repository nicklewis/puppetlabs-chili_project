# Class: chili-project
#
# This module manages chili-project
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class chili-project($bundle_executable='/usr/bin/bundle', $version) {
  Package[bundler] -> Exec[bundle_install]
  Vcsrepo[chili_source] -> Exec[bundle_install]

# Step 1 clone source
  vcsrepo { chili_source:
    ensure   => present,
    path     => '/root/chili-project',
    revision => $version,
    source   => 'git://github.com/chiliproject/chiliproject.git',
    provider => git,
  }

# Step 2 install gems with bundler
  package { bundler:
    ensure => present,
    provider => gem,
  }

  package { 'librmagick-ruby':
    ensure => present,
  }

  exec { bundle_install:
    logoutput => true,
    unless => "$bundle_executable check",
    command => "$bundle_executable install --without=mysql mysql2 sqlite postgres rmagick",
  }
}
