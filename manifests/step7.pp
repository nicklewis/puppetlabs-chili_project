class chili_project::step7 {
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
    require => [File['chili init script'], Package['unicorn']],
  }
}
