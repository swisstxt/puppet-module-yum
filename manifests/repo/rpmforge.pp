class yum::repo::rpmforge(
  $priority = 30,
  $includepkgs = 'absent'
) {
  include yum

  yum::repo{'rpmforge':
    descr => 'RPMForge RHEL5 packages',
    baseurl => 'http://wftp.tu-chemnitz.de/pub/linux/dag/redhat/el$releasever/en/$basearch/dag',
    enabled => 1,
    priority => $priority,
    gpgcheck => 1,
    includepkgs => $includepkgs,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
  }
}
