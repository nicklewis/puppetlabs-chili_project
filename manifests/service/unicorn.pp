class chili_project::service::unicorn(
  $app_root,
  $port=80,
  $gem_path='/var/lib/gems/1.8/bin'
) {
  # Should we externalize installation of unicorn itself?
  package { unicorn:
    ensure   => present,
    provider => gem,
  }

  file { 'chili init script':
    path    => '/etc/init.d/chili',
    ensure  => present,
    content => template('chili_project/init.erb'),
    owner   => root,
    group   => root,
    mode    => 755,
  }

  service { chili:
    ensure => running,
    hasrestart => true,
    require => [File['chili init script'], Package['unicorn']],
    subscribe => Class[chili_project::build, chili_project::configuration],
  }
}
