class yum::repo::epel {
  Class['yum::repo::epel'] <- Class['yum']

  yum::repo{'epel':
    descr => 'Extra Packages for Enterprise Linux $releasever - $basearch',
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
