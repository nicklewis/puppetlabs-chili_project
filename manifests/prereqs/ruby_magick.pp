class chili_project::prereqs::ruby_magick {
  package { 'librmagick-ruby':
    ensure => present,
  }
}

