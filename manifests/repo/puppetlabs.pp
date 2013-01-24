class yum::repo::puppetlabs {
  Class['yum::repo::puppetlabs'] <- Class['yum']

  yum::repo{'puppetlabs-products':
    descr => 'Puppet Labs Products El 6 - $basearch',
    baseurl => 'http://yum.puppetlabs.com/el/6/products/$basearch',
    enabled => 1,
    gpgcheck => 1,
    failovermethod => 'priority',
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    priority => 10,
  }
  yum::repo{'puppetlabs-deps':
    descr => 'Puppet Labs Dependencies El 6 - $basearch',
    baseurl => 'http://yum.puppetlabs.com/el/6/dependencies/$basearch',
    enabled => 1,
    gpgcheck => 1,
    failovermethod => 'priority',
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    priority => 10,
  }
}
