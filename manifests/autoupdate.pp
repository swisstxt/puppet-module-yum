class yum::autoupdate {
  include yum
  package{'yum-cron':
      ensure => present
  } 
  service{'yum-cron':
    enable => true,
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    require => Package['yum-cron'],
  }
}
