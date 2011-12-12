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
  $gem_path='/var/lib/gems/1.8/bin',
  $version,
  $path,
  $configfile="$path/config/configuration.yml.example",
  $source_repo='git://github.com/chiliproject/chiliproject.git',
  $user='chili',
  $group='chili',
  $db_adapter,
  $db_user='chili',
  $db_pass,
  $db_name='chili_project',
  $db_host='localhost',
  $db_port='3306',
  $load_default_data=true
) {
  include chili_project::media
  include chili_project::build
  include chili_project::configuration
  include chili_project::database
  include chili_project::accounts

  Class[chili_project::media] ->
  Class[chili_project::build] ->
  Class[chili_project::configuration] ->
  Class[chili_project::database] ->
  Class[chili_project::accounts]
}
