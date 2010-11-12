class yum::repo::epel::testing {
  include yum

  yum::repo{'epel-testing':
    descr => 'Extra Packages for Enterprise Linux $releasever - Testing - $basearch',
    mirrorlist => 'http://mirrors.fedoraproject.org/mirrorlist?repo=testing-epel5&arch=$basearch',
    enabled => 1,
    gpgcheck => 1,
    failovermethod => 'priority',
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    priority => 16,
  }
}
