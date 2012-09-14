class yum::repo::atrpms(
  $priority = 30,
  $includepkgs = undef
) {
  Class['yum::repo::atrpms'] <- Class['yum']

  yum::repo{'atrpms':
    descr => 'CentOS $releasever - $basearch - ATrpms',
    baseurl => 'http://dl.atrpms.net/el$releasever-$basearch/atrpms/stable',
    enabled => 1,
    priority => $priority,
    gpgcheck => 0,
    includepkgs => $includepkgs,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY.atrpms',
  }
}
