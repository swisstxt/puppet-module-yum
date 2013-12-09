class yum::autoupdate (
    $autoupdateenabled = false
  ){
  Class['yum::autoupdate'] <- Class['yum']

  package{'yum-cron':
      ensure => present
  }

  # manage this package after all yum repositories
  Package['yum-cron'] <- Yumrepo <||>

  service{'yum-cron':
    enable => $autoupdateenabled,
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    require => Package['yum-cron'],
  }
}
