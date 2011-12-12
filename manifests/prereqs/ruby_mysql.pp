class chili_project::prereqs::ruby_mysql {
  package { 'libmysql-ruby':
    ensure => present
  }
}

