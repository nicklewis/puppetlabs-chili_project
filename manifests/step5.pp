class chili_project::step5 {
  exec { generate_session_store:
    cwd       => $chili_project::path,
    logoutput => true,
    command   => "${chili_project::bundle_executable} exec rake generate_session_store",
    creates   => "${chili_project::path}/config/initializers/session_store.rb",
  }

  exec { db_migrate:
    cwd         => $chili_project::path,
    logoutput   => true,
    environment => 'RAILS_ENV=production',
    command     => "${chili_project::bundle_executable} exec rake db:migrate",
    creates     => "${chili_project::path}/db/schema.rb"
  }

  if $chili_project::load_default_data {
    exec { load_default_data:
      cwd         => $chili_project::path,
      logoutput   => true,
      environment => ['RAILS_ENV=production', 'REDMINE_LANG=en'],
      command     => "${chili_project::bundle_executable} exec rake redmine:load_default_data",
      refreshonly => true,
      subscribe   => Exec[db_migrate],
    }
  }
}
