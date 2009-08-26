class yum::centos::testing {
    yum::managed_yumrepo{testing:
        descr => 'CentOS-$releasever - Testing',
        baseurl => 'http://dev.centos.org/centos/$releasever/testing/$basearch',
        enabled => 1,
        gpgcheck => 1,
        gpgkey => 'http://dev.centos.org/centos/RPM-GPG-KEY-CentOS-testing',
        priority => 3,
    }
}
