class yum::repo::dist {
  $priority = 1
  include yum
  yum::repo{'centos-base':
    descr => 'CentOS-$releasever - Base',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os',
    enabled => 1,
    priority => $priority,
    gpgcheck => 1,
    gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever",
  }
  yum::repo{'centos-updates':
    descr => 'CentOS-$releasever - Updates',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates',
    enabled => 1,
    priority => $priority,
    gpgcheck => 1,
    gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever",
  }
  yum::repo{'centos-addons':
    descr => 'CentOS-$releasever - Addons',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=addons',
    enabled => 0,
    priority => $priority,
    gpgcheck => 1,
    gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever",
  }
  yum::repo{'centos-extras':
    descr => 'CentOS-$releasever - Extras',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras',
    enabled => 0,
    priority => $priority,
    gpgcheck => 1,
    gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever",
  }
  yum::repo{'centos-centosplus':
    descr => 'CentOS-$releasever - Centosplus',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
    enabled => 0,
    priority => $priority,
    gpgcheck => 1,
    gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever",
  }
  yum::repo{'centos-contrib':
    descr => 'CentOS-$releasever - Contrib',
    mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib',
    enabled => 0,
    priority => $priority,
    gpgcheck => 1,
    gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-$releasever",
  }
}
