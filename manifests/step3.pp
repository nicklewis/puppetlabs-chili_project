class chili_project::step3 {
  $mysql_cmd = "mysql -D${chili_project::db_name} -P${chili_project::db_port}"
  $mysql_cmd_root = "$mysql_cmd -u${chili_project::db_user} -p${chili_project::db_pass}"
  $mysql_cmd_chili = "$mysql_cmd -uroot"

  $mysqlserver = $operatingsystem ? {
    Ubuntu => mysql-server,
    Debian => mysql-server,
    CentOS => mysql-server,
    default => mysql-server
  }

  $mysqlclient = $operatingsystem ? {
    Ubuntu => mysql-client,
    Debian => mysql-client,
    CentOS => mysql,
    default => mysql
  }

  $mysqlservice = $operatingsystem ? {
    Ubuntu => mysql,
    Debian => mysql,
    CentOS => mysqld,
    default => mysqld
  }

  package { [$mysqlclient, $mysqlserver]: ensure => present }

  service { $mysqlservice:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package[$mysqlserver, $mysqlclient],
  }

  exec { "create_chili_db":
      command => "$mysql_cmd_root -e 'CREATE DATABASE ${chili_project::db_name};'",
      unless  => "mysql -uroot -e 'use ${chili_project::db_name}'",
      path    => "/usr/bin:/usr/sbin:/bin",
      require => Service[$mysqlservice],
      notify  => Exec["grant_chili_db_privileges"];

    "grant_chili_db_privileges":
      command => "$mysql_cmd_root -e \"grant all privileges on ${chili_project::db_name}.* to '${chili_project::db_user}'@'${chili_project::db_host}' identified by '${chili_project::db_pass}'\"",
      unless  => "$mysql_cmd_chili -D${chili_project::db_name}",
      path    => "/usr/bin:/usr/sbin:/bin",
      refreshonly => true,
  }
}
