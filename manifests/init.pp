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
class chili-project {
  vcsrepo { '/root/chili-project':
    ensure   => present,
    revision => stable,
    source   => 'git://github.com/chiliproject/chiliproject.git',
    provider => git,
  }
}
