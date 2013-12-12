class yum::autoupdate (
  $enable = false,
) {
  Class['yum::autoupdate'] <- Class['yum']

  package { 'yum-cron':
    ensure => present,
  }

  # manage this package after all yum repositories
  Package['yum-cron'] <- Yumrepo <||>

  service { 'yum-cron':
    ensure     => $enable,
    enable     => $enable,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['yum-cron'],
  }
}
