class yum::repo::epel::debuginfo {
  Class['yum::repo::epel::debuginfo'] <- Class['yum']

  yum::repo{'epel-debuginfo':
    descr => 'Extra Packages for Enterprise Linux $releasever - $basearch - Debug',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch',
    enabled => 1,
    gpgcheck => 1,
    failovermethod => 'priority',
    gpgkey => ${::lsbmajdistrelease} ? {
      5 => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
      6 => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
    },
    priority => 15,
  }
}
