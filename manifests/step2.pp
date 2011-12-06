class chili_project::step2 {
  Package[bundler] -> Exec[bundle_install]

# Step 2 install gems with bundler
  package { ['librmagick-ruby', 'libmysql-ruby']:
    ensure => present,
  }

  package { bundler:
    ensure => present,
    provider => gem,
  }

  exec { bundle_install:
    command   => "bundle install --without=mysql mysql2 sqlite postgres rmagick",
    unless    => "bundle check",
    # Add default paths so we can find binaries for building extensions
    path      => "${chili_project::gem_path}:/bin:/usr/bin:/usr/local/bin",
    cwd       => $chili_project::path,
  }
}
