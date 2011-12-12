class chili_project::build {
  exec { bundle_install:
    command   => "bundle install --without=mysql mysql2 sqlite postgres rmagick",
    unless    => "bundle check",
    # Add default paths so we can find binaries for building extensions
    path      => "${chili_project::gem_path}:/bin:/usr/bin:/usr/local/bin",
    cwd       => $chili_project::path,
  }
}
