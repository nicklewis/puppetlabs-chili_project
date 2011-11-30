class chili_project::step4 {
  file { "${chili_project::path}/config/database.yml":
    ensure => present,
    content => template('chili_project/database.yml.erb'),
  }

  file { "${chili_project::path}/config/configuration.yml":
    ensure => present,
    source => $chili_project::configfile,
  }
}
