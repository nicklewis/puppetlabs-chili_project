class chili_project::prereqs::bundler {
  package { bundler:
    ensure   => present,
    provider => gem,
    before => Class[chili_project::build],
  }
}

