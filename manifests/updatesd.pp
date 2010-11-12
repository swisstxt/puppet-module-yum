class yum::updatesd {
  include yum
  package{'yum-updatesd':
    ensure => present,
  }
  service{'yum-updatesd':
    ensure => running,
    enable => true,
    require => Package['yum-updatesd'],
  }
}
