class yum::repo::epel::testing {
  Class['yum::repo::epel::testing'] <- Class['yum']

  yum::repo{'epel-testing':
    descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-epel5&arch=$basearch',
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
