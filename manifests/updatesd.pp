class yum::updatesd {
  include yum
  package{'yum-updatesd':
    ensure => present,
  }

  # manage this package after all yum repositories
  Package['yum-updatesd'] <- Yumrepo <||>

  service{'yum-updatesd':
    ensure => running,
    enable => true,
    require => Package['yum-updatesd'],
  }
}
