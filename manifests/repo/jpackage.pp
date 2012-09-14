class yum::repo::jpackage {
  Class['yum::repo::jpackage'] <- Class['yum']

  yum::repo{'jpackage-generic':
    descr => 'JPackage (free), generic',
    mirrorlist => 'http://www.jpackage.org/jpackage_generic_1.7.txt',
    failovermethod => 'priority',
    enabled => 1,
    priority => 1,
    gpgcheck => 1,
    gpgkey => 'http://www.jpackage.org/jpackage.asc',
  }
  yum::repo{'jpackage-rhel':
    descr => 'JPackage (free) for Red Hat Enterprise Linux $releasever',
    mirrorlist => "http://www.jpackage.org/jpackage_rhel-${lsbmajdistrelease}_1.7.txt",
    failovermethod => 'priority',
    enabled => 1,
    priority => 1,
    gpgcheck => 1,
    gpgkey => 'http://www.jpackage.org/jpackage.asc',
  }
  yum::repo{'jpackage-generic-nonfree':
    descr => 'JPackage (non-free), generic',
    mirrorlist => 'http://www.jpackage.org/jpackage_generic_nonfree_1.7.txt',
    failovermethod => 'priority',
    enabled => 1,
    priority => 1,
    gpgcheck => 1,
    gpgkey => 'http://www.jpackage.org/jpackage.asc',
  }
}
