class yum::autoupdate (
    $enabled = false
  ){
  Class['yum::autoupdate'] <- Class['yum']

  package{'yum-cron':
      ensure => present
  }

  # manage this package after all yum repositories
  Package['yum-cron'] <- Yumrepo <||>

  service{'yum-cron':
    enable => $enabled,
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    require => Package['yum-cron'],
  }
}
