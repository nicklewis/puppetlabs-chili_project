class chili_project::step3 {
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
      path    => "/usr/bin:/usr/sbin:/bin",
      command => "mysql -uroot -e 'CREATE DATABASE chiliproject;'",
      unless  => "mysql -uroot -e 'use chiliproject'",
      notify  => Exec["grant_chili_db_privileges"],
      logoutput => true,
      require => [ 
        Service[$mysqlservice], 
      ];

    "grant_chili_db_privileges":
      path    => "/usr/bin:/usr/sbin:/bin",
      command => "mysql -uroot -e \"grant all privileges on chiliproject.* to 'chili'@'localhost' identified by 'chili'\"",
      unless  => "mysql -uchili -pchili -Dchili_project -hlocalhost",
      logoutput => true,
      refreshonly => true;
  }
}
