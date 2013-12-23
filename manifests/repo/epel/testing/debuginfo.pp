class yum::repo::epel::testing::debuginfo {
  Class['yum::repo::epel::testing::debuginfo'] <- Class['yum']

  yum::repo{'epel-testing-debuginfo':
    descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Debug',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-debug-epel5&arch=$basearch',
    enabled => 1,
    gpgcheck => 1,
    failovermethod => 'priority',
    gpgkey => $::lsbmajdistrelease ? {
      5 => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
      6 => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
    },
    priority => 16,
  }
}
