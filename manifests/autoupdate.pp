class yum::autoupdate {
  include yum
  package{'yum-cron':
      ensure => present
  }

  # manage this package after all yum repositories
  Package['yum-cron'] <- Yumrepo <||>

  service{'yum-cron':
    enable => true,
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    require => Package['yum-cron'],
  }
}
