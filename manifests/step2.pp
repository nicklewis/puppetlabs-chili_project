class chili_project::step2 {
  Package[bundler] -> Exec[bundle_install]

# Step 2 install gems with bundler
  package { bundler:
    ensure => present,
    provider => gem,
  }

  package { 'librmagick-ruby':
    ensure => present,
  }

  exec { bundle_install:
    cwd       => $chili_project::path,
    logoutput => true,
    unless    => "${chili_project::bundle_executable} check",
    command   => "${chili_project::bundle_executable} install --without=mysql mysql2 sqlite postgres rmagick",
  }
}
