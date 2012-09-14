class yum::repo::rpmforge(
  $priority = 15,
  $includepkgs = undef
) {
  Class['yum::repo::rpmforge'] <- Class['yum']

  yum::repo{'rpmforge':
    descr => "RPMForge RHEL$releasever packages",
    baseurl => 'http://wftp.tu-chemnitz.de/pub/linux/dag/redhat/el$releasever/en/$basearch/dag',
    enabled => 1,
    priority => $priority,
    gpgcheck => 1,
    includepkgs => $includepkgs,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag',
  }
}
