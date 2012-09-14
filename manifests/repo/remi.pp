class yum::repo::remi(
  $priority = 100,
  $includepkgs = undef
) {
  Class['yum::repo::remi'] <- Class['yum']

  yum::repo{'remi':
    descr => 'Les RPM de remi pour Enterpise Linux $releasever - $basearch',
    baseurl => 'http://rpms.famillecollet.com/el$releasever.$basearch/',
    enabled => 1,
    priority => $priority,
    gpgcheck => 1,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
    includepkgs => $includepkgs,
  }
}
