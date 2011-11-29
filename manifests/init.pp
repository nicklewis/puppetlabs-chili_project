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
class chili_project(
  $bundle_executable='/usr/bin/bundle',
  $version,
  $path,
  $configfile="$path/config/configuration.yml.example"
) {
  Class[chili_project::step1] ->
  Class[chili_project::step2] ->
  Class[chili_project::step3] ->
  Class[chili_project::step4]

  include chili_project::step1
  include chili_project::step2
  include chili_project::step3
  include chili_project::step4
}
