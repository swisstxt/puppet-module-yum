class yum::repo::epel::source {
  include yum

  yum::repo{'epel-source':
    descr => 'Extra Packages for Enterprise Linux $releasever - $basearch - Source',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-$releasever&arch=$basearch',
    enabled => 1,
    gpgcheck => 1,
    failovermethod => 'priority',
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    priority => 15,
  }
}
