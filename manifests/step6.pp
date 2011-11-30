class chili_project::step6 {
  user { 'chili':
    ensure => present,
    gid => 'chili',
  }

  group { 'chili':
    ensure => present,
  }

  file { ["${chili_project::path}/files",
          "${chili_project::path}/log",
          "${chili_project::path}/public/plugin_assets",
          "${chili_project::path}/tmp",
          ]:
    ensure  => directory,
    owner   => chili,
    group   => chili,
    recurse => true,
    mode    => 644,
  }
}
