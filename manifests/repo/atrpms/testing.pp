class yum::repo::atrpms::testing(
  $priority = 30,
  $includepkgs = undef
) {
  include yum
  yum::repo{'atrpms-testing':
    descr => 'CentOS $releasever - $basearch - ATrpms - Testing',
    baseurl => 'http://dl.atrpms.net/el$releasever-$basearch/atrpms/testing',
    enabled => 1,
    priority => $priority,
    gpgcheck => 0,
    includepkgs => $includepkgs,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY.atrpms',
  }
}
