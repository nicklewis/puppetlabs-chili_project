# Class: chili-project
#
# This module manages the Chili Project project management software package.
#
# Parameters:
#   $gem_path:
#     Where to look for gem-installed execuatbles, for tools such as "bundle"
#   $version:
#     What git tag/branch to use after download the Chili Project source. Typically of the form "vX.Y.Z", like "v2.5.0"
#   $path:
#     Where to install chili project. The parent directory is assumed to already exist.
#   $configfile:
#     Path to the chili project configuration file you wish to use.
#   $source_repo:
#     From where to "git clone" the Chili Project source code.
#   $user:
#     User account under which chili should run, and who should own the installation directories
#   $group:
#     Group under which chili should run, and which group should own the installation directories
#   $db_adapter:
#     Current only 'mysql' is supported.
#   $db_user:
#     Username to use when connecting to the database
#   $db_pass:
#     Password to use when connecting to the database
#   $db_name:
#     Database name to use when connecting to the database
#   $db_host:
#     Host on which the databse is running
#   $db_port:
#     Port on which the databse is running
#   $load_default_data:
#     Load the default Chili Project data (default permissions, theme, etc)
#
# Requires:
#   vcsrepo
#   ruby
#   bundle
#
# Sample Usage:
#
# class { 'chili_project':
#   version => 'v2.5.0',
#   path => '/opt/chiliproject',
#   db_adapter => 'mysql',
#   db_pass => 'SooperSekret',
# }
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
