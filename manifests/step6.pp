class chili_project::step6 {
  user { $chili_project::user:
    ensure => present,
    gid => $chili_project::group,
  }

  group { $chili_project::group:
    ensure => present,
  }

  file { ["${chili_project::path}/files",
          "${chili_project::path}/log",
          "${chili_project::path}/public/plugin_assets",
          "${chili_project::path}/tmp",
          ]:
    ensure  => directory,
    owner   => $chili_project::user,
    group   => $chili_project::group,
    recurse => true,
    mode    => 644,
  }
}
