class yum::repo::dist::testing($priority = 1) {
  Class['yum::repo::dist::testing'] <- Class['yum']

  yum::repo{'centos-testing':
    descr => 'CentOS-$releasever - Testing',
    baseurl => 'http://dev.centos.org/centos/$releasever/testing/$basearch',
    enabled => 1,
    priority => $priority,
    gpgcheck => 1,
    gpgkey => 'http://dev.centos.org/centos/RPM-GPG-KEY-CentOS-testing',
  }
}
