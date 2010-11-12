class yum::repo::epel::testing::source {
  include yum

  yum::repo{'epel-testing-source':
    descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch - Source',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-source-epel5&arch=$basearch',
    enabled => 1,
    gpgcheck => 1,
    failovermethod => 'priority',
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    priority => 16,
  }
}
