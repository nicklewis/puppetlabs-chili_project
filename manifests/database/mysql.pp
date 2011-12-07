class chili_project::database::mysql {
  $mysql_cmd = "mysql -h${chili_project::db_host} -P${chili_project::db_port}"
  $mysql_cmd_chili = "$mysql_cmd -u${chili_project::db_user} -p${chili_project::db_pass}"
  $mysql_cmd_root = "$mysql_cmd -uroot"

  exec { "create_db":
      command => "$mysql_cmd_root -e 'CREATE DATABASE ${chili_project::db_name};'",
      unless  => "$mysql_cmd_root -e 'use ${chili_project::db_name}'",
      path    => "/usr/bin:/usr/sbin:/bin",
      notify  => Exec["grant_privileges"],
  }

  exec { "grant_privileges":
      command => "$mysql_cmd_root -e \"grant all privileges on ${chili_project::db_name}.* to '${chili_project::db_user}'@'${chili_project::db_host}' identified by '${chili_project::db_pass}'\"",
      unless  => "$mysql_cmd_chili -D${chili_project::db_name}",
      path    => "/usr/bin:/usr/sbin:/bin",
      refreshonly => true,
  }
}

