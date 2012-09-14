class yum::repo::karan($priority = 20) {
  Class['yum::repo::karan'] <- Class['yum']

  yum::repo{'kbs-CentOS-Extras':
    descr => 'CentOS.Karan.Org-EL$releasever - Stable',
    baseurl => 'http://centos.karan.org/el$releasever/extras/stable/$basearch/RPMS/',
    enabled => 1,
    gpgcheck => 1,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
    priority => $priority,
  }
  yum::repo{'kbs-CentOS-Extras-Testing':
    descr => 'CentOS.Karan.Org-EL$releasever - Testing',
    baseurl => 'http://centos.karan.org/el$releasever/extras/testing/$basearch/RPMS/',
    enabled => 0,
    gpgcheck => 1,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
    priority => $priority,,
  }
  yum::repo{'kbs-CentOS-Misc':
    descr => 'CentOS.Karan.Org-EL$releasever - Stable',
    baseurl => 'http://centos.karan.org/el$releasever/misc/stable/$basearch/RPMS/',
    enabled => 1,
    gpgcheck => 1,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
    priority => $priority,
  }
  yum::repo{'kbs-CentOS-Misc-Testing':
    descr => 'CentOS.Karan.Org-EL$releasever - Testing',
    baseurl => 'http://centos.karan.org/el$releasever/misc/testing/$basearch/RPMS/',
    enabled => 0,
    gpgcheck => 1,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-kbsingh',
    priority => $priority,
  }
}
